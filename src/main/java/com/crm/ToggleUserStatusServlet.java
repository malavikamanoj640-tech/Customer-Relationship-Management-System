package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/toggleUser")
public class ToggleUserStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String loggedInEmail = (String) session.getAttribute("email");
        String email = request.getParameter("email");

        // 🚫 Prevent admin from blocking themselves
        if (email.equals(loggedInEmail)) {
            response.sendRedirect("admin");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement ps1 = conn.prepareStatement("SELECT status FROM users WHERE email=?");
            ps1.setString(1, email);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                String currentStatus = rs.getString("status");
                String newStatus = currentStatus.equals("active") ? "blocked" : "active";

                PreparedStatement ps2 = conn.prepareStatement("UPDATE users SET status=? WHERE email=?");
                ps2.setString(1, newStatus);
                ps2.setString(2, email);
                ps2.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin");
    }
}