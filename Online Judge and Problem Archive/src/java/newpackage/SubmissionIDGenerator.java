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

public class SubmissionIDGenerator {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String ID = null;

    String sql = "select * from submissiondatabase";
    public String SubmissionIDGenerator(){
        try{
//            Class.forName(driverName);
            con = ConnectionManager.startConnection(con);
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if(rs.last()){
                this.ID = rs.getString("ID");
                int value = Integer.parseInt(this.ID);
                value +=1;
                this.ID = Integer.toString(value);
            }else{
                this.ID = "1";
            }
        }catch(Exception e){
            //e.printStackTrace();
        }
        
        ConnectionManager.stopConnection(con);
        return this.ID;
        
    }

}
