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

/**
 *
 * @author acer
 */
public class ConnectionManager {

    public static final String dbUserName = "root";
    public static final String dbPassword = "farabi";
    public static final String driverName = "com.mysql.jdbc.Driver";
    public static final String url = "jdbc:mysql://localhost:3306/onlinejudge";
    
    
    public static Connection startConnection(Connection con){
        try{
            Class.forName(driverName);
            con = DriverManager.getConnection(url,dbUserName,dbPassword);
        }catch (Exception e){
            return null;
        }        
        return con;
    }
    
    public static boolean stopConnection(Connection con){
        try{
            con.close();
        }catch(SQLException e){
            return false;
        }
        return true;
    }
}
