<%-- 
    Document   : formsubmission
    Created on : Feb 8, 2014, 4:57:07 PM
    Author     : acer
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="newpackage.*"%>

<html>
    <head>
        <title>New Problem Submission</title>
    </head>
    <body>
        <%

            String uid = session.getAttribute("name").toString();
            String pid = "";
            String problemName = "";
            String baseURL = "I:\\java\\projects\\web\\project\\FinalOnlineJudge\\build\\web";
            String problemsURL = "\\Newproblems";
            

            String contentType = request.getContentType();
            if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                DataInputStream in = new DataInputStream(request.getInputStream());
                int formDataLength = request.getContentLength();
                byte dataBytes[] = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                while (totalBytesRead < formDataLength) {
                    byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                    totalBytesRead += byteRead;
                }
                String file = new String(dataBytes);
                problemName = file.substring(file.indexOf("problemname") + 14);
                problemName = problemName.substring(0, problemName.indexOf("------Web"));
                //problemName.trim();
                String saveFile = problemName.trim()+".zip";
                               
                String fileExtension = file.substring(file.indexOf("filename=\""));
                fileExtension = fileExtension.substring(0, fileExtension.indexOf("\n"));
                fileExtension = fileExtension.substring(fileExtension.lastIndexOf(".") + 1, fileExtension.lastIndexOf("\""));

                //out.println(filename);
                if (fileExtension.equals("zip")) {

                    int lastIndex = contentType.lastIndexOf("=");
                    String boundary = contentType.substring(lastIndex + 1, contentType.length());
                    int pos;
                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    int boundaryLocation = file.indexOf(boundary, pos) - 4;
                    int startPos = ((file.substring(0, pos)).getBytes()).length;
                    int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

                    //saveFile = "I:/java/farabi/" + saveFile;
                    String folderURL = baseURL +problemsURL + "\\" + uid + "\\";
                    File folder = new File(folderURL);
                    folder.mkdirs();
                    saveFile = folderURL + saveFile;
                    out.println(saveFile);
                    File ff = new File(saveFile);
                    FileOutputStream fileOut = new FileOutputStream(ff);
                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.flush();
                    fileOut.close();
                    Problem problemList = new Problem();
                    String problemID = problemList.getProblemID();
                    
                    problemList.updateProblemDB(problemName.trim(), problemID);
                    
                    File outputFolder = new File(baseURL+"\\problems"+"\\"+problemID+"\\");
                    if(!outputFolder.exists()) outputFolder.mkdirs();
                    UnzipArchive.unZipIt(saveFile,outputFolder.toString());
                    
                    
                    response.sendRedirect("welcome.jsp");
                }else{
                    session.setAttribute("errorReport","Error writing problems, please try again");
                    response.sendRedirect("error.jsp");
                }
            }
        %>
        <br>
    </body>
</html>
