<%@ page import="java.sql.*, java.io.*, jakarta.servlet.annotation.MultipartConfig, jakarta.servlet.annotation.WebServlet, jakarta.servlet.http.Part" %>
<%
    // Retrieve form data
    String fid = request.getParameter("fid");
    String name = request.getParameter("name");
    String designation = request.getParameter("designation");
    String dept = request.getParameter("dept");
    String doj = request.getParameter("doj");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String age = request.getParameter("age");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String marital = request.getParameter("marital");
    String citizenship = request.getParameter("citizenship");
    String password = request.getParameter("password");
    String cpsw = request.getParameter("cpsw");
    
    InputStream profileImageStream = null;
    Part profileImagePart = request.getPart("profileImage");
    if (profileImagePart != null) {
        profileImageStream = profileImagePart.getInputStream();
    }
    
    // Check if passwords match
    if (!password.equals(cpsw)) {
        out.println("<h3 style='color:red;'>Passwords do not match. Please try again.</h3>");
    } else {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Connect to the Derby database
            String url = "jdbc:derby://localhost:1527/fpms_db";
            String user = "shyam";  // Your database username
            String pass = "123";    // Your database password

            conn = DriverManager.getConnection(url, user, pass);

            // SQL query to insert data into the faculty table
            String sql = "INSERT INTO faculty (fid, name, designation, dept, doj, email, phone, age, dob, gender, marital, citizenship, password, profile_image) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            // Set the parameters for the SQL query
            ps.setString(1, fid);
            ps.setString(2, name);
            ps.setString(3, designation);
            ps.setString(4, dept);
            ps.setDate(5, java.sql.Date.valueOf(doj));
            ps.setString(6, email);
            ps.setString(7, phone);
            ps.setInt(8, Integer.parseInt(age));
            ps.setDate(9, java.sql.Date.valueOf(dob));
            ps.setString(10, gender);
            ps.setString(11, marital);
            ps.setString(12, citizenship);
            ps.setString(13, password);
            
            // For profile image, set it as a Blob
            if (profileImageStream != null) {
                ps.setBlob(14, profileImageStream);
            } else {
                ps.setNull(14, java.sql.Types.BLOB);
            }

            // Execute the query
            int result = ps.executeUpdate();

            if (result > 0) {
                // Registration successful
                out.println("<script>");
                out.println("alert('Registration successful! Redirecting to login page...');");
                out.println("window.location.href = 'login.jsp';");  // Redirect to login page
                out.println("</script>");
            } else {
                out.println("<h3 style='color:red;'>Registration failed. Please try again.</h3>");
            }

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>An error occurred: " + e.getMessage() + "</h3>");
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
%>
