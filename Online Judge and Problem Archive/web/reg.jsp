<%@page import= "newpackage.*"%>
<%@page import = "java.sql.*"%>
<%@page import = "java.security.MessageDigest" %>

<%

    String uname = request.getParameter("name");
    String pwd = request.getParameter("password");
    String utype = request.getParameter("usertype");
    String umail = request.getParameter("email");
    String salt = "farabi";
    String verificationCode = "";
    MD5HashGenerator verification = new MD5HashGenerator();
    verificationCode = verification.MD5HashGenerate(uname + pwd + salt);
    verificationCode = verificationCode.substring(0, 12);
    //out.println("vercode is: "+verCode);

    Connection con = null;
    PreparedStatement ps = null, psCheck = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    Statement st = null;
    String errorReport = "noerror";

    //Class.forName(driverName);
    con = ConnectionManager.startConnection(con);
    st = con.createStatement();

    String sql = "insert into userdatabase (name,password,usertype,email,status,verificationCode) values(?,?,?,?,?,?);";
    String sqlNameCheck = "select * from userdatabase where name= ?";

    if (Validator.validateName(uname) && Validator.validateEmail(umail) && Validator.validatePass(pwd)) {

        try {
            psCheck = con.prepareStatement(sqlNameCheck);
            psCheck.setString(1, uname);
            rs = psCheck.executeQuery();
            rsmd = rs.getMetaData();
            int rows = 0;
            try {
                if (rs.last()) {
                    rows = rs.getRow();
                } else {
                    rows = 0;
                }
            } catch (Exception e) {
                session.setAttribute("errorReport","SQL error");
                response.sendRedirect("contact.jsp");
            }

            if (rows > 0) {
                session.setAttribute("errorReport", "User Name Exists");
                response.sendRedirect("error.jsp");
            } else {

                MD5HashGenerator md = new MD5HashGenerator();
                String md5Pass = md.MD5HashGenerate(pwd);

                ps = con.prepareStatement(sql);
                ps.setString(1, uname);
                ps.setString(2, md5Pass);
                ps.setString(3, utype);
                ps.setString(4, umail);
                ps.setString(5, "wait");
                ps.setString(6, verificationCode);
                ps.executeUpdate();
                ps.close();
                psCheck.close();
                //gmailEmail.sendMail(umail, uname, verificationCode);

                session.setAttribute("name", uname);
                session.setAttribute("usertype", utype);
                session.setAttribute("status", "wait");
                session.setAttribute("vc", verificationCode);
                response.sendRedirect("verifyPage.jsp");
            }
        } catch (SQLException sqle) {

            session.setAttribute("errorReport", sqle.getStackTrace().toString());
            response.sendRedirect("error.jsp");
        }
        ConnectionManager.stopConnection(con);
    } else {
        session.setAttribute("status", "wait");
        if(Validator.validateEmail(umail)==false)session.setAttribute("errorReport", "invalid email");
        else if(Validator.validateEmail(uname)==false)session.setAttribute("errorReport", "invalid name");
        else if(Validator.validateEmail(pwd)==false)session.setAttribute("errorReport", "invalid password");
        response.sendRedirect("error.jsp");
    }
    
%>