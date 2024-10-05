<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
    <head>
        <title>Faculty Details</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid black;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            body {
                font-family: Arial, sans-serif;
            }
            .navbar {
                background-color: #007BFF;
                display: flex;
                justify-content: flex-end; /* Aligns items to the right */
            }

            .navbar a {
                display: block;
                color: #f2f2f2;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }

            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }

            /* Table styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: #fff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for a modern look */
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #007BFF;
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            td {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e9ecef; /* Highlight row on hover */
            }

            /* Styling the Delete button */
            input[type="submit"] {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 6px 12px;
                cursor: pointer;
                border-radius: 4px;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #c82333; /* Darker shade on hover */
            }

            /* Styling the heading */
            h2 {
                text-align: center;
                margin-top: 20px;
                color: #007BFF;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                font-size: 24px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation bar with Dashboard and Logout options -->
        <div class="navbar">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="admin-login.jsp">Logout</a>
        </div>

        <h2>Faculty Details</h2>
        <%
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

                // Query to fetch all faculty records
                String query = "SELECT ID, FID, NAME, DEPT, PASSWORD FROM faculty";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                // Display records in an HTML table
                if (rs != null) {
        %>
        <table>
            <tr>
                <th>ID</th>
                <th>FID</th>
                <th>Name</th>
                <th>Department</th>
                <th>Password</th>
                <th>Action</th> <!-- Added for the delete button -->
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("ID")%></td>
                <td><%= rs.getString("FID")%></td>
                <td><%= rs.getString("NAME")%></td>
                <td><%= rs.getString("DEPT")%></td>
                <td><%= rs.getString("PASSWORD")%></td>
                <td>
                    <!-- Form for deleting the faculty record -->
                    <form action="deleteFaculty.jsp" method="post">
                        <input type="hidden" name="id" value="<%= rs.getInt("ID")%>">
                        <input type="hidden" name="fid" value="<%= rs.getString("FID")%>"> 
                        <input type="submit" value="Delete" >
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <p>No faculty records found.</p>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    // Closing resources
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
            %>
        </table>
    </body>
</html>
