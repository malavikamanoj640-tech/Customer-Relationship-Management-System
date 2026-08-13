package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userInput = request.getParameter("userInput");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM users WHERE (username=? OR email=?) AND password=? AND status='active'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userInput);
            ps.setString(2, userInput);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();

                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("role", rs.getString("role"));   // ✅ IMPORTANT

                session.setMaxInactiveInterval(30 * 60);

                // ✅ Redirect based on role
                if ("admin".equals(rs.getString("role"))) {
                    response.sendRedirect("admin");
                } else {
                    response.sendRedirect("index.jsp");
                }

            } else {
                response.sendRedirect("login.jsp?error=true");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}