package newpackage;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class gmailEmail {

    public static void sendMail(String to, String User, String code) {
        final String username = "farabi.phoenix@gmail.com";
        final String password = "huduvkkkraoomkcm";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject("Registration at Online Judge");
            message.setText("Dear "+User+ " \n\n Thank you for registering at Online Judge. Your verification code is: "+code);

            Transport.send(message);

            //System.out.println("Done");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
//    public static void main(String[] args){
//        
//        gmailEmail gE = new gmailEmail();
//        gE.sendMail("farabi.phoenix@gmail.com", "smfmj01@yahoo.com","farabi","blablabla");
//        
//        
//    }
            

}
