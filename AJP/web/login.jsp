<%-- 
    Document   : login
    Created on : 21 Sept 2024, 11:41:23 am
    Author     : mayhs
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Login page for Faculty Profile Management System">
        <meta name="author" content="mayhs">
        <title>Login Page</title>
        
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
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                text-align: center;
            }

            h2 {
                color: #333;
                margin-bottom: 20px;
            }

            .input-field {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 12px;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .forgot-password {
                display: block;
                margin-top: 15px;
                color: #007bff;
                text-decoration: none;
                font-size: 14px;
            }

            .forgot-password:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <h2>Login</h2>
            <a href="index.html">Home</a>
            <form action="login-action.jsp" method="post">
                <input type="text" name="username" class="input-field" placeholder="Username" required>
                <input type="password" name="password" class="input-field" placeholder="Password" required>
                <button type="submit" class="btn">Login</button>
            </form>
            <a href="forgot-password.jsp" class="forgot-password">Forgot Password?</a>
        </div>
    </body>
</html>

