<%@ page import="java.sql.*, java.util.*" %>
<%
    String conferencePaperId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    // Variables to hold conference details for the form
    String titleOfPaper = "";
    String conferenceName = "";
    String authors = "";
    int pageStart = 0;
    int pageEnd = 0;
    int year = 0;

    try {
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // Fetch the existing conference details
        String sql = "SELECT * FROM Conference WHERE conference_paper_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, conferencePaperId);
        rs = ps.executeQuery();

        if (rs.next()) {
            titleOfPaper = rs.getString("title_of_paper");
            conferenceName = rs.getString("conference_name");
            authors = rs.getString("authors");
            pageStart = rs.getInt("page_start");
            pageEnd = rs.getInt("page_end");
            year = rs.getInt("year");
        }

        // Check for form submission
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Get updated values from the form
            titleOfPaper = request.getParameter("paperTitle");
            conferenceName = request.getParameter("conferenceName");
            authors = request.getParameter("conferenceAuthors");
            pageStart = Integer.parseInt(request.getParameter("conferencePageStart"));
            pageEnd = Integer.parseInt(request.getParameter("conferencePageEnd"));
            year = Integer.parseInt(request.getParameter("conferenceYear"));

            // Update the conference details in the database
            String updateSql = "UPDATE Conference SET title_of_paper = ?, conference_name = ?, authors = ?, page_start = ?, page_end = ?, \"year\" = ? WHERE conference_paper_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setString(1, titleOfPaper);
            ps.setString(2, conferenceName);
            ps.setString(3, authors);
            ps.setInt(4, pageStart);
            ps.setInt(5, pageEnd);
            ps.setInt(6, year);
            ps.setString(7, conferencePaperId);
            ps.executeUpdate();

            message = "Conference updated successfully!";
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
    <title>Update Conference</title>
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
    <h2>Update Conference</h2>
    <form method="post">
        <label>Title of Paper:</label>
        <input type="text" name="paperTitle" value="<%= titleOfPaper %>" required><br>
        <label>Conference Name:</label>
        <input type="text" name="conferenceName" value="<%= conferenceName %>" required><br>
        <label>Authors:</label>
        <input type="text" name="conferenceAuthors" value="<%= authors %>" required><br>
        <label>Page Start:</label>
        <input type="number" name="conferencePageStart" value="<%= pageStart %>" required><br>
        <label>Page End:</label>
        <input type="number" name="conferencePageEnd" value="<%= pageEnd %>" required><br>
        <label>Year:</label>
        <input type="number" name="conferenceYear" value="<%= year %>" required min="1900" max="2100"><br>
        <input type="submit" value="Update Conference">
    </form>
</body>
</html>
