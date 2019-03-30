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
                <h5> Problem Statement:		 </h5>
		<p>
		Farabi wants to give gifts to his N (1 <= N <= 1000) friends, using his total budget of B (1 <= B <= 1,000,000,000) units of money. Friend i requests a gift with a price of P(i) units, and a packing cost of
S(i) units (so the total cost would be P(i)+S(i) for Farabi to order this
gift).  Farabi has a special coupon that he can use to order one gift of his
choosing at only half its normal price.  If Farabi uses the coupon for friend i,
he therefore would only need to pay P(i)/2+S(i) for that friends' gift. 
Conveniently, the P(i)'s are all even numbers.Please help Farabi determine the maximum number of friends to whom he can afford  to give gifts.  
		</p>
		<br>
		<h5>
			INPUT AND OUTPUT:
			</h5>
			<p>
				The first integer is the number of testcases to follow. For each test case the first two integers N and B represents the number of gifts Farabi has to buy and the total budget.Next N lines follows each having two integers representing P[i] and S[i].
				output one line for each test case  the maximum number of friends to whom he can afford  to give gifts.		
				</p>
		<h5>
			SAMPLE INPUT:
		</h5>
		1
		5 24<br>
		4 2<br>
		2 0<br>
		8 1<br>
		6 3<br>
		12 5<br>
		<h5>SAMPLE OUTPUT:</h5>
		4<br>
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