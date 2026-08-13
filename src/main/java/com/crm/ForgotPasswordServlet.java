package com.crm;

import java.util.Random;
import java.util.UUID;
import java.time.LocalDateTime;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import util.DBConnection;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM users WHERE email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                // Example reset link (simple version)
                Random rand = new Random();
                int otp = 100000 + rand.nextInt(900000);

                PreparedStatement update = conn.prepareStatement(
                        "UPDATE users SET otp=?, otp_expiry=? WHERE email=?");

                update.setString(1, String.valueOf(otp));
                update.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now().plusMinutes(5)));
                update.setString(3, email);

                update.executeUpdate();

                sendEmail(email, otp);

                request.setAttribute("email", email);
                request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
            } else {
                request.setAttribute("message",
                        "Email not registered.");
            }

        } catch(Exception e){
            e.printStackTrace();
            request.setAttribute("message",
                    e.toString());
        }

        request.getRequestDispatcher("forgotPassword.jsp")
                .forward(request, response);
    }

    private void sendEmail(String toEmail, int otp) {

        final String fromEmail = "youremail@gmail.com";
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
                    InternetAddress.parse(toEmail));

            msg.setSubject("CRM Password Reset OTP");

            msg.setText("Your OTP for password reset is: " + otp +
                    "\nThis OTP will expire in 5 minutes.");

            Transport.send(msg);

        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
