package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import util.DBConnection;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Password match check
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("signup.jsp?error=mismatch");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();

            // Check if username OR email exists
            String checkSql = "SELECT * FROM users WHERE username=? OR email=?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, username);
            checkPs.setString(2, email);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("signup.jsp?error=exists");
            } else {
                String insertSql = "INSERT INTO users(username,email,password) VALUES(?,?,?)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setString(1, username);
                insertPs.setString(2, email);
                insertPs.setString(3, password);
                insertPs.executeUpdate();

                response.sendRedirect("login.jsp?success=true");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}