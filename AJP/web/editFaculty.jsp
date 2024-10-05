<%@ page import="java.sql.*" %>
<%
    String fid = request.getParameter("fid");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    boolean isUpdated = false; // Variable to check if the update was successful

    // Database connection details
    String url = "jdbc:derby://localhost:1527/fpms_db";
    String user = "shyam";  // Your database username
    String pass = "123";    // Your database password

    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Update faculty details
        String name = request.getParameter("name");
        String designation = request.getParameter("designation");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int age = Integer.parseInt(request.getParameter("age"));
        Date dob = Date.valueOf(request.getParameter("dob"));
        String gender = request.getParameter("gender");
        String marital = request.getParameter("marital");
        String citizenship = request.getParameter("citizenship");

        try {
            conn = DriverManager.getConnection(url, user, pass);
            String updateSql = "UPDATE faculty SET name=?, designation=?, email=?, phone=?, age=?, dob=?, gender=?, marital=?, citizenship=? WHERE fid=?";
            ps = conn.prepareStatement(updateSql);
            ps.setString(1, name);
            ps.setString(2, designation);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setInt(5, age);
            ps.setDate(6, dob);
            ps.setString(7, gender);
            ps.setString(8, marital);
            ps.setString(9, citizenship);
            ps.setString(10, fid);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                isUpdated = true; // Mark the update as successful
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // Fetch current faculty details for the edit form
    try {
        conn = DriverManager.getConnection(url, user, pass);
        String sql = "SELECT * FROM faculty WHERE fid = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, fid);
        rs = ps.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Faculty</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 400px; /* Set a specific width for the form */
            margin: 20px; /* Add some margin for spacing */
        }
        h2 {
            color: #333;
            text-align: center; /* Center align the header */
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="date"]
         {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%; /* Full width for the submit button */
        }
        select{
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<!-- Faculty Edit Form -->
<form method="post" action="editFaculty.jsp?fid=<%= fid %>">
    <h2>Edit Faculty Information</h2>
    <label for="name">Name:</label>
    <input type="text" name="name" value="<%= rs.getString("name") %>" required><br>

    <label for="designation">Designation:</label>
    <input type="text" name="designation" value="<%= rs.getString("designation") %>" required><br>

    <label for="email">Email:</label>
    <input type="email" name="email" value="<%= rs.getString("email") %>" required><br>

    <label for="phone">Mobile Number:</label>
    <input type="text" name="phone" value="<%= rs.getString("phone") %>" required><br>

    <label for="age">Age:</label>
    <input type="number" name="age" value="<%= rs.getInt("age") %>" required><br>

    <label for="dob">Date of Birth:</label>
    <input type="date" name="dob" value="<%= rs.getDate("dob") != null ? rs.getDate("dob").toString() : "" %>" required><br>

    <label for="gender">Gender:</label>
    <select name="gender" required>
        <option value="Male" <%= rs.getString("gender").equals("Male") ? "selected" : "" %>>Male</option>
        <option value="Female" <%= rs.getString("gender").equals("Female") ? "selected" : "" %>>Female</option>
    </select><br>

    <label for="marital">Marital Status:</label>
    <select name="marital" required>
        <option value="Single" <%= rs.getString("marital").equals("Single") ? "selected" : "" %>>Single</option>
        <option value="Married" <%= rs.getString("marital").equals("Married") ? "selected" : "" %>>Married</option>
    </select><br>

    <label for="citizenship">Citizenship:</label>
    <input type="text" name="citizenship" value="<%= rs.getString("citizenship") %>" required><br>

    <input type="submit" value="Update">
</form>

<!-- JavaScript Alert for Successful Update -->
<% if (isUpdated) { %>
    <script>
        alert("Faculty information updated successfully!");
        window.location.href = "faculty.jsp"; // Redirect to home page after alert
    </script>
<% } %>

<%
        } else {
            out.println("<div class='message'>Faculty details not found.</div>");
        }
    } catch (Exception e) {
        out.println("<div class='message'>Error: " + e.getMessage() + "</div>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
