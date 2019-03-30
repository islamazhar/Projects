<%-- 
    Document   : index
    Created on : Feb 27, 2014, 1:25:32 AM
    Author     : acer
--%>

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
        
        
        <div id="topNav">	
            <ul>
                <li><a href="index.jsp" title="Home">home</a></li>
                <li><a href="Contact.jsp" title="Contact">contact</a></li>

            </ul>
        </div>

        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>
                <br>
                <br>
                <h2> error </h2>
                <p>
                    <% out.println(session.getAttribute("errorReport")); %>
                </p>

            </div>


           
        </div>
        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <p align='center'>&copy;Online Problem Archive and Judge</p>
                <p align='center'> All rights reserved. </p>
                <br class="spacer" />
            </div>
        </div>
    </body>
</html>