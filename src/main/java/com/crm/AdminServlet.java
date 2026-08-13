package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // 📊 Total Users
            PreparedStatement ps1 = conn.prepareStatement("SELECT COUNT(*) FROM users");
            ResultSet rs1 = ps1.executeQuery();
            rs1.next();
            request.setAttribute("totalUsers", rs1.getInt(1));

            // 📊 Total Active Users
            PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE status='active'");
            ResultSet rs2 = ps2.executeQuery();
            rs2.next();
            request.setAttribute("activeUsers", rs2.getInt(1));

            // 📊 Total Admins
            PreparedStatement ps3 = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE role='admin'");
            ResultSet rs3 = ps3.executeQuery();
            rs3.next();
            request.setAttribute("totalAdmins", rs3.getInt(1));

            // 👥 Fetch All Users
            PreparedStatement ps4 = conn.prepareStatement("SELECT * FROM users");
            ResultSet rs4 = ps4.executeQuery();
            request.setAttribute("users", rs4);

            request.getRequestDispatcher("admin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}