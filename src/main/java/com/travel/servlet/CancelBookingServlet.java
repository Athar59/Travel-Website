package com.travel.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.travel.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM bookings WHERE id = ? AND user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            stmt.setInt(2, userId);
            int result = stmt.executeUpdate();
            conn.close();

            if (result > 0) {
                session.setAttribute("message", "Booking canceled successfully.");
            } else {
                session.setAttribute("message", "Failed to cancel booking.");
            }

            response.sendRedirect("booking_history.jsp");
        } catch (Exception e) {
            
            e.printStackTrace();
            session.setAttribute("message", "Error occurred while canceling booking.");
            response.sendRedirect("booking_history.jsp");
        }
    }
}
