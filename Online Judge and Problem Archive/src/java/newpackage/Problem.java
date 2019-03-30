/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package newpackage;

import java.sql.*;

/**
 *
 * @author acer
 */
public class Problem {
//
//    String driverName = "com.mysql.jdbc.Driver";
//    String url = "jdbc:mysql://localhost:3306/onlinejudge";
//    String dbuser = "root";
//    String dbpassword = "farabi";

    public static String ID = "";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    Statement st = null;

    public ResultSet generateList() {

        try {
            con = ConnectionManager.startConnection(con);

            st = con.createStatement();

            String sql = "select * from problemsdatabase";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

        } catch (Exception e) {

        }
        return rs;
    }

    public boolean stopCon() {
        try {
            this.rs.close();
            this.con.close();
        } catch (Exception e) {
            return false;
        }
        return true;

    }

    public String getProblemID() {
        String sql = "SELECT * FROM problemsdatabase";
        try {
            con = ConnectionManager.startConnection(con);
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if(rs.last()){
                int id = Integer.parseInt(rs.getString("id"));
                id+=1;
                this.ID = Integer.toString(id);
                
            }else{
                this.ID = "1";
            }
        } catch (Exception e) {

        }
        ConnectionManager.stopConnection(con);
        return this.ID;
    }

    public String updateProblemDB(String problemName, String problemID) {

        try {

            con = ConnectionManager.startConnection(con);            
            String dir = "Problems/" + problemID + "/statement.jsp";          
            String sql = "insert into problemsdatabase (id,name,directory,solved,tried) values(?,?,?,?,?);";
            ps = con.prepareStatement(sql);
            ps.setString(1, problemID);
            ps.setString(2, problemName);
            ps.setString(3, dir);
            ps.setString(4,"0");
            ps.setString(5,"0");                    
            ps.executeUpdate();
            ConnectionManager.stopConnection(con);
            return "";

        } catch (Exception e) {
            return e.toString();

        }
        
    }

}
