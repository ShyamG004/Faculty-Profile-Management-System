<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>Password Recovery</title>
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
            .container {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: center;
            }
            h2 {
                color: #333;
            }
            form {
                display: flex;
                flex-direction: column;
                margin-bottom: 20px;
            }
            input[type="text"], input[type="submit"] {
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            input[type="submit"] {
                background-color: #007bff;
                color: white;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #0056b3;
            }
            p {
                color: #666;
            }
            a {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }
            a:hover {
                background-color: #0056b3;
            }
            .error {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Password Recovery</h2>
            <%String facultyId = request.getParameter("fid");%>
            <!-- Form to get Faculty ID, Email, and Phone Number -->
            <form method="post">
                <input type="text" name="fid" placeholder="Faculty ID" value="<%=facultyId%>"required>
                <input type="text" name="email" placeholder="Email" required>
                <input type="text" name="phone" placeholder="Phone Number" required>
                <input type="submit" value="Recover Password">
            </form>


            <%
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String password = null;

                if (facultyId != null && email != null && phone != null) {
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        // Database connection details
                        String url = "jdbc:derby://localhost:1527/fpms_db";
                        String user = "shyam";  // Your database username
                        String pass = "123";    // Your database password

                        // Establishing connection to the database
                        conn = DriverManager.getConnection(url, user, pass);

                        // Query to fetch password only if faculty ID, email, and phone match
                        String query = "SELECT PASSWORD FROM faculty WHERE FID = ? AND EMAIL = ? AND PHONE = ?";
                        ps = conn.prepareStatement(query);
                        ps.setString(1, facultyId);
                        ps.setString(2, email);
                        ps.setString(3, phone);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            password = rs.getString("PASSWORD");
                            out.println("<p>Your password is: <span class='password'>" + password + "</span></p>");
                        } else {
                            out.println("<p class='error'>No matching records found for the provided details.</p>");
                        }

                    } catch (Exception e) {
                        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) try {
                            rs.close();
                        } catch (SQLException ignore) {
                        }
                        if (ps != null) try {
                            ps.close();
                        } catch (SQLException ignore) {
                        }
                        if (conn != null) try {
                            conn.close();
                        } catch (SQLException ignore) {
                        }
                    }
                }
            %>

            <a href="login.jsp">Go to Login</a>
        </div>
    </body>
</html>
