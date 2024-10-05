<%@ page import="java.sql.*, java.util.*" %>
<%
    String projectId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    // Variables to hold project details for the form
    String projectTitle = "";
    String sponsorshipAgency = "";
    double budget = 0;
    String pi = "";
    String coPi = "";

    try {
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // Fetch the existing project details
        String sql = "SELECT * FROM project WHERE project_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, projectId);
        rs = ps.executeQuery();

        if (rs.next()) {
            projectTitle = rs.getString("project_title");
            sponsorshipAgency = rs.getString("sponsorship_agency");
            budget = rs.getDouble("budget");
            pi = rs.getString("pi");
            coPi = rs.getString("co_pi");
        }

        // Check for form submission
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Get updated values from the form
            projectTitle = request.getParameter("project_title");
            sponsorshipAgency = request.getParameter("sponsorship_agency");
            budget = Double.parseDouble(request.getParameter("budget"));
            pi = request.getParameter("pi");
            coPi = request.getParameter("co_pi");

            // Update the project details in the database
            String updateSql = "UPDATE project SET project_title = ?, sponsorship_agency = ?, budget = ?, pi = ?, co_pi = ? WHERE project_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setString(1, projectTitle);
            ps.setString(2, sponsorshipAgency);
            ps.setDouble(3, budget);
            ps.setString(4, pi);
            ps.setString(5, coPi);
            ps.setString(6, projectId);
            ps.executeUpdate();

            message = "Project updated successfully!";
            // Redirect back to the previous page after a brief pause
            response.sendRedirect("faculty.jsp?message=" + message);
            return; // End the JSP execution here
        }

    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
<html>
<head>
    <title>Update Project</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 20px auto;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #5cb85c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #4cae4c;
        }
    </style>
    <script>
        // Check for message parameter and display alert
        window.onload = function() {
            const message = "<%= request.getParameter("message") != null ? request.getParameter("message") : "" %>";
            if (message) {
                alert(message);
            }
        };
    </script>
</head>
<body>
    <h2>Update Project</h2>
    <form method="post">
        <label>Project Title:</label>
        <input type="text" name="project_title" value="<%= projectTitle %>" required><br>
        <label>Sponsorship Agency:</label>
        <input type="text" name="sponsorship_agency" value="<%= sponsorshipAgency %>" required><br>
        <label>Budget:</label>
        <input type="number" step="0.01" name="budget" value="<%= budget %>" required><br>
        <label>Principal Investigator:</label>
        <input type="text" name="pi" value="<%= pi %>" required><br>
        <label>Co-Principal Investigator:</label>
        <input type="text" name="co_pi" value="<%= coPi %>" required><br>
        <input type="submit" value="Update Project">
    </form>
</body>
</html>
