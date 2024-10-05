<%@ page import="java.sql.*, java.util.*" %>
<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }

            /* Table Styling */
            .conference-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: white;
            }

            .conference-table th, .conference-table td {
                padding: 12px;
                text-align: left;
                border: 1px solid #dddddd;
                white-space: wrap; /* Prevent text from wrapping */
                height: 50px; /* Fixed row height */
            }

            .conference-table th {
                background-color: #4CAF50;
                color: white;
            }

            .conference-table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .conference-table tr:hover {
                background-color: #ddd;
            }

            /* Set fixed column widths */
            .conference-table th:nth-child(1), .conference-table td:nth-child(1) {
                width: 120px;
            }

            .conference-table th:nth-child(2), .conference-table td:nth-child(2) {
                width: 200px;
            }

            .conference-table th:nth-child(3), .conference-table td:nth-child(3) {
                width: 180px;
            }

            .conference-table th:nth-child(4), .conference-table td:nth-child(4) {
                width: 180px;
            }

            .conference-table th:nth-child(5), .conference-table td:nth-child(5) {
                width: 100px;
            }

            .conference-table th:nth-child(6), .conference-table td:nth-child(6) {
                width: 100px;
            }

            .conference-table th:nth-child(7), .conference-table td:nth-child(7),
            .conference-table th:nth-child(8), .conference-table td:nth-child(8) {
                width: 100px;
            }

            /* Button Styling */
            .action-button {
                background-color: #008CBA; /* Blue */
                color: white;
                border: none;
                padding: 8px 12px;
                text-align: center;
                display: inline-block;
                font-size: 14px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 5px;
                width: 75px; /* Fixed width */
            }

            .delete-button {
                background-color: #f44336; /* Red */
            }

            .update-button {
                background-color: #4CAF50; /* Green */
            }

            .close-button {
                background-color: #f44336;
                color: white;
                padding: 10px 15px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                font-size: 16px;
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
        <script>
            function confirmDelete(table, recordId) {
                if (confirm("Are you sure you want to delete this " + table + " record?")) {
                    window.location.href = "delete-record.jsp?table=" + table + "&id=" + recordId;
                }
            }
        </script>
    </head>
    <body>
        <%
            String fid = request.getParameter("fid");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                String url = "jdbc:derby://localhost:1527/fpms_db";
                String user = "shyam";
                String pass = "123";

                conn = DriverManager.getConnection(url, user, pass);
                String sql = "SELECT * FROM CONFERENCE WHERE faculty_id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, fid);
                rs = ps.executeQuery();

                if (rs.next()) {
        %>
        <div id="conferenceDetails">
            <div class="header-container">
    <h2>Conference Details</h2>
    <div class="hide"><button class="close-button" onclick="conferenceDetails.style.display = 'none'">Close</button></div>
</div>

            <table class="conference-table">
                <tr>
                    <th>Conference Paper ID</th>
                    <th>Title of Paper</th>
                    <th>Conference Name</th>
                    <th>Authors</th>
                    <th>Pages</th>
                    <th>Year</th>
                    <th class="hide">Update</th>
                    <th class="hide">Delete</th>
                </tr>
                <%
                    do {
                        String conferenceId = rs.getString("CONFERENCE_PAPER_ID");
                %>
                <tr>
                    <td><%= conferenceId %></td>
                    <td><%= rs.getString("TITLE_OF_PAPER") %></td>
                    <td><%= rs.getString("CONFERENCE_NAME") %></td>
                    <td><%= rs.getString("AUTHORS") %></td>
                    <td><%= rs.getString("PAGE_START") %> - <%= rs.getString("PAGE_END") %></td>
                    <td><%= rs.getString("YEAR") %></td>
                    <td class="hide">
                        <a href="update-conference.jsp?id=<%= conferenceId %>" class="action-button update-button">Update</a>
                    </td>
                    <td class="hide">
                        <form action="delete-record.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= conferenceId %>">
                            <input type="hidden" name="table" value="conference">
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
                    out.println("<h3>No conferences found for this faculty member.</h3>");
                }
            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
    </body>
</html>
