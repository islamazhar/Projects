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
import ProducerAndConsumer.*;


/**
 *
 * @author verb
 */
public class Cpp implements Language 
   {

    public JudgeVerdict newJudgeVerdict;
    public Submission newSubmission;

    public Cpp(Submission _newSubmission, JudgeVerdict _newJudgeVerdict)
       {
        newSubmission = _newSubmission;
        newJudgeVerdict = _newJudgeVerdict;

       }

    @Override
    public synchronized JudgeVerdict getVerdict() 
       {
        compile();
        if (newJudgeVerdict.verdict.compareTo("Compilation Error") == 0) 
         {
            return newJudgeVerdict;
         }
        execute();
        if (newJudgeVerdict.verdict.compareTo("Runtime Error") == 0) 
         {
            return newJudgeVerdict;
         }
        if (newJudgeVerdict.verdict.compareTo("Time Limit Exceeded") == 0)
         {
            return newJudgeVerdict;
         }

        check();
        return newJudgeVerdict;
       }

    @Override
    public void compile()
      {
        try {
            String line = null;
            StringBuilder compilation = new StringBuilder();
            Process process = null;

            String CompilerfileName = "C:\\Program Files\\CodeBlocks\\MinGW\\bin\\g++";
            String cppFileName = newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\Main.Cpp";
            String execFileName = newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId + "\\Main.exe";
            String errorFileName = newSubmission.judgeFileDirectory + "\\" + newJudgeVerdict.submissionId + "\\error.txt";
            ProcessBuilder pb = new ProcessBuilder(CompilerfileName, cppFileName, "-o", execFileName);
            pb.redirectError(new File(errorFileName));

            process = pb.start();
            process.waitFor();

            BufferedReader reader = new BufferedReader(new FileReader(new File(errorFileName)));

            line = reader.readLine();
            while (line != null) 
                {
                compilation.append(line + "\n");
                line = reader.readLine();
                }
            newJudgeVerdict.compilationLog = compilation.toString();
            if (newJudgeVerdict.compilationLog.equals("") == false)
                {
                 newJudgeVerdict.verdict = "Compilation Error";
                 //TxtToHTML.createWebHTML(errorFileName, newSubmission.submissionId);
                 TxtToHTML.createHTML(errorFileName);
                 
                }
            reader.close();
            

           }
        catch (InterruptedException | IOException ex) 
           {

           }
         
    }

    @Override
    public void execute() 
        {
        long exitVal = 0x0;
        Process p = null;
        try {
            ProcessBuilder pb = new ProcessBuilder(newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\Main.exe");
            pb.redirectInput(new File(newSubmission.problemDirectory + "\\in.txt"));
            File file = new File(newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\outtemp.txt");
            file.createNewFile();
            pb.redirectOutput(file);
            p = pb.start();

            long startTime = System.currentTimeMillis();
            while (true)
                {
                long endTime = System.currentTimeMillis();
                long totalTime = endTime - startTime;
                if (totalTime > newSubmission.timeOut) 
                    {
                    break;
                    }
                }
            exitVal = p.exitValue();
            System.out.println(exitVal);

           }
        catch (RuntimeException E) 
            {
            exitVal = 0x00000001;
            p.destroy();

            }
        catch (IOException E) 
            {

            }
        //System.out.println(exitVal+"exit value");
        if (exitVal == 0xC0000094)
            {
            newJudgeVerdict.verdict = "Runtime Error";
            }
        else if (exitVal == 0x00000001) 
            {
            newJudgeVerdict.verdict = "Time Limit Exceeded";
            }

    }

    @Override
    public void check()
        {
        try {
            boolean checked = false;
            String judgeOutput = newSubmission.problemDirectory + "\\out.txt";
            String userOutput = newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\outtemp.txt";
            String judge = readFromFile(judgeOutput);
            String user = readFromFile(userOutput);
            if (judge.equals(user)) checked = true;
            newJudgeVerdict.verdict = (checked) ? "Accepted" : "Wrong Answer";
          }
        catch (Exception ex)
          {
            System.out.println("in check() function");

           }

        }

    public static String readFromFile(String errfilename) 
       {
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
        }
        catch (Exception e)
           {
           System.out.println("error reading from file "+ errfilename);
           }
        return sb.toString().trim();

      }

    @Override
    public void clearFile() 
        {
        try {

            Files.deleteIfExists(Paths.get(newSubmission.judgeFileDirectory + "\\" + newSubmission.submissionId + "\\Main.exe"));
        
            }
        catch (IOException ex) 
            {
            Logger.getLogger(Cpp.class
                    .getName()).log(Level.SEVERE, null, ex);
            }

        }
}
