<%@ page import="java.sql.*, java.io.*" %>
<%
    // Get the faculty ID from session (assuming it's stored in session during login)
    String facultyId = (String) session.getAttribute("fid");

    // Retrieve form data and validate
    String confPaperId = request.getParameter("confPaperId");
    String titleOfPaper = request.getParameter("titleOfPaper");
    String confName = request.getParameter("confName");
    String authors = request.getParameter("authors");
    int pageStart = 0;
    int pageEnd = 0;
    int year = 0;

    boolean hasError = false;

    if (confPaperId == null || confPaperId.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Conference Paper ID is required.'); window.history.back();</script>");
    }
    if (titleOfPaper == null || titleOfPaper.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Title of Paper is required.'); window.history.back();</script>");
    }
    if (confName == null || confName.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Conference Name is required.'); window.history.back();</script>");
    }
    if (authors == null || authors.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Authors are required.'); window.history.back();</script>");
    }
    try {
        pageStart = Integer.parseInt(request.getParameter("pageStart"));
        pageEnd = Integer.parseInt(request.getParameter("pageEnd"));
        year = Integer.parseInt(request.getParameter("year"));
    } catch (NumberFormatException e) {
        hasError = true;
        out.println("<script>alert('Page numbers and year must be valid integers.'); window.history.back();</script>");
    }

    // Proceed only if there are no validation errors
    if (!hasError) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            String url = "jdbc:derby://localhost:1527/fpms_db";
            String user = "shyam";  // Your database username
            String pass = "123";    // Your database password

            conn = DriverManager.getConnection(url, user, pass);

            // Modify SQL to include faculty_id
            String sql = "INSERT INTO Conference (conference_paper_id, title_of_paper, conference_name, authors, page_start, page_end, \"year\", faculty_id) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            // Set parameters
            ps.setString(1, confPaperId);
            ps.setString(2, titleOfPaper);
            ps.setString(3, confName);
            ps.setString(4, authors);
            ps.setInt(5, pageStart);
            ps.setInt(6, pageEnd);
            ps.setInt(7, year);
            ps.setString(8, facultyId);  // Set the faculty ID from session

            // Execute the query
            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('Conference details added successfully!'); window.location='faculty.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to add conference details.'); window.history.back();</script>");
            }

        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
%>
