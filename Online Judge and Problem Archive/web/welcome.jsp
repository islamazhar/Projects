<%-- 
    Document   : index
    Created on : Feb 27, 2014, 1:25:32 AM
    Author     : acer
--%>
<%@page import="newpackage.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/favicon.ico">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>Online Judge</title>

    </head>
    <body>
        <%if (session.getAttribute("status").equals("okay")){%>
        <div id="topNav">	
            <ul>
                <li><a href="welcome.jsp" title="Home" class="hover">home</a></li>
                <li><a href="problems.jsp" title="Problems">problems</a> </li>
                <li><a href="submit.jsp" title="submit">submit solution</a></li>
                <li><a href="showSubmissions.jsp" title="submissions">submissions</a></li>
                <li><a href="logout.jsp" title="Logout">logout</a></li>                                
            </ul>
        </div>

        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>
                <br>
                <br>
                <h2> welcome </h2>
                
                <h3>your submissions</h3>
                    <%
                        SubmissionsList SList = new SubmissionsList();
                        ResultSet rs = null;
                        String name = session.getAttribute("name").toString();
                        rs = SList.generateOwnList(name);
                        String id = "";
                        String baseURL = "Users/";
                    %>

                <table>
                    <col width="20px">
                    <col width="180px">
                    <col width="100px">
                    <col width="80px">
                    <col width="150px">

                    <tr>
                        <td>ID</td>
                        <td>Submission Time</td>
                        <td>Problem ID</td>
                        <td>Language</td>
                        <td>Verdict</td>
                    </tr>                        

                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td> <%
                            id = rs.getString("ID");
                        
                        out.println(id);%> </td>
                        <td> <%out.println(rs.getString("SubmissionTime"));%> </td>
                        <td> <%out.println(rs.getString("ProblemID"));%> </td>
                        <td> <%out.println(rs.getString("Language"));%></td>

                        <%
                            String verdict = rs.getString("Verdict");
                            String color = "black";
                            if (verdict.equals("Accepted")) {
                                color = "green";
                            } else if (verdict.equals("Wrong Answer") || verdict.equals("Wrong answer")) {
                                color = "red";
                            } else if (verdict.equals("Time Limit Exceeded")) {
                                color = "blue";
                            } else if (verdict.equals("Runtime Error")) {
                                color = "red";
                            } else if (verdict.equals("Compilation Error")) {
                                color = "orange";
                            }

                        %>
                        <td style="color:<%out.println(color);%>" > <%out.println(verdict);
                        if(verdict.equals("Compilation Error")){ 
                            String URL = baseURL+name+"/"+id+"/error.html";%>
                      
                            <a href="<%out.println(URL);%>">log</a>                      
                            
                            <% }
                        %>  </td>

                    </tr>
                    <%}

                        SList.stopCon();
                    %>


                </table>



            </div>



        </div>
        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <ul>
                    <li><a href="welcome.jsp" title="Home">home</a>|</li>
                    <li><a href="logout.jsp" title="Logout">logout</a></li>

                </ul>
                <p align='center'>&copy;Online Problem Archive and Judge</p>
                <p align='center'> All rights reserved. </p>
                <br class="spacer" />
            </div>
        </div>
        <%}else {
            session.setAttribute("errorReport","user not logged in");
            response.sendRedirect("error.jsp");
        }%>
    </body>
</html>