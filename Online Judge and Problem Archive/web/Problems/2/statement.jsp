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
        <link rel="icon" href="../../images/favicon.ico">
        <link href="../../style.css" rel="stylesheet" type="text/css" />
        <title>Online Judge</title>

    </head>
    <body>

        <div id="topNav">	
            <ul>
                <li><a href="../../welcome.jsp" title="Home" >home</a></li>
                <li><a href="../../problems.jsp" title="Problems">problems</a></li>
                <li><a href="../../logout.jsp" title = "logout" > logout</a></li>
				<li><a href="../../submit.jsp" title="Submit" >Submit</a></li>
            </ul>
        </div>

        <div id="body">
            <img src="../../images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>
                <br>
                <br>
                <h1 align="center">Welcome To A New World</h1>
		<br>
		</br>
		<h5>
			Problem Statement:
		</h5>
		<p>
			In contest programming world the most frequently used operations are "Addition" , "subtraction" , "Divide" , "Multipication" , "Modulus".The problem is simple.
			You will be given three number A , B , C and you will have to guess the operation such that A (operation) B = C.If there are multiple soultion print all of them.
			In the same order stated above.If there is no operation that satisfies the expression A (operation) B then print "?".See the sample output for exact output format.
			You can always assume  A B C will always fit into 32 bit numbers. 			   
		</p>
		<h5>
			SAMPLE INPUT:
		</h5>
		<p>
			123 34 157 <br>
			123 34 99 <br>
			123 34 4216 <br>
			123 34 21 <br>
			2 2 4
		</p>
		<h5>
			SAMPLE OUTPUT:
		</h5>
		<p>
			Case No: 1 +   <br>
			Case No: 2 -   <br>
			Case No: 3 *   <br>
			Case No: 4 %   <br>
			Case No: 5 + * <br>
		</p>
                
               
            </div>


        </div>
        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <ul>
<!--                    <li><a href="index.jsp" title="Home">home</a>|</li>
                    <li><a href="contact.jsp" title="Contact">contact</a></li>-->
                </ul>
                <p align='center'>&copy;Online Problem Archive and Judge</p>
                <p align='center'> All rights reserved. </p>
                <br class="spacer" />
            </div>
        </div>
    </body>
</html>