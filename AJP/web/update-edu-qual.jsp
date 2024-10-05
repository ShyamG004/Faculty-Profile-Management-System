<%@ page import="java.sql.*, java.util.*" %>
<%
    String qualId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    // Variables to hold educational qualification details for the form
    String qualification = "";
    String branch = "";
    String institution = "";
    int yearPassed = 0;
    String classDivision = "";

    try {
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // Fetch the existing educational qualification details
        String sql = "SELECT * FROM edu_qual WHERE qual_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, qualId);
        rs = ps.executeQuery();

        if (rs.next()) {
            qualification = rs.getString("qual");
            branch = rs.getString("branch");
            institution = rs.getString("institution");
            yearPassed = rs.getInt("yr_pass");
            classDivision = rs.getString("class_div");
        }

        // Check for form submission
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Get updated values from the form
            qualification = request.getParameter("qual");
            branch = request.getParameter("branch");
            institution = request.getParameter("institution");
            yearPassed = Integer.parseInt(request.getParameter("yr_pass"));
            classDivision = request.getParameter("class_div");

            // Update the educational qualification details in the database
            String updateSql = "UPDATE edu_qual SET qual = ?, branch = ?, institution = ?, yr_pass = ?, class_div = ? WHERE qual_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setString(1, qualification);
            ps.setString(2, branch);
            ps.setString(3, institution);
            ps.setInt(4, yearPassed);
            ps.setString(5, classDivision);
            ps.setString(6, qualId);
            ps.executeUpdate();

            message = "Educational Qualification updated successfully!";
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
    <title>Update Educational Qualification</title>
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
    <h2>Update Educational Qualification</h2>
    <form method="post">
        <label>Qualification:</label>
        <input type="text" name="qual" value="<%= qualification %>" required><br>
        <label>Branch:</label>
        <input type="text" name="branch" value="<%= branch %>" required><br>
        <label>Institution:</label>
        <input type="text" name="institution" value="<%= institution %>" required><br>
        <label>Year of Passing:</label>
        <input type="number" name="yr_pass" value="<%= yearPassed %>" required><br>
        <label>Class/Division:</label>
        <input type="text" name="class_div" value="<%= classDivision %>" required><br>
        <input type="submit" value="Update Qualification">
    </form>
</body>
</html>
