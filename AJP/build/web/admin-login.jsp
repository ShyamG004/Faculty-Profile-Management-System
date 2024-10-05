<%@ page import="java.io.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if ("admin".equals(username) && "123".equals(password)) {
            message = "Login successful! Welcome, " + username + ".";
            // Redirect to admin dashboard or another page here
            response.sendRedirect("admin-dashboard.jsp");
            return;
        } else {
            message = "Invalid username or password. Please try again.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            align-self: center;
            text-align: center;
        }
        h2 {
            text-align: center;
        }
        .message {
            color: red;
            text-align: center;
        }
        input[type="text"], input[type="password"] {
            width: 78%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 87%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-top:20px;
        }
        button:hover {
            background-color: #0056b3;
        }
        form{
            padding:30px;
            display: flex;
            justify-content: center;
            align-items:center;
            flex-direction:column;

        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Admin Login</h2>
        <a href="index.html">Home</a>
        <div class="message"><%= message %></div>
        <form method="post" action="admin-login.jsp">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
    </div>

</body>
</html>
