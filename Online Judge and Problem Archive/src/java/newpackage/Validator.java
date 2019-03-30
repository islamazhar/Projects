/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package newpackage;

import org.apache.commons.validator.routines.*;
/**
 *
 * @author acer
 */
public class Validator {
    public static boolean validateName(String s){
        if (s.contains(" ")|| s.matches(".*\\d.*")) return false;        
        else return true;
    }
    public static boolean validatePass(String s){
        if(s.length()>0) return true;
        else return false;
    }
    public static boolean validateEmail(String s){
        if (EmailValidator.getInstance().isValid(s))return true;
        else return false;
    }
}
