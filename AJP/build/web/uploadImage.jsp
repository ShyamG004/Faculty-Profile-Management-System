<%@ page import="java.sql.*, java.io.*, jakarta.servlet.annotation.MultipartConfig, jakarta.servlet.annotation.WebServlet, jakarta.servlet.http.Part" %>
<%
    // Retrieve the faculty ID
    String fid = request.getParameter("fid");
    
    InputStream profileImageStream = null;
    Part profileImagePart = request.getPart("profileImage");
    if (profileImagePart != null) {
        profileImageStream = profileImagePart.getInputStream();
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Connect to the Derby database
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        // SQL query to update the profile image in the faculty table
        String sql = "UPDATE faculty SET profile_image = ? WHERE fid = ?";
        ps = conn.prepareStatement(sql);

        // For profile image, set it as a Blob
        if (profileImageStream != null) {
            ps.setBlob(1, profileImageStream);
        } else {
            ps.setNull(1, java.sql.Types.BLOB);
        }

        ps.setString(2, fid);

        // Execute the query
        int result = ps.executeUpdate();

        if (result > 0) {
            // Update successful
            out.println("<script>");
            out.println("window.location.href = 'faculty.jsp?fid=" + fid + "';");  // Redirect to faculty profile page
            out.println("</script>");
        } else {
            out.println("<h3 style='color:red;'>Profile image update failed. Please try again.</h3>");
        }

    } catch (Exception e) {
        out.println("<h3 style='color:red;'>An error occurred: " + e.getMessage() + "</h3>");
    } finally {
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
<a href="faculty.jsp?fid=<%= fid %>">Back to Profile</a>
