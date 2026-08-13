package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import util.DBConnection;

@WebServlet("/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = DBConnection.getConnection();

            // Check current password
            ps = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, currentPassword);
            rs = ps.executeQuery();

            if(rs.next()) {

                // Update password
                ps = conn.prepareStatement("UPDATE users SET password=? WHERE username=?");
                ps.setString(1, newPassword);
                ps.setString(2, username);
                ps.executeUpdate();

                // Send email notification
                sendEmail(rs.getString("email"), username);

                request.setAttribute("success", "Password updated successfully!");
            } else {
                request.setAttribute("error", "Current password incorrect!");
            }

        } catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong!");
        }

        request.getRequestDispatcher("changePassword.jsp")
                .forward(request, response);
    }

    private void sendEmail(String toEmail, String username) {

        final String fromEmail = "malavikamanoj640@gmail.com";
        final String password = "your_app_password";

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
            msg.setSubject("ShopEasy Password Updated");

            msg.setText("Hello " + username +
                    ",\n\nYour password has been successfully updated." +
                    "\nIf this was not you, contact support immediately.");

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}