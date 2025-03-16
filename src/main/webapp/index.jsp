<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.travel.db.DBConnection"%>
<%@ page session="true"%>

<html>
<head>
<title>Travel Website</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

	<% 
        // Checking if a user is logged in
        Integer userId = (Integer) session.getAttribute("user_id");
        
        // If user is not logged in, redirect to the login page
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

	<!-- Home Section -->
	<section id="home">
		<img src="images/home_bg.png" alt="Travel Image">

		<div class="home-content">
		
			<h2>Welcome To My Travel Website</h2>
			<p>Discover amazing travel destinations and book your next adventure with us.</p>
			
		</div>
	</section>

	<!-- Packages Section -->
	<section id="packages">
		<h2>Explore the Travel Packages</h2>

		<div class="packages-container">
			<%  
                try {
                    Connection conn = DBConnection.getConnection();

                    String sql = "SELECT * FROM packages";

                    PreparedStatement stmt = conn.prepareStatement(sql);

                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
            
			<div class="packages-card">
			
				<img src="images/<%= rs.getString("image_url") %>"alt="Package Image">
				
				<div class="packages-card-content">
				
					<h3><%= rs.getString("name") %></h3>
					
					<p><%= rs.getString("description") %></p>
					
					<p class="packages-price">
						Price: $<%= rs.getDouble("price") %></p>

					<% if (userId != null) { %>
				
					<form action="BookPackageServlet" method="post">
					
						<input type="hidden" name="package_id" value="<%= rs.getInt("id") %>">
						
						<button type="submit">Book Now</button>
					</form>
					
					<% } else { %>

					<a href="login.jsp"><button>Login to Book</button></a>
					
					<% } %>
				</div>
			</div>
			<%  
                    }
                    conn.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
		</div>
	</section>

	<!-- Contact Section -->
	<section id="contact">
		<h2>Contact Us</h2>
		<p>Have questions? Reach out to us for more information.</p>

		<% 
           String successMsg = (String) session.getAttribute("success");
           String errorMsg = (String) session.getAttribute("error");

           if (successMsg != null) { 
        %>
		<p style="color: green;"><%= successMsg %></p>
		<% session.removeAttribute("success"); } %>

		<% if (errorMsg != null) { %>
		
		<p style="color: red;"><%= errorMsg %></p>
		<% session.removeAttribute("error");
		
		 } %>

		<form action="ContactServlet" method="post">
		
			<input type="text" name="name" placeholder="Your Name" required>
			
			<input type="email" name="email" placeholder="Your Email" required>
			
			<textarea name="message" placeholder="Your Message" required></textarea>
			
			<button type="submit">Send Message</button>
			
		</form>
	</section>

</body>
</html>

<%@ include file="footer.jsp"%>
