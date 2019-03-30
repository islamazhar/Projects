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
                <li><a href="../../welcome.jsp" title="Home">home</a></li>
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
                <h5>Problem Statement</h5>
				<p>
				   Farabi's girlfriend has forbade Farabi seriously not eat more than one food item for dinner . One night Farabi goes to his friends house and  saw various food iteams on the dinner table . Farabi wants to eat as much possible as possbile without breaking his girlfriend's  order . Help him .  
			</p>
			<br>
			</br>
			<h5>
				INPUT:
			</h5>
			<p>
				First line of the input T is the number of testcases to follow  . Next there will be T scenario . Each scenario starts with N the number of food items on the dinner table . Then there will be N food iteams . each food iteam is denoted by a distinct number. It is ensured that N < 1000
			</p>
			<h5> OUTPUT: </h5>
			<p>
			    For each scenario give a  number the maximum number of food farabi can vanish.
			<p>
			<h5>
				SAMPLE INPUT:
			</h5>
			<p>
					1<br>
					9<br>
					2<br>
					7<br>
					3<br>
					7<br>
					7<br>
					3<br>
					7<br>
					5<br>
					7<br>
			</p>
			<h5>
				SAMPLE OUTPUT:
			</h5>
			<p>
				5
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