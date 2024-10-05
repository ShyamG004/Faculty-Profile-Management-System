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

        // SQL statement to insert professional experience
        String sql = "INSERT INTO professional_experience (faculty_id, designation, institution, period, nature_of_duties) VALUES (?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);

        // Loop through the submitted professional experience data
        String[] facultyIds = request.getParameterValues("faculty_id[]");
        String[] designations = request.getParameterValues("designation[]");
        String[] institutions = request.getParameterValues("institution[]");
        String[] periods = request.getParameterValues("period[]");
        String[] natureOfDuties = request.getParameterValues("nature_of_duties[]");

        for (int i = 0; i < designations.length; i++) {
            // Set the parameters for the prepared statement
            ps.setString(1, facultyIds[i]);
            ps.setString(2, designations[i]);
            ps.setString(3, institutions[i]);
            ps.setString(4, periods[i]);
            ps.setString(5, natureOfDuties[i]);

            // Execute the insertion
            ps.executeUpdate();
        }

        // Success message
        out.println("<script>alert('Professional experience added successfully!');window.location.href = 'faculty.jsp';</script>");
       
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>Error adding professional experience:</h3>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("<a href='add_professional_experience.jsp'>Go back to Add Professional Experience</a>");
    } finally {
        // Close the resources
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
