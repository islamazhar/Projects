/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package newpackage;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author acer
 */
public class MD5HashGenerator {

    public String MD5HashGenerate(String msg) {
        String plaintext = msg;
        try {
            MessageDigest m = MessageDigest.getInstance("MD5");

            m.reset();
            m.update(plaintext.getBytes());
            byte[] digest = m.digest();
            BigInteger bigInt = new BigInteger(1, digest);
            String hashtext = bigInt.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();

        }
        return null;
    }
}
