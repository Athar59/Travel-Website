<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page session="true" %>

<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body class = "login-page">

<div class="login-container">

    <h2>User Login</h2>

    <form action="LoginServlet" method="post">

        <div class="input-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button type="submit" class="login-btn">Login</button>
    </form>

    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
</div>

</body>
</html>
<%@ include file="footer.jsp" %>
