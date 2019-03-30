/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package newpackage;

import java.io.*;
import java.util.StringTokenizer;

/**
 *
 * @author acer
 */


public class Initiator {
    public static String installationFolderURL = "";
    public static String databaseUser ="";
    public static String databasePassword ="";
    
    public Initiator(String FileName){
        String initData = readFromFile(FileName);
        StringTokenizer stk = new StringTokenizer(initData,"\n");
        while(stk.hasMoreTokens()){
            String temp = stk.nextToken();
            if(!temp.contains("Setup Location")) temp = "";
            else {
                installationFolderURL = temp.substring(temp.indexOf("\"")+1, temp.lastIndexOf("\""));
                
                break;                
            }
        }
        stk = new StringTokenizer(initData, "\n");
        while(stk.hasMoreTokens()){
            String temp = stk.nextToken();
            if(!temp.contains("Database User")) temp = "";
            else {
                databaseUser = temp.substring(temp.indexOf("\"")+1, temp.lastIndexOf("\""));
                break;
            } 
        }
        stk = new StringTokenizer(initData, "\n");
        while(stk.hasMoreTokens()){
            String temp = stk.nextToken();
            if(!temp.contains("Database Password")) temp = "";
            else {
                databasePassword = temp.substring(temp.indexOf("\"")+1, temp.lastIndexOf("\""));
                break;
            } 
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
