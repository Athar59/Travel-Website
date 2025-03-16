<%@ include file="header.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="com.travel.model.Package" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Travel Packages</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>

<body>
    <h2>Available Travel Packages</h2>
    
    <div class="package-container">
        <%
            List<Package> packages = (List<Package>) request.getAttribute("packages");
        
            if (packages != null) {
            	
                for (Package pack : packages) {
        %>
            <div class="package-card">
        <img src="<%= request.getContextPath() %>/images/<%= pack.getImageUrl() %>" alt="<%= pack.getName() %>">
           
                <h3><%= pack.getName() %></h3>
                
                <p><%= pack.getDescription() %></p>
                
                <p><strong>Price:</strong> $<%= pack.getPrice() %></p>
            </div>
        <% 
                }
            } else { 
        %>
            <p>No packages available.</p>
        <% } %>
    </div>
</body>
</html>
