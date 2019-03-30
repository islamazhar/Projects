<%-- 
    Document   : verifyPage
    Created on : Feb 8, 2014, 3:46:07 PM
    Author     : acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String username = session.getAttribute("name").toString();
        String utype = session.getAttribute("usertype").toString();
        String ustatus = session.getAttribute("status").toString();
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <link rel="icon" href="images/favicon.ico">
        <title>Welcome || <%out.println(username); %> </title>
    </head>
    <body>
        <div id="topNav">	
            <ul>
                <li><a href="index.jsp" title="Home" class="hover">home</a></li>
                <li><a href="Contact.jsp" title="Contact">contact</a></li>
                <li><a href="logout.jsp" title="Logout">logout</a></li>
            </ul>
        </div>


        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />
            <div class='bodyText'>
                <br class="spacer">

                <h2>  <% out.println("Welcome " + "  " + username); %> </h2>
                <h5> <% if(utype.equals("admin")) out.println("You are logged in as an "+utype); 
                else out.println("You are logged in as a user"); %> 
                
                
                </h5>

                <p>
                    <% if (ustatus == "wait") 
                        {
                            out.println("Your account is not verified, please enter the verification code sent in your mail:");
                        }
                    %> 
                </p>
                <form action="verify.jsp" method="POST" class="registration">
                    <table border="1">
                        <tr>
                            <td>Enter Verification Code: </td>
                            <td><input type="text" name="vcode"/> </td>
                        </tr>
                        <tr> 
                            <td></td>
                            <td align="center">
                                <input type="submit" value="verify"/>
                            </td>
                        </tr>
                    </table>

                </form>              

                <%session.setAttribute("name", username);%>
            </div>
        </div>

        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <ul>
                    <li><a href="index.jsp" title="Home">home</a>|</li>
                    <li><a href="contact.jsp" title="Contact">contact</a></li>
                </ul>
                <p align='center'>&copy;Online Problem Archive and Judge</p>
                <p align='center'> All rights reserved. </p>
                <br class="spacer" />
            </div>
        </div>
    </body>


</html>
