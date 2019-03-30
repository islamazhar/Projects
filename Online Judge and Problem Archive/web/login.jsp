<%@page import="newpackage.ConnectionManager"%>
<%@page import="newpackage.MD5HashGenerator"%>
<%@page import="newpackage.gmailEmail"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import = "java.security.MessageDigest" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Login</title>
    </head>
    <body>
        <%  String userdbName;
            String userdbPsw;
            String dbUsertype;
            String dbUserEmail;
            String dbUserVerCode;
            
            String dbVC;

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String sql = "select * from userdatabase where name=? and password=?";

            String name = request.getParameter("name");
            String psw = request.getParameter("password");
//            String utp = request.getParameter("usertype");
            String userstatus ;
            
            MD5HashGenerator md = new MD5HashGenerator();
            String mdPass = md.MD5HashGenerate(psw);

            if ((!(name.equals(null) || name.equals("")) && !(psw.equals(null) || psw.equals("")))) {
                try {
                    //Class.forName(driverName);
                    //con = DriverManager.getConnection(url, user, dbpsw);
                    
                    con = ConnectionManager.startConnection(con);
                    ps = con.prepareStatement(sql);
                    ps.setString(1, name);
                    ps.setString(2, mdPass);
                    rs = ps.executeQuery();
                    if (rs.next()) 
                    {
                        userdbName = rs.getString("name");
                        userdbPsw = rs.getString("password");
                        dbUsertype = rs.getString("usertype");
                        userstatus = rs.getString("status");

                        dbUserEmail = rs.getString("email");
                       // dbUserVerCode = rs.getString("verCode");
                        if (name.equals(userdbName) && mdPass.equals(userdbPsw)) 
                        {
                            session.setAttribute("name", userdbName);
                            session.setAttribute("usertype", dbUsertype);
                            //session.setAttribute("vc",dbVC);
                            session.setAttribute("status",userstatus);
                            if(userstatus.equals("wait"))
                            {
                                //gmailEmail gm = new gmailEmail();
                                //gm.sendMail("farabi.phoenix.com", dbUserEmail, userdbName, dbUserVerCode );
                                response.sendRedirect("verifyPage.jsp");
                            }
                            else if (userstatus.equals("okay")) {
                                session.setAttribute("usertype", dbUsertype);
                                session.setAttribute("status","okay");
                                response.sendRedirect("welcome.jsp");
                            }
                            else response.sendRedirect("index.jsp");
                        }
                    } else {
                        
                        %>
                        
                        <h4 align="center" style="color:red">Username/Password Mismatch</h4>
                      
                        <%  getServletContext().getRequestDispatcher("/index.jsp").include(request,response);
                    }
                } catch (SQLException sqe) {
                    out.println(sqe);
                }
                ConnectionManager.stopConnection(con);
            } 
            else {
        %>
        <center><h4 style="color:red">Error In Login</h4></center>
            <%
                    getServletContext().getRequestDispatcher("/index.jsp").include(request, response);
                }
            %>
    </body>
</html>