<%@ include file="header.jsp"%>
<%@ page import="java.sql.*, com.travel.db.DBConnection"%>
<%@ page session="true"%>

<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String packageId = request.getParameter("package_id");
    String packageName = "";
    double priceBus = 0.0, priceTrain = 0.0, priceFlight = 0.0;
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT name, price_bus, price_train, price_flight FROM packages WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(packageId));
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            packageName = rs.getString("name");
            priceBus = rs.getDouble("price_bus");
            priceTrain = rs.getDouble("price_train");
            priceFlight = rs.getDouble("price_flight");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Package</title>
<link rel="stylesheet" type="text/css"
	href="css/styles.css?v=<%= System.currentTimeMillis() %>">
</head>
<body class="booking-main">

	<div class="booking-container">
	
		<h2>Book Your Travel</h2>
		
		<form action="BookingServlet" method="post">
		
			<input type="hidden" name="package_id" value="<%= packageId %>">
			
			<input type="hidden" name="package_name" value="<%= packageName %>">
			
			<label for="mode">Select Mode of Travel:</label> 
			
			<select	name="mode_of_travel" id="mode" required>
			
				<option value="Bus" data-price="<%= priceBus %>">Bus ($<%= priceBus %>) </option>
				
				<option value="Train" data-price="<%= priceTrain %>">Train ($<%= priceTrain %>)</option>
				
				<option value="Flight" data-price="<%= priceFlight %>">Flight ($<%= priceFlight %>)</option>
				
			</select> 
			
			<label for="num_persons">Number of Persons:</label> 
			
			<input type="number" name="num_persons" id="num_persons" min="1" value="1" required>
			<p>
				Total Price: $<span id="total_price"><%= priceBus %></span>
			</p>
			
			<button type="submit">Proceed to Payment</button>
		</form>
	</div>

	<script src="js/script.js?v=<%= System.currentTimeMillis() %>"></script>
</body>
</html>

<%@ include file="footer.jsp"%>
