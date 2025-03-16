<%@ include file="header.jsp" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="register-container">
    
        <h2>User Registration</h2>
    
        <form action="RegisterServlet" method="post">
        
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="register-btn">Register</button>
            
        </form>
        
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
        
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>