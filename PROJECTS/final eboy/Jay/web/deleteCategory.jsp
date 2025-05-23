<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Initialize categoryId with a default value
    int categoryId = 0;

    // Retrieve and parse categoryId from request parameter
    String categoryIdParam = request.getParameter("categoryId");
    if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            out.println("<script>alert('Invalid Category ID format.');</script>");
            response.sendRedirect("admincategory.jsp");
            return;
        }
    } else {
        // Handle the case where categoryId is not provided
        out.println("<script>alert('Category ID is missing or invalid.');</script>");
        response.sendRedirect("admincategory.jsp"); // Redirect to appropriate page
        return;
    }

    // SQL query to delete category
    String deleteSql = "DELETE FROM categories WHERE id = ?";

    // Initialize the database connection and prepared statement
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create a prepared statement to execute the SQL delete query
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, categoryId);

        // Execute the delete query
        int rowsAffected = pstmt.executeUpdate();

        // Check if delete was successful
        if (rowsAffected > 0) {
            // Redirect back to dashboard with success message
            response.sendRedirect("admincategory.jsp?deleteSuccess=true");
        } else {
            // Redirect back to dashboard with error message
            response.sendRedirect("admincategory.jsp?deleteSuccess=false");
        }

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to delete category. Please try again.');</script>");
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
