package com.travel.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.travel.db.DBConnection;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        HttpSession session = request.getSession();

        if (name.isEmpty() || email.isEmpty() || message.isEmpty()) {
            session.setAttribute("error", "All fields are required!");
            response.sendRedirect("index.jsp#contact");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, message);

            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsInserted > 0) {
                session.setAttribute("success", "Message sent successfully!");
            } else {
                session.setAttribute("error", "Error saving message. Try again later.");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Error saving message. Try again later.");
        }

        response.sendRedirect("index.jsp#contact"); 
    }
}
