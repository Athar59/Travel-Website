package com.travel.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.travel.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookPackageServlet")
public class BookPackageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int packageId = Integer.parseInt(request.getParameter("package_id"));

        try {
            Connection conn = DBConnection.getConnection();
            
            // Fetching the package name and price
            String packageQuery = "SELECT name, price FROM packages WHERE id = ?";
            PreparedStatement packageStmt = conn.prepareStatement(packageQuery);
            packageStmt.setInt(1, packageId);
            ResultSet rs = packageStmt.executeQuery();
            
            String packageName = "";
            double packagePrice = 0.0;
            if (rs.next()) {
                packageName = rs.getString("name");
                packagePrice = rs.getDouble("price");
            }

            conn.close();

            // Debugging 
            System.out.println("Package Name: " + packageName);
            System.out.println("Package Price: " + packagePrice);

            // Storing package data in session
            session.setAttribute("package_id", String.valueOf(packageId));
            session.setAttribute("package_name", packageName);
            session.setAttribute("total_price", packagePrice);

            // Redirecting to payment.jsp
            response.sendRedirect("payment.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Redirecting to booking failed page
            response.sendRedirect("booking_failed.jsp");
        }
    }
}
