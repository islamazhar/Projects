/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package language;

import java.io.*;
import java.nio.file.Files;

/**
 *
 * @author acer
 */
public class TxtToHTML {

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
    
    public static boolean createWebHTML(String txtFileName, String submissionID){
        String upperHalf=readFromFile("I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\upperHalf.txt");
        String webBaseURL = "I:\\java\\projects\\web\\project\\FinalOnlineJudge\\build\\web\\Users\\"+submissionID+"\\error.html";
        
        String userData = readFromFile(txtFileName);
        
        String lowerHalf = readFromFile("I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\lowerHalf.txt");
        userData = upperHalf+userData+lowerHalf;
        String htmlFileName = txtFileName.replace(".txt", ".html");
        File copyToBuildWeb = new File(webBaseURL);
        File userFile = new File(htmlFileName);
        try {
            FileOutputStream is = new FileOutputStream(userFile);
            OutputStreamWriter osw = new OutputStreamWriter(is);
            Writer w = new BufferedWriter(osw);
            w.write(userData);
            w.close();
            
            Files.copy(userFile.toPath(), copyToBuildWeb.toPath());
            
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    public static boolean createHTML(String txtFileName) {
        String upperHalf=readFromFile("I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\upperHalf.txt");
        String webBaseURL = "I:\\java\\projects\\web\\project\\FinalOnlineJudge\\build\\web\\";
        String webURL = "";
        String userData = readFromFile(txtFileName);
        
        
        
        webURL = txtFileName.substring(txtFileName.lastIndexOf("Users"));
        
        String folderURL = webBaseURL+webURL.substring(0,webURL.lastIndexOf("error"));
        File folder = new File(folderURL);
        folder.mkdir();

        
        webURL = webBaseURL + webURL;
        webURL = webURL.replace(".txt", ".html");
        
        String lowerHalf = readFromFile("I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\lowerHalf.txt");
        userData = upperHalf+userData+lowerHalf;
        String htmlFileName = txtFileName.replace(".txt", ".html");
        File copyToBuildWeb = new File(webURL) ;
        
        System.out.println(webURL);
        
        File userFile = new File(htmlFileName);
        try {
            FileOutputStream is = new FileOutputStream(userFile);
            OutputStreamWriter osw = new OutputStreamWriter(is);
            Writer w = new BufferedWriter(osw);
            w.write(userData);
            w.close();
            
            Files.copy(userFile.toPath(), copyToBuildWeb.toPath());
            
            return true;

        } catch (Exception e) {
            return false;
        }
    }
    
//    public static void main(String[] args){
//        createHTML("I:\\java\\projects\\web\\Last\\FinalOnlineJudge\\web\\Users\\farabi\\1\\error.txt");
//    }
}
