<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Get the FACULTY_ID from the request
        String facultyId = request.getParameter("fid");
        String id = request.getParameter("id");
        
        // Database connection details
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        // Establishing connection to the database
        conn = DriverManager.getConnection(url, user, pass);

        // Deleting records from CONFERENCE table
        String deleteConferenceQuery = "DELETE FROM CONFERENCE WHERE FACULTY_ID = ?";
        ps = conn.prepareStatement(deleteConferenceQuery);
        ps.setString(1, facultyId);
        int confRowsDeleted = ps.executeUpdate();
        ps.close();

        // Deleting records from JOURNAL table
        String deleteJournalQuery = "DELETE FROM JOURNAL WHERE FACULTY_ID = ?";
        ps = conn.prepareStatement(deleteJournalQuery);
        ps.setString(1, facultyId);
        int journalRowsDeleted = ps.executeUpdate();
        ps.close();

        // Deleting records from PROJECT table
        String deleteProjectQuery = "DELETE FROM PROJECT WHERE FACULTY_ID = ?";
        ps = conn.prepareStatement(deleteProjectQuery);
        ps.setString(1, facultyId);
        int projectRowsDeleted = ps.executeUpdate();
        ps.close();

        // Deleting records from EDU_QUAL table
        String deleteEduQualQuery = "DELETE FROM EDU_QUAL WHERE FACULTY_ID = ?";
        ps = conn.prepareStatement(deleteEduQualQuery);
        ps.setString(1, facultyId);
        int eduQualRowsDeleted = ps.executeUpdate();
        ps.close();
        
        String deleteExpQuery = "DELETE FROM PROFESSIONAL_EXPERIENCE WHERE FACULTY_ID = ?";
        ps = conn.prepareStatement(deleteExpQuery);
        ps.setString(1, facultyId);
        int expDeleted = ps.executeUpdate();
        ps.close();
        // Deleting record from FACULTY table
        String deleteFacultyQuery = "DELETE FROM faculty WHERE id = ?";
        ps = conn.prepareStatement(deleteFacultyQuery);
        ps.setInt(1, Integer.parseInt(id));
        int facultyRowsDeleted = ps.executeUpdate(); // Execute the deletion for faculty
        ps.close();

//        // Display a message on success
//        out.println("<h3>Deleted records for FACULTY_ID: " + facultyId + "</h3>");
//        out.println("<p>Conference records deleted: " + confRowsDeleted + "</p>");
//        out.println("<p>Journal records deleted: " + journalRowsDeleted + "</p>");
//        out.println("<p>Project records deleted: " + projectRowsDeleted + "</p>");
//        out.println("<p>Educational Qualification records deleted: " + eduQualRowsDeleted + "</p>");
//        out.println("<p>Faculty record deleted: " + facultyRowsDeleted + "</p>");

        // Optionally redirect to another page after deletion
         response.sendRedirect("fetch-faculty.jsp");

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Closing resources
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
