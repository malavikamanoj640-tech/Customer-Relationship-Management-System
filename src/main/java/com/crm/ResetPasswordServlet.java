package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        try {

            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE users SET password=?, otp=NULL, otp_expiry=NULL WHERE email=?"
            );

            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rows = ps.executeUpdate();

            if(rows > 0){

                request.setAttribute("message",
                        "Password updated successfully. Please login.");

                request.getRequestDispatcher("login.jsp")
                        .forward(request,response);

            }
            else{

                request.setAttribute("message",
                        "Password update failed.");

                request.getRequestDispatcher("resetPassword.jsp")
                        .forward(request,response);
            }

        }
        catch(Exception e){
            e.printStackTrace();
            request.setAttribute("message", e.toString());
            request.getRequestDispatcher("resetPassword.jsp")
                    .forward(request,response);
        }
    }
}