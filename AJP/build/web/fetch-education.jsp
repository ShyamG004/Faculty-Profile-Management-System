<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <style>
        body {
            
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .qual-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        .qual-table th, .qual-table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #dddddd;
        }
        .qual-table th {
            background-color: #4CAF50;
            color: white;
        }
        .qual-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .qual-table tr:hover {
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
        .eduQualDetails{
            margin-top: 100px;
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
            String sql = "SELECT * FROM edu_qual WHERE faculty_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fid);
            rs = ps.executeQuery();

            if (rs.next()) {
    %>
    <div id="eduQualDetails">
        <div class="header-container">
            <h2>Educational Qualifications</h2>
            <div class="hide"><button class="close-button" onclick="eduQualDetails.style.display = 'none'">Close</button></div>
        </div>

        <table class="qual-table">
            <tr>
<!--                <th>Qualification ID</th>-->
                <th>Qualification</th>
                <th>Branch</th>
                <th>Institution</th>
                <th>Year of Passing</th>
                <th>Class/Division</th>
                <th class="hide">Update</th>
                <th class="hide">Delete</th>
            </tr>
            <%
                do {
            %>
            <tr>
<!--                <td><%= rs.getString("qual_id") %></td>-->
                <td><%= rs.getString("qual") %></td>
                <td><%= rs.getString("branch") %></td>
                <td><%= rs.getString("institution") %></td>
                <td><%= rs.getInt("yr_pass") %></td>
                <td><%= rs.getString("class_div") %></td>
                <td class="hide">
                    <a href="update-edu-qual.jsp?id=<%= rs.getString("qual_id") %>" class="action-button update-button">Update</a>
                </td>
                <td class="hide">
                    <form action="delete-record.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= rs.getString("qual_id") %>">
                        <input type="hidden" name="table" value="edu_qual">
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
                out.println("<h3>No educational qualifications found for this faculty member.</h3>");
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    %>
</body>
</html>
