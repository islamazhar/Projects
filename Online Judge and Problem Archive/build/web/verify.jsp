<%@page import="newpackage.ConnectionManager"%>
<%@page import="newpackage.MD5HashGenerator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import = "java.security.MessageDigest" %>
<html>
    <head>
        <title>Verify</title>
    </head>
    <body>
        <%  String userdbName;
            String userdbPsw;
            String userdbVerCode;
            String userdbStatus;
            String userdbUserType;

            Connection con = null;
            PreparedStatement ps = null, ps2 = null;
            ResultSet rs = null, rs2 = null;

//            String driverName = "com.mysql.jdbc.Driver";
//            String url = "jdbc:mysql://localhost:3306/onlinejudge";
//            String user = "root";
//            String dbpsw = "farabi";

            String name = session.getAttribute("name").toString();
            String utype = session.getAttribute("usertype").toString();
            String ustatus = session.getAttribute("status").toString();
            String verificationCode = request.getParameter("vcode");

            String sql = "select * from userdatabase where name=?";
            String sql2 = "update userdatabase set status= ? where name= ?;";

            if (!(verificationCode.equals(null)) || verificationCode.equals("")) {
                try {
//                    Class.forName(driverName);
//                    con = DriverManager.getConnection(url, user, dbpsw);
                    con = ConnectionManager.startConnection(con);
                    ps = con.prepareStatement(sql);
                    ps.setString(1, name);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        userdbName = rs.getString("name");
                        userdbUserType = rs.getString("usertype");
                        userdbStatus = rs.getString("status");
                        userdbVerCode = rs.getString("verificationCode");
                        
                        ps.close();

                        if (userdbVerCode.equals(verificationCode)) {
                            session.setAttribute("name", userdbName);
                            if (userdbStatus.equals("wait")) {
                                ps2 = con.prepareStatement(sql2);
                                ps2.setString(1, "okay");
                                ps2.setString(2, name);
                                ps2.executeUpdate();
                                ps2.close();
//                                System.out.println("Debug");
                                
                                //out.println("sucesfull");
                                
                                session.setAttribute("status", "okay");
                                response.sendRedirect("welcome.jsp");
                            }
                        } 
                        else {
                            session.setAttribute("name", name);
                            session.setAttribute("usertype", utype);
                            session.setAttribute("status", "wait");
                            //session.setAttribute("vc", userdbVerCode);
                            response.sendRedirect("verifyPage.jsp");
                        }

        %>

        <h4 align="center" style="color:red">Username/Password Mismatch</h4>

        <%  //getServletContext().getRequestDispatcher("verifyPage.jsp").include(request, response);
                }
            } catch (SQLException sqe) {
                out.println(sqe);
            }
                ConnectionManager.stopConnection(con);
        } else {
        %>
        <center><h4 style="color:red">Error in Verification Code</h4></center>
            <%
                    getServletContext().getRequestDispatcher("/verifyPage.jsp").include(request, response);
                }
            %>
    </body>
</html>