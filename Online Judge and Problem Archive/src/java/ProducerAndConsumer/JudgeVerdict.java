/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ProducerAndConsumer;

/**
 *
 * @author verb
 */

public class JudgeVerdict 
   {
    public String submissionId;
    public String userName;
    public String verdict;
    public String compilationLog;
    public String problemDirectory;
    
    public  JudgeVerdict(String _submissionId,String _userName,String _verdict,String _compilationLog,String _problemDirectory)
        {
            submissionId = _submissionId;
            userName = _userName;
            verdict = _verdict;
            compilationLog = _compilationLog;
            problemDirectory = _problemDirectory;
        }

    
    }
