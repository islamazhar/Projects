<%-- 
    Document   : index
    Created on : Feb 27, 2014, 1:25:32 AM
    Author     : acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="newpackage.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/favicon.ico">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>Online Judge</title>
<%
    Initiator init = new Initiator("Setup.ini");
%>
    </head>
    <body>
        
        
        <div id="topNav">	
            <ul>
                <li><a href="index.jsp" title="Home" class="hover">home</a></li>
                <li><a href="Contact.jsp" title="Contact">contact</a></li>

            </ul>
        </div>

        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>
                <br>
                <br>
                <h2> welcome </h2>
                <p> <strong>Online Problem Archive & Judge </strong> showcases the problems for all level of computer 
                    programmers. They can submit the solutions of the problems and get the verdicts.
                    <br>
                    <br> This project was made under the supervision of:
                    <br> <strong> Mohammad Saifur Rahman,</strong>
                    <br> Department of Computer Science & Engineering,
                    <br> Bangladesh University of Engineering & Technology, BUET.
                </p>
            </div>


            <div style='position:absolute; top:390px; right:300px;'> 
                <form method="post" action="login.jsp" name="login" class="login">
                    <h2>Members login</h2>
                    <label>Username</label><input name="name" type="text" tabindex="1" id="name" /><br class="spacer" />
                    <label>Password</label>
                    <input name="password" type="password" tabindex="2" id="password" />
                    <br class="spacer" />
                    <input name="" type="image" src="images/login_btn.gif" tabindex="3" title="Login" class="loginBtn" />
                </form>
                <a href="register.jsp">Need an account?</a>
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