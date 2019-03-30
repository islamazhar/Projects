<%-- 
    Document   : index
    Created on : Feb 27, 2014, 1:25:32 AM
    Author     : acer
--%>
<%@page import ="java.sql.*"%>
<%@page import ="newpackage.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/favicon.ico">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>Problems || Online Judge</title>

    </head>
    <body>
                <%if (session.getAttribute("status").equals("okay")){%>


        <div id="topNav">	
            <ul>
                <li><a href="welcome.jsp" title="Home">home</a></li>
                <li><a href="problems.jsp" class="hover">problems</a></li>
                <%if (session.getAttribute("usertype").toString().equals("admin")){%>
                <li><a href="addproblem.jsp">add problems</a></li>
                <%}%>
                <li><a href="submit.jsp" title="submit solution">submit</a></li>
                <li><a href="showSubmissions.jsp" title="submissions">submissions</a></li>
                <li><a href="logout.jsp" title="Logout">logout</a></li>  
            </ul>
        </div>

        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>                
                <br>
                <%
                    Problem pb = new Problem();
                    ResultSet rs = null;
                    rs = pb.generateList();
                    
                %>
                    
                    <table>
                        <col width="50 px">
                        <col width="200 px">
                        <col width="200 px">
                        <tr>
                            <td>ID</td>
                            <td>Problem Name</td>
                            <td>Problem Link </td>
                        </tr>                        
                                            
                    <%
                    while(rs.next()){
                        %>
                        <tr>
                            <td> <%out.println(rs.getString("id"));%> </td>
                            
                            <td> <%out.println(rs.getString("name"));%></td>
                            <td><a href="<%out.println(rs.getString("directory"));%>" > <%out.println(rs.getString("name"));%></a> </td>
                                   
                        </tr>
                    <%}
                    rs.close();
                    pb.stopCon();
                    %>
                                        
                   
                    </table>
                    
                <br>
            </div>



        </div>
        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <ul>
                <li><a href="welcome.jsp" title="Home" class="hover">home</a>|</li>
                <li><a href="problems.jsp" class="hover">problems</a></li>

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