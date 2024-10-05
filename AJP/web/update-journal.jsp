<%@ page import="java.sql.*, java.util.*" %>
<%
    String journalPaperId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";

    // Variables to hold journal details for the form
    String titleOfPaper = "";
    String journalName = "";
    String authors = "";
    int volume = 0;
    int issue = 0;
    int pageStart = 0;
    int pageEnd = 0;
    int year = 0;

    try {
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // Fetch the existing journal details
        String sql = "SELECT * FROM Journal WHERE journal_paper_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, journalPaperId);
        rs = ps.executeQuery();

        if (rs.next()) {
            titleOfPaper = rs.getString("title_of_paper");
            journalName = rs.getString("journal_name");
            authors = rs.getString("authors");
            volume = rs.getInt("volume");
            issue = rs.getInt("number");
            pageStart = rs.getInt("page_start");
            pageEnd = rs.getInt("page_end");
            year = rs.getInt("year");
        }

        // Check for form submission
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Get updated values from the form
            titleOfPaper = request.getParameter("paperTitle");
            journalName = request.getParameter("journalName");
            authors = request.getParameter("journalAuthors");
            volume = Integer.parseInt(request.getParameter("volume"));
            issue = Integer.parseInt(request.getParameter("journalNumber"));
            pageStart = Integer.parseInt(request.getParameter("journalPageStart"));
            pageEnd = Integer.parseInt(request.getParameter("journalPageEnd"));
            year = Integer.parseInt(request.getParameter("journalYear"));

            // Update the journal details in the database
            String updateSql = "UPDATE Journal SET title_of_paper = ?, journal_name = ?, authors = ?, volume = ?, number = ?, page_start = ?, page_end = ?, \"year\" = ? WHERE journal_paper_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setString(1, titleOfPaper);
            ps.setString(2, journalName);
            ps.setString(3, authors);
            ps.setInt(4, volume);
            ps.setInt(5, issue);
            ps.setInt(6, pageStart);
            ps.setInt(7, pageEnd);
            ps.setInt(8, year);
            ps.setString(9, journalPaperId);
            ps.executeUpdate();

            message = "Journal updated successfully!";
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
    <title>Update Journal</title>
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
    <h2>Update Journal</h2>
    <form method="post">
        <label>Title of Paper:</label>
        <input type="text" name="paperTitle" value="<%= titleOfPaper %>" required><br>
        <label>Journal Name:</label>
        <input type="text" name="journalName" value="<%= journalName %>" required><br>
        <label>Authors:</label>
        <input type="text" name="journalAuthors" value="<%= authors %>" required><br>
        <label>Volume:</label>
        <input type="number" name="volume" value="<%= volume %>" required><br>
        <label>Number:</label>
        <input type="number" name="journalNumber" value="<%= issue %>" required><br>
        <label>Page Start:</label>
        <input type="number" name="journalPageStart" value="<%= pageStart %>" required><br>
        <label>Page End:</label>
        <input type="number" name="journalPageEnd" value="<%= pageEnd %>" required><br>
        <label>Year:</label>
        <input type="number" name="journalYear" value="<%= year %>" required min="1900" max="2100"><br>
        <input type="submit" value="Update Journal">
    </form>
</body>
</html>
