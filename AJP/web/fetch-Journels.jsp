<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            /* General Table Styling */
            .journal-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: white;
            }

            .journal-table th, .journal-table td {
                padding: 12px;
                text-align: left;
                border: 1px solid #dddddd;
                white-space: wrap; 
            }

            .journal-table th {
                background-color: #4CAF50;
                color: white;
            }

            .journal-table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .journal-table tr:hover {
                background-color: #ddd;
            }

            /* Set fixed column widths */
            .journal-table th:nth-child(1), .journal-table td:nth-child(1) {
                width: 100px; /* Journal Paper ID */
            }

            .journal-table th:nth-child(2), .journal-table td:nth-child(2) {
                width: 200px; /* Title of Paper */
            }

            .journal-table th:nth-child(3), .journal-table td:nth-child(3) {
                width: 150px; /* Journal Name */
            }

            .journal-table th:nth-child(4), .journal-table td:nth-child(4) {
                width: 150px; /* Authors */
            }

            .journal-table th:nth-child(5), .journal-table td:nth-child(5) {
                width: 80px; /* Volume */
            }

            .journal-table th:nth-child(6), .journal-table td:nth-child(6) {
                width: 80px; /* Number */
            }

            .journal-table th:nth-child(7), .journal-table td:nth-child(7) {
                width: 100px; /* Page Start */
            }

            .journal-table th:nth-child(8), .journal-table td:nth-child(8) {
                width: 100px; /* Page End */
            }

            .journal-table th:nth-child(9), .journal-table td:nth-child(9) {
                width: 80px; /* Year */
            }

            .journal-table th:nth-child(10), .journal-table td:nth-child(10) {
                width: 100px; /* Update */
            }

            .journal-table th:nth-child(11), .journal-table td:nth-child(11) {
                width: 100px; /* Delete */
            }

            /* Button Styling */
            .action-button {
                background-color: #008CBA;
                color: white;
                border: none;
                padding: 5px 10px;
                text-align: center;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                border-radius: 5px;
            }

            .delete-button {
                background-color: #f44336;
            }

            .update-button {
                background-color: #4CAF50;
            }

            .close-button {
                background-color: #f44336;
                color: white;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 5px;
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

            .close-button {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 5px;
            }
            .action-button {
                background-color: #008CBA; /* Blue */
                color: white;
                border: none;
                padding: 10px 15px; /* Consistent padding */
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 5px;
                cursor: pointer;
                border-radius: 5px;
                width: 100px; /* Fixed width */
            }

            .delete-button {
                background-color: #f44336; /* Red */
            }

            .update-button {
                background-color: #4CAF50; /* Green */
                width:75px;
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
                String sql = "SELECT * FROM JOURNAL WHERE faculty_id = ?"; // Adjust your SQL according to your table structure
                ps = conn.prepareStatement(sql);
                ps.setString(1, fid);
                rs = ps.executeQuery();

                if (rs.next()) {
        %>
        <div id="journalDetails">
            <div class="header-container">
                <h2>Journal Details</h2>
                <div class="hide"><button class="close-button" onclick="journalDetails.style.display = 'none'">Close</button></div>
            </div>
            <table class="journal-table">
                <tr>
                    <th>Journal Paper ID</th>
                    <th>Title of Paper</th>
                    <th>Journal Name</th>
                    <th>Authors</th>
                    <th>Volume</th>
                    <th>Number</th>
                    <th>Pages</th>
                    <th>Year</th>
                    <th class="hide">Update</th>
                    <th class="hide">Delete</th>
                </tr>
                <%
                    do {
                %>
                <tr>
                    <td><%= rs.getString("JOURNAL_PAPER_ID")%></td>
                    <td><%= rs.getString("TITLE_OF_PAPER")%></td>
                    <td><%= rs.getString("JOURNAL_NAME")%></td>
                    <td><%= rs.getString("AUTHORS")%></td>
                    <td><%= rs.getString("VOLUME")%></td>
                    <td><%= rs.getString("NUMBER")%></td>
                    <td><%= rs.getString("PAGE_START")%> - <%= rs.getString("PAGE_END")%></td>
                    <td><%= rs.getString("YEAR")%></td>
                    <td class="hide">
                        <a href="update-journal.jsp?id=<%= rs.getString("JOURNAL_PAPER_ID")%>" class="action-button update-button">Update</a>
                    </td>
                    <td class="hide">
                        <form action="delete-record.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= rs.getString("JOURNAL_PAPER_ID")%>">
                            <input type="hidden" name="table" value="journal">
                            <button type="submit" class="action-button delete-button">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    } while (rs.next());
                %>
            </table>
            <%
                    } else {
                        out.println("<h3 class='message'>No Journal papers found for this faculty member.</h3>");
                    }
                } catch (Exception e) {
                    out.println("<h3 class='message'>Error: " + e.getMessage() + "</h3>");
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
        </div>
    </body>
</html>
