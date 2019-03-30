/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package newpackage;

/**
 *
 * @author acer
 */
import java.sql.*;

public class SubmissionsList {

//    String driverName = "com.mysql.jdbc.Driver";
//    String url = "jdbc:mysql://localhost:3306/onlinejudge";
//    String dbuser = "root";
//    String dbpassword = "farabi";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    Statement st = null;

    public ResultSet generateList() {
        try {
//            Class.forName(driverName);
//            con = DriverManager.getConnection(url, dbuser, dbpassword);
            con = ConnectionManager.startConnection(con);
            String sql = "Select * from submissiondatabase order by ID desc";
            
            ps = con.prepareStatement(sql);
            
            rs = ps.executeQuery();
        } catch (Exception e) {

        }
        return this.rs;
    }
    
        public ResultSet generateOwnList(String name) {
        try {
            con = ConnectionManager.startConnection(con);
            String sql = "Select * from submissiondatabase where User = ? order by ID desc";
            
            ps = con.prepareStatement(sql);
            ps.setString(1,name);
            rs = ps.executeQuery();
        } catch (Exception e) {

        }
        return this.rs;
    }

    public boolean stopCon() {
        try {
            this.ps.close();
            this.rs.close();
            this.con.close();
        } catch (Exception e) {
              return false;
        }
        return true;
    }

}
