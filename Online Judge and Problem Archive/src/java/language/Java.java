/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package language;

/**
 *
 * @author verb
 */
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.tools.*;
import ProducerAndConsumer.*;

/**
 *
 * @author verb
 */
public class Java implements Language {

    public JudgeVerdict newJudgeVerdict;
    public Submission newSubmission;

    public Java(Submission _newSubmission, JudgeVerdict _newJudgeVerdict) {
        newSubmission = _newSubmission;
        newJudgeVerdict = _newJudgeVerdict;
        newSubmission.timeOut *= 3;

    }

    @Override
    public synchronized JudgeVerdict getVerdict() {
        compile();
        if (newJudgeVerdict.verdict.equals("Compilation Error")) {
            return newJudgeVerdict;
        }
        execute();
        if (newJudgeVerdict.verdict.equals("Runtime Error")) {
            return newJudgeVerdict;
        }
        if (newJudgeVerdict.verdict.equals("Time Limit Exceeded")) {
            return newJudgeVerdict;
        }
        check();
        return newJudgeVerdict;
    }

    @Override
    public void compile() {

        String fileToCompile = newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\Main.java";
        JavaCompiler javaCompiler = ToolProvider.getSystemJavaCompiler();
        try {

            FileOutputStream errorStream = new FileOutputStream(newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId + "\\error.txt");
            javaCompiler.run(null, null, errorStream, fileToCompile);
            File file = new File(newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId + "\\error.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(new DataInputStream(new FileInputStream(file))));
            StringBuilder log = new StringBuilder("");
            String line = null;
            while (true) {
                try {
                    line = reader.readLine();
                } catch (IOException ex) {
                    Logger.getLogger(Java.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (line == null) {
                    break;
                }
                log.append(line + "\n");

            }
            newJudgeVerdict.compilationLog = log.toString();

            if (newJudgeVerdict.compilationLog.contains("error")) {
                TxtToHTML.createHTML(file.toString());
                newJudgeVerdict.verdict = "Compilation Error";
            }
            reader.close();
        } catch (Exception ex) {
            Logger.getLogger(Java.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public void execute() {
        long exitVal = 0x0;
        Process p = null;
        try {
            ProcessBuilder pb = new ProcessBuilder();
            
            pb.directory(new File(newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId));            
            pb.redirectInput(new File(newSubmission.problemDirectory + "\\in.txt"));
            pb.redirectOutput(new File(newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId + "\\OutTemp.txt"));            
            pb.redirectError(new File(newSubmission.judgeFileDirectory+"\\"+newJudgeVerdict.submissionId+"\\execError.txt"));
            
            pb.command("java", "-classpath",newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId,"Main");
            
            p = pb.start();

            long startTime = System.currentTimeMillis();
            while (true) {
                long endTime = System.currentTimeMillis();
                long totalTime = endTime - startTime;
                if (totalTime > newSubmission.timeOut) {
                    break;
                }
            }

            exitVal = p.exitValue();

        } catch (RuntimeException E) {
            exitVal = 0x00000002;
            p.destroy();

        } catch (IOException E) {
                
        }

        if (exitVal == 1) {
            newJudgeVerdict.verdict = "Runtime Error";
        } else if (exitVal == 2) {
            newJudgeVerdict.verdict = "Time Limit Exceeded";
        }

    }

    @Override
    public void check() {
        try {
            boolean checked = false;
            String judgeOutput = newSubmission.problemDirectory + "\\out.txt";
            String userOutput = newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\OutTemp.txt";
            String judge = readFromFile(judgeOutput);
            String user = readFromFile(userOutput);
            if (judge.equals(user)) {
                checked = true;
            }
            newJudgeVerdict.verdict = (checked) ? "Accepted" : "Wrong Answer";
        } catch (Exception ex) {
            System.out.println("in check() function");

        }

    }

    public void clearFile() {
        try {

            Files.deleteIfExists(Paths.get(newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId + "\\Main.class"));

        } catch (IOException ex) {
            //System.out.println("error in deleting java files");
            Logger.getLogger(Cpp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static String readFromFile(String errfilename) {
        String line = "";
        StringBuilder sb = new StringBuilder();

        try {
            BufferedReader br = new BufferedReader(new FileReader(errfilename));
            line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append("\n");
                line = br.readLine();
            }
            br.close();
        } catch (Exception e) {
            System.out.println("error reading from file " + errfilename);
        }
        return sb.toString().trim();

    }

}
