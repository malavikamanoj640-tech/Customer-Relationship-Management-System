package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        final String fromEmail = "yourmail@gmail.com";
        final String password = "your password";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

        try {

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(fromEmail));
            msg.setSubject("Customer Feedback: " + subject);

            msg.setText("Name: " + name +
                    "\nEmail: " + email +
                    "\n\nMessage:\n" + message);

            Transport.send(msg);

            request.setAttribute("success", "Message sent successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Email sending failed.");
        }

        request.getRequestDispatcher("contact.jsp")
                .forward(request, response);
    }
}
