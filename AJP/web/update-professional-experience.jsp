<%@ page import="java.sql.*, java.util.*" %>
<%
    String expId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    // Variables to hold professional experience details for the form
    String designation = "";
    String institution = "";
    String period = "";
    String natureOfDuties = "";

    try {
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // Fetch the existing professional experience details
        String sql = "SELECT * FROM professional_experience WHERE experience_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, expId);
        rs = ps.executeQuery();

        if (rs.next()) {
            designation = rs.getString("designation");
            institution = rs.getString("institution");
            period = rs.getString("period");
            natureOfDuties = rs.getString("nature_of_duties");
        }

        // Check for form submission
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Get updated values from the form
            designation = request.getParameter("designation");
            institution = request.getParameter("institution");
            period = request.getParameter("period");
            natureOfDuties = request.getParameter("nature_of_duties");

            // Update the professional experience details in the database
            String updateSql = "UPDATE professional_experience SET designation = ?, institution = ?, period = ?, nature_of_duties = ? WHERE experience_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setString(1, designation);
            ps.setString(2, institution);
            ps.setString(3, period);
            ps.setString(4, natureOfDuties);
            ps.setString(5, expId);
            ps.executeUpdate();

            message = "Professional Experience updated successfully!";
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
    <title>Update Professional Experience</title>
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

        input[type="text"] {
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
    <h2>Update Professional Experience</h2>
    <form method="post">
        <label>Designation:</label>
        <input type="text" name="designation" value="<%= designation %>" required><br>
        <label>Institution:</label>
        <input type="text" name="institution" value="<%= institution %>" required><br>
        <label>Period:</label>
        <input type="text" name="period" value="<%= period %>" required><br>
        <label>Nature of Duties:</label>
        <input type="text" name="nature_of_duties" value="<%= natureOfDuties %>" required><br>
        <input type="submit" value="Update Experience">
    </form>
</body>
</html>
