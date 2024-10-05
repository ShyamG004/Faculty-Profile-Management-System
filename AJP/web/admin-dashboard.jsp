<%@ page import="java.io.*" %>
<%
    // Logout functionality
    if ("POST".equalsIgnoreCase(request.getMethod()) && "logout".equals(request.getParameter("action"))) {
        // Invalidate session to log out the user
        HttpSession sessione = request.getSession();
        sessione.invalidate();
        response.sendRedirect("admin-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
            width: 100%;
            height: 100vh;
        }
        h2 {
            text-align: center;
        }
        .button {
            display: block;
            width: 200px;
            padding: 10px;
            margin: 10px auto;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }
        .button:hover {
            background-color: #0056b3;
        }
        div, body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        div {
            padding: 50px;
            background-color: gainsboro;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); /* Box shadow applied */
            border-radius: 10px; /* Rounded corners */
        }
    </style>
</head>
<body>
    <div>
        <h2>Admin Dashboard</h2>
        <a class="button" href="register.jsp">Add Faculty</a>
        <a class="button" href="fetch-faculty.jsp">Show Faculty Details</a>
        <a class="button" href="#" onclick="document.getElementById('logoutForm').submit();">Logout</a>
        <form id="logoutForm" method="post" action="admin-dashboard.jsp" style="display:none;">
            <input type="hidden" name="action" value="logout">
        </form>
    </div>
</body>
</html>
