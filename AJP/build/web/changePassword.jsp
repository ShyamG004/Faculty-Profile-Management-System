<%@ page import="java.sql.*" %>
<%
    String fid = request.getParameter("fid");
    String message = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:derby://localhost:1527/fpms_db";
            String user = "shyam";  // Your database username
            String pass = "123";    // Your database password

            conn = DriverManager.getConnection(url, user, pass);

            // Validate current password
            String sql = "SELECT password FROM faculty WHERE fid = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fid);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(currentPassword)) {
                    message = "Current password is incorrect.";
                } else if (!newPassword.equals(confirmPassword)) {
                    message = "New password and confirm password do not match.";
                } else {
                    // Update password
                    sql = "UPDATE faculty SET password = ? WHERE fid = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, newPassword);
                    ps.setString(2, fid);
                    ps.executeUpdate();
                    message = "Password successfully changed!";
                    for(int i=1000000;i>0;i--){
                        continue;
                    }
                    response.sendRedirect("faculty.jsp");
                }
            } else {
                message = "Faculty ID not found.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .password-form {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 350px;
        }
        .password-form h2 {
            margin-bottom: 20px;
        }
        .password-form input {
            width: 93%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .password-form button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .password-form button:hover {
            background-color: #0056b3;
        }
        .message {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="password-form">
    <h2>Change Password</h2>

    <form action="changePassword.jsp?fid=<%= fid %>" method="post">
        <div class="message"><%= message %></div>

        <input type="password" name="currentPassword" placeholder="Current Password" required>
        <input type="password" name="newPassword" placeholder="New Password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm New Password" required>

        <button type="submit">Change Password</button>
    </form>
</div>

</body>
</html>
