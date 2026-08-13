package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;
import jakarta.servlet.http.Part;

@WebServlet("/profile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT username, email, phone, address, profile_image FROM users WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("username", rs.getString("username"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phone", rs.getString("phone"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("profile_image", rs.getString("profile_image"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        Part filePart = request.getPart("profile_image");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            String appPath = request.getServletContext().getRealPath("");
            File uploadDir = new File(appPath, "profile_images");
            if (!uploadDir.exists()) uploadDir.mkdirs();

            fileName = email + ".jpg"; // save as email.jpg
            String filePath = new File(uploadDir, fileName).getAbsolutePath();
            filePart.write(filePath);
        }

        try (Connection conn = DBConnection.getConnection()) {
            StringBuilder sql = new StringBuilder("UPDATE users SET ");
            boolean first = true;

            if (password != null && !password.trim().isEmpty()) {
                sql.append("password=?");
                first = false;
            }
            if (phone != null && !phone.trim().isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("phone=?");
                first = false;
            }
            if (address != null && !address.trim().isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("address=?");
                first = false;
            }
            if (fileName != null) {
                if (!first) sql.append(", ");
                sql.append("profile_image=?");
            }

            sql.append(" WHERE email=?");

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int idx = 1;
            if (password != null && !password.trim().isEmpty()) ps.setString(idx++, password);
            if (phone != null && !phone.trim().isEmpty()) ps.setString(idx++, phone);
            if (address != null && !address.trim().isEmpty()) ps.setString(idx++, address);
            if (fileName != null) ps.setString(idx++, "profile_images/" + fileName);

            ps.setString(idx, email);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                session.setAttribute("profileMsg", "✅ Profile updated successfully!");
            } else {
                session.setAttribute("profileMsg", "⚠️ Update failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("profileMsg", "⚠️ Error: " + e.getMessage());
        }

        response.sendRedirect("profile.jsp");
    }
}