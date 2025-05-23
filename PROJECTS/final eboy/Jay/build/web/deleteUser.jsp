<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Retrieve username from request parameter
    String username = request.getParameter("username");

    // Check if username is null or empty
    if (username == null || username.isEmpty()) {
        response.sendRedirect("useraccounts.jsp"); // Redirect to user accounts page
        return;
    }

    // SQL query to delete user record
    String deleteSql = "DELETE FROM login WHERE username = ?";

    // Initialize the database connection and prepared statement
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create a prepared statement to execute the delete query
        pstmt = conn.prepareStatement(deleteSql);

        // Set username parameter for the prepared statement
        pstmt.setString(1, username);

        // Execute the delete query
        int rowsAffected = pstmt.executeUpdate();

        // Redirect back to user accounts page after delete
        response.sendRedirect("adminuser.jsp");

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to delete user. Please try again.');</script>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    } finally {
        // Close the database resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
