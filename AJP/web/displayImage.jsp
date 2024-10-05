<%@ page import="java.sql.*, java.io.*" %>
<%
    // Get the faculty ID from the request
    String fid = request.getParameter("fid");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    InputStream inputStream = null;

    try {
        // Database connection details
        String url = "jdbc:derby://localhost:1527/fpms_db"; // Replace with your database URL
        String user = "shyam";  // Database username
        String pass = "123";    // Database password
        conn = DriverManager.getConnection(url, user, pass);

        // SQL query to get the image BLOB from the faculty table
        String sql = "SELECT profile_image FROM faculty WHERE fid = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, fid);
        rs = ps.executeQuery();

        if (rs.next()) {
            // Retrieve the image as a binary stream
            Blob imageBlob = rs.getBlob("profile_image");
            inputStream = imageBlob.getBinaryStream();

            // Set the content type to image (for example, jpeg or png)
            response.setContentType("image/jpeg");  // Adjust if you are storing other image formats (e.g., "image/png")
            OutputStream oute = response.getOutputStream();

            // Buffer to read the image data
            byte[] buffer = new byte[1024];
            int bytesRead = -1;
       
            // Write the image data to the output stream
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                oute.write(buffer, 0, bytesRead);
            }

            oute.flush();
        } else {
            out.println("<h3>No image found for the given faculty ID.</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Clean up resources
        if (inputStream != null) inputStream.close();
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
