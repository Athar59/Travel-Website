package com.travel.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import com.travel.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int packageId = Integer.parseInt(request.getParameter("package_id"));
            String packageName = request.getParameter("package_name");
            double totalPrice = Double.parseDouble(request.getParameter("total_price"));
            int numPersons = Integer.parseInt(request.getParameter("num_persons"));
            String modeOfTravel = request.getParameter("mode_of_travel");

            // Debugging 
            System.out.println("User ID: " + userId);
            System.out.println("Package ID: " + packageId);
            System.out.println("Package Name: " + packageName);
            System.out.println("Total Price: " + totalPrice);
            System.out.println("Number of Persons: " + numPersons);
            System.out.println("Mode of Travel: " + modeOfTravel);

            if (numPersons <= 0) {
                throw new IllegalArgumentException("Invalid number of persons: " + numPersons);
            }

            double finalTotalPrice = totalPrice * numPersons;

            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO payments (user_id, package_id, package_name, amount, payment_status) VALUES (?, ?, ?, ?, 'SUCCESS')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, packageId);
            stmt.setString(3, packageName);
            stmt.setDouble(4, finalTotalPrice);
            stmt.executeUpdate();

            sql = "INSERT INTO bookings (user_id, package_id, package_name, booking_date, mode_of_travel, num_persons, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, packageId);
            stmt.setString(3, packageName);
            stmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setString(5, modeOfTravel);
            stmt.setInt(6, numPersons);
            stmt.setDouble(7, finalTotalPrice); 
            stmt.executeUpdate();

            conn.close();

             response.sendRedirect("payment_success.jsp");


        } catch (Exception e) {
            e.printStackTrace();


            session.setAttribute("package_id", request.getParameter("package_id"));
            session.setAttribute("package_name", request.getParameter("package_name"));
            session.setAttribute("total_price", request.getParameter("total_price"));
            session.setAttribute("num_persons", request.getParameter("num_persons"));
            session.setAttribute("mode_of_travel", request.getParameter("mode_of_travel"));

            response.sendRedirect("payment_failed.jsp");
        }
    }
}