<%-- 
    Document   : NonFileSubmission
    Created on : Feb 20, 2014, 2:28:41 AM
    Author     : acer
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="newpackage.*"%>
<%@page import="multithreading.*"%>

<!DOCTYPE html>
<html>
    <head>
        <title>NonFileSubmission</title>
    </head>

    <body>
        <% synchronized (this) {
                String uid = session.getAttribute("name").toString();
                String pid = request.getParameter("problemid");
                String userData = request.getParameter("code");
                String userLanguage = request.getParameter("language");
                String baseURL = "I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\Users";
                if (!userData.equals("") && !pid.equals("")) {
                    String submissionID = null;

                    submissionID = new SubmissionIDGenerator().SubmissionIDGenerator();

                    String folderURL = baseURL + "\\" + uid;

                    File folder = new File(folderURL);
                    folder.mkdirs();

                    folderURL = folderURL + "\\" + submissionID + "\\";
                    folder = new File(folderURL);
                    folder.mkdirs();

                    String saveFile = folderURL + "Main." + userLanguage;
                    File userFile = new File(saveFile);
                    FileOutputStream is = new FileOutputStream(userFile);
                    OutputStreamWriter osw = new OutputStreamWriter(is);
                    Writer w = new BufferedWriter(osw);
                    w.write(userData);
                    w.close();

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    String sql = "insert into submissiondatabase (ID,User,ProblemID,Language,Verdict) values(?,?,?,?,?)";
                    try {
                        con = ConnectionManager.startConnection(con);
                        ps = con.prepareStatement(sql);
                        ps.setString(1, submissionID);
                        ps.setString(2, uid);
                        ps.setString(3, pid);
                        ps.setString(4, userLanguage);
                        ps.setString(5, "waiting");
                        ps.executeUpdate();
                        ps.close();
                        con.close();
                        ConnectionManager.stopConnection(con);

                    } catch (Exception e) {
                        session.setAttribute("errorReport", "Error in the submission, please try again");

                    }
                    
                    MultiThreading mt = new MultiThreading(submissionID);                    
                    

                    response.sendRedirect("showSubmissions.jsp");
                } else {
                    response.sendRedirect("submit.jsp");
                }
            }
        %>


    </body>
</html>
