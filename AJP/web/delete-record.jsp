<%@ page import="java.sql.*" %>
<%
    String recordId = request.getParameter("id"); // Record ID to delete
    String table = request.getParameter("table"); // Table name (e.g., project, journal, conference)
    String idColumn = ""; // To be dynamically assigned based on table

    // Map the table to its respective primary key column
    switch (table.toLowerCase()) {
        case "project":
            idColumn = "project_id";
            break;
        case "journal":
            idColumn = "journal_paper_id";
            break;
        case "conference":
            idColumn = "CONFERENCE_PAPER_ID";
            break;
        case "edu_qual":
            idColumn = "qual_id";
            break;
        case "professional_experience":
            idColumn = "experience_id";
            break;
        default:
            out.println("<script>alert('Invalid table specified!'); window.location.href='faculty.jsp';</script>");
            return; // Stop further execution if an invalid table is provided
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        String url = "jdbc:derby://localhost:1527/fpms_db";
        String user = "shyam";  // Your database username
        String pass = "123";    // Your database password

        conn = DriverManager.getConnection(url, user, pass);

        String sql = "DELETE FROM " + table + " WHERE " + idColumn + " = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, recordId);
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<script>alert('" + table + " record deleted successfully!'); window.location.href='faculty.jsp';</script>");
        } else {
            out.println("<script>alert('Error: Record not found or could not be deleted.'); window.location.href='faculty.jsp';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='faculty.jsp';</script>");
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
