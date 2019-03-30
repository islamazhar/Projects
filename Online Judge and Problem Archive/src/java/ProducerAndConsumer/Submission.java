/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ProducerAndConsumer;

/**
 *
 * @author verb
 */
public class Submission 
   {

    public String userName;
    public String problemDirectory;
    public long timeOut;
    public String judgeFileDirectory;
    public String languageOfSubmission;
    public String submissionId;

    public Submission(String _submissionId, String _userName, String _problemDirectory, long _timeout, String _judgeFileDirectory, String _languageOfSubmission) 
       {
           submissionId = _submissionId;
           userName = _userName;
           problemDirectory = _problemDirectory;
           timeOut = _timeout;
           judgeFileDirectory = _judgeFileDirectory;
           languageOfSubmission = _languageOfSubmission;
       }

    }
