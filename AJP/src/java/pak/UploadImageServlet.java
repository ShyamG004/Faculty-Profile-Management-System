package pak;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/UploadImage")
@MultipartConfig
public class UploadImageServlet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fid = request.getParameter("fid");
        InputStream profileImageStream = null;
        Part profileImagePart = request.getPart("profileImage");

        if (profileImagePart != null) {
            profileImageStream = profileImagePart.getInputStream();
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            String url = "jdbc:derby://localhost:1527/fpms_db";
            String user = "shyam";  // Your database username
            String pass = "123";    // Your database password

            conn = DriverManager.getConnection(url, user, pass);
            String sql = "UPDATE faculty SET profile_image = ? WHERE fid = ?";
            ps = conn.prepareStatement(sql);

            if (profileImageStream != null) {
                ps.setBlob(1, profileImageStream);
            } else {
                ps.setNull(1, java.sql.Types.BLOB);
            }

            ps.setString(2, fid);
            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("faculty.jsp?fid=" + fid + "&message=Profile image updated successfully!");
            } else {
                response.sendRedirect("faculty.jsp?fid=" + fid + "&error=Profile image update failed.");
            }

        } catch (Exception e) {
            response.sendRedirect("faculty.jsp?fid=" + fid + "&error=An error occurred: " + e.getMessage());
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
