<%@ page session="true" %>
<body>
<nav class="header-navbar">
    <div class="header-left">
    
        <% if (session.getAttribute("username") != null) { %>
            <span class="header-username">Welcome, <%= session.getAttribute("username") %>!</span>
        <% } %>
        
    </div>

    <div class="navbar-container" id="nav-links">
    
        <ul class="header-nav-links">
        
            <li><a href="index.jsp#home" class="nav-link">Home</a></li>
            <li><a href="index.jsp#packages" class="nav-link">Packages</a></li>
            <li><a href="booking_history.jsp">My Bookings</a></li>
            <li><a href="index.jsp#contact" class="nav-link">Contact</a></li>
            
            <% if (session.getAttribute("user_id") != null) { %>
                <li><a href="logoutServlet">Logout</a></li>
            <% } %>
            
        </ul>
    </div>

    <div class="header-menu-btn" id="navbar-toggle">
    
        <i class="fa-solid fa-bars"></i>
        
    </div>
</nav>
<script src="js/script.js?v=<%= System.currentTimeMillis() %>"></script>

</body>