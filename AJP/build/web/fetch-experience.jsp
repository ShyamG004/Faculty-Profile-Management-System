<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .exp-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        .exp-table th, .exp-table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #dddddd;
        }
        .exp-table th {
            background-color: #4CAF50;
            color: white;
        }
        .exp-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .exp-table tr:hover {
            background-color: #ddd;
        }
        h3 {
            color: #333;
        }
        h2 {
            color: #4CAF50;
            margin-bottom: 10px;
        }
        .close-button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 0;
            cursor: pointer;
            border-radius: 5px;
        }
        .action-button {
            background-color: #008CBA;
            color: white;
            border: none;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 5px;
            cursor: pointer;
            border-radius: 5px;
        }
        .delete-button {
            background-color: #f44336;
        }
        .update-button {
            background-color: #4CAF50;
            width: 75px;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%
        String fid = request.getParameter("fid");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:derby://localhost:1527/fpms_db";
            String user = "shyam";  // Your database username
            String pass = "123";    // Your database password

            conn = DriverManager.getConnection(url, user, pass);
            String sql = "SELECT * FROM professional_experience WHERE faculty_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fid);
            rs = ps.executeQuery();

            if (rs.next()) {
    %>
    <div id="profExpDetails">
        <div class="header-container">
            <h2>Professional Experience</h2>
            <div class="hide"><button class="close-button" onclick="profExpDetails.style.display = 'none'">Close</button></div>
        </div>

        <table class="exp-table">
            <tr>
                <th>Designation</th>
                <th>Institution</th>
                <th>Period</th>
                <th>Nature of Duties</th>
                <th class="hide">Update</th>
                <th class="hide">Delete</th>
            </tr>
            <%
                do {
            %>
            <tr>
                <td><%= rs.getString("designation") %></td>
                <td><%= rs.getString("institution") %></td>
                <td><%= rs.getString("period") %></td>
                <td><%= rs.getString("nature_of_duties") %></td>
                <td class="hide">
                    <a href="update-professional-experience.jsp?id=<%= rs.getString("experience_id") %>" class="action-button update-button">Update</a>
                </td>
                <td class="hide">
                    <form action="delete-record.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= rs.getString("experience_id") %>">
                        <input type="hidden" name="table" value="professional_experience">
                        <button type="submit" class="action-button delete-button">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                } while (rs.next());
            %>
        </table>
    </div>
    <%
            } else {
                out.println("<h3>No professional experience found for this faculty member.</h3>");
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
