<%@ page import="java.sql.*, java.io.*" %>
<%
    // Get the faculty ID from session (assuming it's stored in session during login)
    String facultyId = (String) session.getAttribute("fid");

    // Retrieve form data from the form and validate
    String journalPaperId = request.getParameter("journalPaperId");
    String titleOfPaper = request.getParameter("paperTitle");
    String journalName = request.getParameter("journalName");
    String authors = request.getParameter("journalAuthors");
    int volume = 0;
    int issue = 0;
    int pageStart = 0;
    int pageEnd = 0;
    int year = 0;

    boolean hasError = false;

    if (journalPaperId == null || journalPaperId.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Journal Paper ID is required.'); window.history.back();</script>");
    }
    if (titleOfPaper == null || titleOfPaper.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Title of Paper is required.'); window.history.back();</script>");
    }
    if (journalName == null || journalName.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Journal Name is required.'); window.history.back();</script>");
    }
    if (authors == null || authors.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Authors are required.'); window.history.back();</script>");
    }
    try {
        volume = Integer.parseInt(request.getParameter("volume"));
        issue = Integer.parseInt(request.getParameter("journalNumber"));
        pageStart = Integer.parseInt(request.getParameter("journalPageStart"));
        pageEnd = Integer.parseInt(request.getParameter("journalPageEnd"));
        year = Integer.parseInt(request.getParameter("journalYear"));
    } catch (NumberFormatException e) {
        hasError = true;
        out.println("<script>alert('Volume, Number, Page Start, Page End, and Year must be valid integers.'); window.history.back();</script>");
    }

    // Proceed only if there are no validation errors
    if (!hasError) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Database connection parameters
            String url = "jdbc:derby://localhost:1527/fpms_db";
            String user = "shyam";  // Your database username
            String pass = "123";    // Your database password

            conn = DriverManager.getConnection(url, user, pass);

            // Modify SQL to include the additional fields and faculty_id
            String sql = "INSERT INTO Journal (journal_paper_id, title_of_paper, journal_name, authors, volume, number, page_start, page_end, \"year\", faculty_id) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            // Set parameters for the SQL query
            ps.setString(1, journalPaperId);
            ps.setString(2, titleOfPaper);
            ps.setString(3, journalName);
            ps.setString(4, authors);
            ps.setInt(5, volume);
            ps.setInt(6, issue);
            ps.setInt(7, pageStart);
            ps.setInt(8, pageEnd);
            ps.setInt(9, year);
            ps.setString(10, facultyId);  // Set the faculty ID from session

            // Execute the query
            int result = ps.executeUpdate();

            if (result > 0) {
                // Successful insertion, redirect to faculty.jsp with success message
                out.println("<script>alert('Journal details added successfully!'); window.location='faculty.jsp';</script>");
            } else {
                // Insertion failed, alert the user and go back
                out.println("<script>alert('Failed to add journal details.'); window.history.back();</script>");
            }

        } catch (Exception e) {
            // Handle any errors and alert the user
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
        } finally {
            // Close the PreparedStatement and Connection objects
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
%>
