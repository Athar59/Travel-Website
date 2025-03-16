<%@ include file="header.jsp" %> 
<%@ page import="java.sql.*, com.travel.db.DBConnection" %>

<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    
		if (userId == null) {
      	  	response.sendRedirect("login.jsp");
       	 	return;
    }

    String message = (String) session.getAttribute("message");
    	if (message != null) {
        	session.removeAttribute("message");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="booking-history-container">
        <h2>Your Booking History</h2>

        <% if (message != null) { %>
        
            <p class="success-message"><%= message %></p>
            
        <% } %>

        <table class="booking-table">
        
            <thead>
                <tr>
                    <th>Package Name</th>
                    <th>Booking Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            
            <tbody>
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "SELECT b.id, p.name, b.booking_date FROM bookings b JOIN packages p ON b.package_id = p.id WHERE b.user_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, userId);
                    ResultSet rs = stmt.executeQuery();
                    
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getTimestamp("booking_date") %></td>
                <td>
                    <form action="CancelBookingServlet" method="post" onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                        
                        <input type="hidden" name="booking_id" value="<%= rs.getInt("id") %>">
                        
                        <button type="submit" class="cancel-btn">Cancel</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    conn.close();
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>

        <a href="index.jsp" class="back-home">Back to Home</a>
    </div>
</body>

<%@ include file="footer.jsp" %>
