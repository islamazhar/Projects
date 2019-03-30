/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package language;

/**
 *
 * @author verb
 */
import ProducerAndConsumer.JudgeVerdict;
public interface Language
 {
  public JudgeVerdict getVerdict();  
  public void compile();
  public void execute();
  public void check();
  public void clearFile();
  
  
 }

