<%@ page import="java.sql.*, java.util.*" %>
<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;

                background-color: #f4f4f4;
            }

            .project-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: white;
            }

            .project-table th, .project-table td {
                padding: 12px;
                text-align: left;
                border: 1px solid #dddddd;
            }

            .project-table th {
                background-color: #4CAF50;
                color: white;
            }

            .project-table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .project-table tr:hover {
                background-color: #ddd;
            }

            h3 {
                color: #333;
            }

            h2 {
                color: #4CAF50; /* Same color as the table header for consistency */
                margin-bottom: 10px;
            }

            .close-button {
                background-color: #f44336; /* Red */
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

            .hidden {
                display: none;
            }

            .action-button {
                background-color: #008CBA; /* Blue */
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
                background-color: #f44336; /* Red */
            }
            .update-button {
                background-color: #4CAF50; /* Green */
                width:75px;
            }
            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .header-container h2 {
                margin: 0;
                color: #4CAF50; /* or any color you'd like */
            }
            .project-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: white;
                table-layout: fixed; /* Fix column width */
            }

            .project-table th, .project-table td {
                padding: 12px;
                text-align: left;
                border: 1px solid #dddddd;
                white-space: wrap;/* Allow text to wrap */
            }

            .project-table th {
                background-color: #4CAF50;
                color: white;
            }

            .project-table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .project-table tr:hover {
                background-color: #ddd;
            }

            h3 {
                color: #333;
            }

            h2 {
                color: #4CAF50; /* Same color as the table header for consistency */
                margin-bottom: 10px;
            }

            .close-button {
                background-color: #f44336; /* Red */
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

            .hidden {
                display: none;
            }

            .action-button {
                background-color: #008CBA; /* Blue */
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
                background-color: #f44336; /* Red */
            }

            .update-button {
                background-color: #4CAF50; /* Green */
                width: 75px;
            }

            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .header-container h2 {
                margin: 0;
                color: #4CAF50; /* or any color you'd like */
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
                String sql = "SELECT * FROM project WHERE faculty_id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, fid);
                rs = ps.executeQuery();

                if (rs.next()) {
        %>
        <div id="projectDetails">
            <div class="header-container">
                <h2>Project Details</h2>
                <div class="hide"><button class="close-button" onclick="projectDetails.style.display = 'none'">Close</button></div>
            </div>

            <table class="project-table">
                <tr>
                    <th>Project ID</th>
                    <th>Project Title</th>
                    <th>Sponsorship Agency</th>
                    <th>Budget</th>
                    <th>Principal Investigator</th>
                    <th>Co-Principal Investigator</th>
                    <th class="hide">Update</th>
                    <th class="hide">Delete</th>
                </tr>
                <%
                    do {
                %>
                <tr>
                    <td><%= rs.getString("project_id")%></td>
                    <td><%= rs.getString("project_title")%></td>
                    <td><%= rs.getString("sponsorship_agency")%></td>
                    <td>Rs. <%= rs.getDouble("budget")%></td>
                    <td><%= rs.getString("pi")%></td>
                    <td><%= rs.getString("co_pi")%></td>
                    <td class="hide">
                        <a href="update-project.jsp?id=<%= rs.getString("project_id")%>" class="action-button update-button">Update</a>
                    </td>
                    <td class="hide">
                        <form action="delete-record.jsp" method="get" style="display:inline;">

                            <input type="hidden" name="id" value="<%= rs.getString("project_id")%>">
                            <input type="hidden" name="table" value="project">
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
                    out.println("<h3>No projects found for this faculty member.</h3>");
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
