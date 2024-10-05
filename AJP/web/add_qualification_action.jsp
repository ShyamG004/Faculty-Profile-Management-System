<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Database connection details
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam"; // Your database username
        String pass = "123";    // Your database password

        // Establish connection
        conn = DriverManager.getConnection(url, user, pass);

        // SQL statement to insert educational qualifications
        String sql = "INSERT INTO edu_qual (FACULTY_ID, QUAL, BRANCH, INSTITUTION, YR_PASS, CLASS_DIV) VALUES (?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);

        // Loop through the submitted qualifications
        String[] facultyIds = request.getParameterValues("faculty_id[]");
        String[] qualifications = request.getParameterValues("qual[]");
        String[] branches = request.getParameterValues("branch[]");
        String[] institutions = request.getParameterValues("institution[]");
        String[] yearsPassed = request.getParameterValues("yr_pass[]");
        String[] classDivisions = request.getParameterValues("class_div[]");

        for (int i = 0; i < qualifications.length; i++) {
            // Set the parameters for the prepared statement
            ps.setString(1, facultyIds[i]);
            ps.setString(2, qualifications[i]);
            ps.setString(3, branches[i]);
            ps.setString(4, institutions[i]);
            ps.setInt(5, Integer.parseInt(yearsPassed[i]));
            ps.setString(6, classDivisions[i]);

            // Execute the insertion
            ps.executeUpdate();
        }

        // Success message
        out.println("<script>alert('Educational qualifications added successfully!');window.location='faculty.jsp';</script>");
        
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>Error adding educational qualifications:</h3>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("<a href='addEducation.jsp'>Go back to Add Educational Qualifications</a>");
    } finally {
        // Close the resources
        if (ps != null) {
            ps.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
