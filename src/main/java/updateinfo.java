import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/updateinfo")
@MultipartConfig
public class updateinfo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = null;
        HttpSession session = request.getSession(true);
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "cuic", "1234");

            // Disable auto-commit
            con.setAutoCommit(false);

            String roll = request.getParameter("roll");
            String dept = request.getParameter("dept");
            String year = request.getParameter("year");
            String cgpa = request.getParameter("cgpa");
            String currentArrear = request.getParameter("current_arrear");
            HttpSession ss = request.getSession(true);
            String un = (String) ss.getAttribute("un");

            // Process the file upload
            Part filePart = request.getPart("resume");
            InputStream resumeInputStream = filePart.getInputStream();
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            int nRead;
            byte[] data = new byte[16384]; // Adjust buffer size as needed

            while ((nRead = resumeInputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }

            buffer.flush();
            byte[] resumeBytes = buffer.toByteArray();

            // Insert data into the database
            String sql = "INSERT INTO user_info VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
                preparedStatement.setString(1, roll);
                preparedStatement.setString(2, dept);
                preparedStatement.setString(3, year);
                preparedStatement.setString(4, cgpa);
                preparedStatement.setString(5, currentArrear);
                preparedStatement.setString(6, (String) session.getAttribute("un"));
                preparedStatement.setBytes(7, resumeBytes);
                preparedStatement.executeUpdate();
            }

            // Commit the transaction
            PreparedStatement ps = con.prepareStatement("UPDATE users set info = 'YES' where username = '" + un + "';");
            ps.executeUpdate();
            con.commit();

            // Bootstrap-styled success message
            PrintWriter out = response.getWriter();
            out.println("<div class='alert alert-success' role='alert'>User information successfully inserted into the database!</div>");

            // Redirect to userdash.jsp after 2 seconds
            out.println("<script>setTimeout(function(){window.location.href='userdash.jsp';},2000);</script>");

        } catch (Exception e) {
            // Rollback the transaction in case of an error
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException rollbackException) {
                    rollbackException.printStackTrace();
                }
            }

            // Bootstrap-styled error message
            response.getWriter().println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } finally {
            // Enable auto-commit to avoid potential issues
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
        }
    }
}
