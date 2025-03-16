package com.travel.servlet;

import com.travel.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/packages")
public class PackageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM packages";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            out.println("<html><head><title>Travel Packages</title>");
            out.println("<link rel='stylesheet' type='text/css' href='styles.css'>");
            out.println("</head><body><h2>Travel Packages</h2><div class='container'>");

            while (rs.next()) {
                out.println("<div class='card'>");
                out.println("<img src='" + rs.getString("image_url") + "' alt='Package Image'>");
                out.println("<h3>" + rs.getString("name") + "</h3>");
                out.println("<p>" + rs.getString("description") + "</p>");
                out.println("<p><strong>Price:</strong> $" + rs.getDouble("price") + "</p>");
                out.println("</div>");
            }

            out.println("</div></body></html>");
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
