<%-- 
    Document   : addproblem
    Created on : Mar 20, 2014, 12:46:31 PM
    Author     : acer
--%>
<%@page import="newpackage.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/favicon.ico">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>Add Problems || Online Judge</title>

    </head>
    <body>
        <%if (session.getAttribute("status").equals("okay") && session.getAttribute("usertype").equals("admin")) {%>


        <div id="topNav">	
            <ul>
                <li><a href="welcome.jsp" title="Home" >home</a></li>
                <li><a href="problems.jsp" title="Problems">problems</a> </li>
                <li><a href="addproblem.jsp" title="AddProblems" class="hover">add new problems</a></li>
                <li><a href="logout.jsp" title="Logout">logout</a></li>



            </ul>
        </div>

        <div id="body">
            <img src="images/logo.gif" alt="OnlineJudge" width="309" height="47" border="0" class="logo" />

            <div class='bodyText'>
                <br>
                <br>
                <h2> Add New Problem</h2>

                <p>

                    To submit your own problem and get it uploaded at Online Judge follow the instructions.

                    <br>1. Modify the <strong>statement.jsp</strong> according to your own problem using a text editor (like jEdit/notepad++)
                    <br>2. Modify the <strong>in.txt</strong> and <strong>out.txt</strong> accordingly.
                    <br>3. You must submit your own solution and expected complexity of the Problem.
                    <br>4. Attach necessary media file(s).
                    <br>5. Zip all the files in a <strong>.zip</strong> Archive and rename it according to the problem name.


                    <br class="spacer">
                    <br>
                    <br>
                    Resources: 
                    <br>
                    <a href="template.zip">Template</a>
                    <br>
                    <a href="http://notepad-plus-plus.org/download/v6.5.5.html">Notepad++</a>
                    <br>
                    <a href="http://jedit.org/index.php?page=download">jEdit</a>
                    <br>


                    <br>
                    N:B: Webmaster(s) will hold the authority to exclude or include or modify the problems.

                </p>
                <form class="registration" action="adding.jsp" enctype="multipart/form-data" method="Post">

                    <label for="problemname">Problem Name</label>
                    <input type="text" name ="problemname" required />
                    <br>

                    <label for="problemzip">Problem Zipped Folder </label>                        
                    <input type="file" name="problemzip" required/>
                    <br>

                    <input type="submit" value ="submit" />
                    <input type="reset" value ="reset"/>
                </form>
            </div>



        </div>
        <br class="spacer" />	
        <div id="footer">
            <div class="footer">
                <ul>
                    <li><a href="welcome.jsp" title="Home" >home</a>|</li>
                    <li><a href="problems.jsp" title="Problems">problems</a> |</li>
                    <li><a href="addproblems.jsp" title="AddProblems" class="hover">add new problems</a>|</li>
                    <li><a href="logout.jsp" title="Logout">logout</a></li>


                </ul>
                <p align='center'>&copy;Online Problem Archive and Judge</p>
                <p align='center'> All rights reserved. </p>
                <br class="spacer" />
            </div>
        </div>
        <%} else {
                session.setAttribute("errorReport", "user not logged in");
                response.sendRedirect("error.jsp");
        }%>
    </body>
</html>