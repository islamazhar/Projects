/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package multithreading;

/**
 *
 * @author verb
 */
import ProducerAndConsumer.*;
import static java.lang.System.exit;
import java.sql.*;
import newpackage.*;

public class SQLandItsOperations {

    public String username;
    public String password;
    public String url;
    public String driverName = "com.mysql.jdbc.Driver";

    public Connection connection;
    public Statement statement;
    public ResultSet resultset;
    public Submission submission;
    public PreparedStatement preparedStatement;

    public SQLandItsOperations(String submissionID) {
        try {
            connection = ConnectionManager.startConnection(connection);
            String sql = new String("SELECT * FROM submissiondatabase where ID = ?");
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, submissionID);
            resultset = preparedStatement.executeQuery();
        } catch (SQLException e) {
        }

    }

    public Submission getQueries() {
        try {
            if (resultset.first()) {
                String submissionID = resultset.getString("ID");
                String submissionUser = resultset.getString("User");
                String submissionProblemDir = "I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\Problems\\" + resultset.getString("ProblemID");
                String submissionJudgeFileDir = "I:\\java\\projects\\web\\project\\FinalOnlineJudge\\web\\Users\\" + resultset.getString("User");
                String submissionLanguage = resultset.getString("Language");
                long t = 3000;

                submission = new Submission(submissionID, submissionUser, submissionProblemDir, t, submissionJudgeFileDir, submissionLanguage);

            } else {
                System.out.println("Waiting for Query");
                
                //exit(0);
            }
            return submission;
        } catch (SQLException e) {
            System.out.println("error in SQLquerries");
            //e.printStackTrace();
            return submission;
        } catch (NullPointerException e) {
            System.out.println("null pointer");
            return submission;
        }
    }

    public void updateDatabase(JudgeVerdict judgeVerdict) {
        try {
            String sql = new String("UPDATE submissiondatabase SET Verdict = ? WHERE ID=?");
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, judgeVerdict.verdict);
            preparedStatement.setString(2, judgeVerdict.submissionId);
            preparedStatement.executeUpdate();
            preparedStatement.closeOnCompletion();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
