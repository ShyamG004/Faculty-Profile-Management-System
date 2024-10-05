<%@ page import="java.sql.*, java.io.*" %>
<%
    // Retrieve form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Connect to the Derby database
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";   // Your database username
        String pass = "123";     // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // SQL query to check if the username and password match any record in the faculty table
        String sql = "SELECT * FROM faculty WHERE fid = ? AND password = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);

        // Execute the query
        rs = ps.executeQuery();

        if (rs.next()) {
            // If a match is found, redirect to faculty.jsp
            session.setAttribute("fid", rs.getString("fid"));  // Store user info in session
            response.sendRedirect("faculty.jsp");
        } else {
            // If no match is found, display an error message
            out.println("<script>");
            out.println("alert('Invalid username or password. Please try again.');");
            out.println("window.location.href = 'login.jsp';");  // Redirect back to login page
            out.println("</script>");
        }

    } catch (Exception e) {
        out.println(e);
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
