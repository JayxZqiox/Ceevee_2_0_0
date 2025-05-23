<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Retrieve recipe ID from the form data
    int recipeId = Integer.parseInt(request.getParameter("recipeId"));

    // SQL delete query
    String deleteSql = "DELETE FROM recipes WHERE id=?";

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

        // Set parameter for the prepared statement
        pstmt.setInt(1, recipeId);

        // Execute the delete query
        int rowsAffected = pstmt.executeUpdate();

        // Redirect back to the recipe dashboard after delete
        response.sendRedirect("admindashboard.jsp");

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to delete recipe. Please try again.');</script>");
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
