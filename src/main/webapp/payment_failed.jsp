<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Failed</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

<%
    
    boolean sessionExpired = (session.getAttribute("package_id") == null || session.getAttribute("package_name") == null);
   
	String packageIdStr = (String) session.getAttribute("package_id");
    
	String packageName = (String) session.getAttribute("package_name");

    Object totalPriceObj = session.getAttribute("total_price");
    
    String totalPriceStr = "N/A"; 

    if (totalPriceObj != null) {
    	
        if (totalPriceObj instanceof Double) {
        	
            totalPriceStr = new DecimalFormat("#.##").format(totalPriceObj);
        
        } else {
        	
            totalPriceStr = totalPriceObj.toString();
        }
    }

    String numPersonsStr = (String) session.getAttribute("num_persons");
   
    String modeOfTravel = (String) session.getAttribute("mode_of_travel");
%>

<section class="payment-container">

    <% if (sessionExpired) { %>
    
        <section class="payment-session">
        
            <p class="payment-session-message">Session expired. Please try again.</p>
        
            <a href="login.jsp" class="payment-home-link">Go to Home</a>
        
        </section>
        
    <% } else { %>

        <section class="payment-failed">
        
            <h2>Payment Failed</h2>
        
            <p class="payment-failed-message">We encountered an issue processing your payment. Please try again.</p>
        
             <a href="login.jsp" class="payment-home-link">Go to Home</a>
        </section>

        <section class="payment-details">
        
            <h3>Booking Details</h3>
            
            <ul class="payment-details-list">
            
                <li class="payment-details-item"><strong>Package ID:</strong> <span><%= packageIdStr %></span></li>
                
                <li class="payment-details-item"><strong>Package Name:</strong> <span><%= packageName %></span></li>
                
                <li class="payment-details-item"><strong>Total Price:</strong> <span><%= totalPriceStr %></span></li>
               
               <%--  <li class="payment-details-item"><strong>Number of Persons:</strong> <span><%= numPersonsStr %></span></li>
               
                <li class="payment-details-item"><strong>Mode of Travel:</strong> <span><%= modeOfTravel %></span></li> --%>
            
            </ul>
        </section>

        <section class="payment-retry">
        
            <a href="payment.jsp" class="payment-retry-btn">Retry Payment</a>
            
        </section>

    <% } %>

</section>

</body>
</html>

<%@ include file="footer.jsp" %>
