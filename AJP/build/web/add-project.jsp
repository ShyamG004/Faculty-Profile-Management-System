<%@ page import="java.sql.*, java.io.*" %>
<%
    // Get the faculty ID from the session (assuming it's stored in session during login)
    String facultyId = (String) session.getAttribute("fid");

    // Retrieve form data and validate
    String projectId = request.getParameter("projectId");
    String projectTitle = request.getParameter("projectTitle");
    String sponsorshipAgency = request.getParameter("sponsorshipAgency");
    String pi = request.getParameter("pi");
    String coPi = request.getParameter("coPi");  // Optional field
    int budget = 0;

    boolean hasError = false;

    if (projectId == null || projectId.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Project ID is required.'); window.history.back();</script>");
    }
    if (projectTitle == null || projectTitle.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Project Title is required.'); window.history.back();</script>");
    }
    if (sponsorshipAgency == null || sponsorshipAgency.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Sponsorship Agency is required.'); window.history.back();</script>");
    }
    if (pi == null || pi.trim().isEmpty()) {
        hasError = true;
        out.println("<script>alert('Principal Investigator (PI) is required.'); window.history.back();</script>");
    }
    try {
        budget = Integer.parseInt(request.getParameter("budget"));
    } catch (NumberFormatException e) {
        hasError = true;
        out.println("<script>alert('Budget must be a valid number.'); window.history.back();</script>");
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

            // SQL query to insert the project details into the Project table
            String sql = "INSERT INTO Project (project_id, project_title, sponsorship_agency, budget, pi, co_pi, faculty_id) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            // Set parameters for the SQL query
            ps.setString(1, projectId);
            ps.setString(2, projectTitle);
            ps.setString(3, sponsorshipAgency);
            ps.setInt(4, budget);
            ps.setString(5, pi);
            ps.setString(6, coPi);  // Co-PI can be null
            ps.setString(7, facultyId);  // Set the faculty ID from session

            // Execute the query
            int result = ps.executeUpdate();

            if (result > 0) {
                // Successful insertion, redirect to faculty.jsp with success message
                out.println("<script>alert('Project details added successfully!'); window.location='faculty.jsp';</script>");
            } else {
                // Insertion failed, alert the user and go back
                out.println("<script>alert('Failed to add project details.'); window.history.back();</script>");
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
