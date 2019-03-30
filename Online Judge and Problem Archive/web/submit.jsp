<%-- 
    Document   : index
    Created on : Feb 27, 2014, 1:25:32 AM
    Author     : acer
--%>
<%@page import= "newpackage.*"%>
<%@page import = "java.sql.*"%>
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
                <li><a href="welcome.jsp" title="Home">home</a></li>
                <li><a href="problems.jsp" title="Problems">problems</a> </li>
                <li><a href="submit.jsp" title="submit" class="hover">submit solution</a></li>
                <li><a href="showSubmissions.jsp" title="submissions">submissions</a></li>
                <li><a href="logout.jsp" title="Logout">logout</a></li>  

            </ul>
        </div>

        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>
                <br>
                <br>
                <h2> submit </h2>
                <br>
                <form action="nonfilesubmission.jsp" method="post" class="registration">
                    <table>
                        <col width="100px">
                        <col width="400px">
                        <tr>
                            <td><label for="language">Language:</label></td>
                            <td>
                                <select name="language">
                                    <option value="Cpp">Cpp</option>
                                    <option value="Java">Java</option>
                                </select>
                            </td>                        
                        </tr>
                        <tr>
                            <td><label for="problemid"> Problem ID: </label></td>
                            <td> <input type="text" name="problemid" /> </td>                            
                           <!-- <td> <select name="problemid"> 
                                    <%
//                                        Problem pb = new Problem();
//                                        ResultSet rs = pb.generateList();
//                                        while (rs.next()) {
//                                            String id = rs.getString("id");
//                                            String name = rs.getString("name");

                                    %>

                                    <option value="<%//out.println(id);%>" > <%//out.println(id + "-" + name);%> </option>

                                    <%//}%>
                                </select>                           
                            </td>-->


                        </tr>

                        <%
//                            rs.close();
//                            pb.stopCon();
                        %>
                        <tr>
                            <td><label for="code">Your Code:</label></td>                            
                            <td><textarea rows="10" cols="40" name="code"></textarea></td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" value="submit" />
                                <input type="reset" value ="reset" />

                            </td>
                        </tr>

                    </table>                                                        
                </form>
            </div>



        </div>
        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <ul>
                    <!--                <li><a href="welcome.jsp" title="Home" class="hover">home</a></li>
                                    <li><a href="problems.jsp" title= "problems">problems</a> </li>
                                    <li><a href="logout.jsp" title= "logout">logout</a></li>-->

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