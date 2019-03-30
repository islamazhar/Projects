/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package multithreading;

import java.util.logging.Level;
import java.util.logging.Logger;
import ProducerAndConsumer.*;
import language.*;

/**
 *
 * @author verb
 */
public class MultiThreading implements Runnable {

    public Thread t = new Thread(this);
    /**
     * @param args the command line arguments
     */
    
    public static String submissionID = "";
    
    public MultiThreading(String _submissionID){
        this.submissionID = _submissionID;
        t.start();
    }
    
    public synchronized void fetchAndDo() {
        try {

            SQLandItsOperations sqlSolution = new SQLandItsOperations(submissionID);

            synchronized (sqlSolution) {
                Submission submissionToBeJudged = sqlSolution.getQueries();
                try {
                    JudgeVerdict verdictToBeSent = new JudgeVerdict(submissionToBeJudged.submissionId, "", "", "", "");
                    Language languageUsed = null;
                    switch (submissionToBeJudged.languageOfSubmission) 
                    {
                        case "Cpp":
                            Cpp newCppThread = new Cpp(submissionToBeJudged, verdictToBeSent);
                            languageUsed = newCppThread;
                            break;
                        case "Java":
                            Java newJavaThread = new Java(submissionToBeJudged, verdictToBeSent);
                            languageUsed = newJavaThread;
                            break;

                    }

                    verdictToBeSent = languageUsed.getVerdict();
                    sqlSolution.updateDatabase(verdictToBeSent);
                } catch (Exception e) {
                    //System.out.println("Exception has been thrown in the body of Multithreading.fetchAndDo()'s switch case"); 
                }

            }

        } catch (Exception ex) {
            Logger.getLogger(MultiThreading.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public void run() {
        fetchAndDo();

    }

//    public static void main(String[] args) {
//        new MultiThreading().t.start();
//
//    }

}
