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

    // Retrieve category_name from request parameter
    String category_name = request.getParameter("category_name");

    if (category_name == null || category_name.trim().isEmpty()) {
        out.println("<script>alert('Category name is required.');</script>");
        response.sendRedirect("admincategory.jsp");
        return;
    }

    // SQL query to update category details
    String updateSql = "UPDATE categories SET category_name = ? WHERE id = ?";

    // Initialize the database connection and prepared statement
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        out.println("Database connection established.<br>");

        // Create a prepared statement to execute the SQL update query
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setString(1, category_name);
        pstmt.setInt(2, categoryId);
        out.println("Prepared statement created.<br>");

        // Execute the update query
        int rowsAffected = pstmt.executeUpdate();
        out.println("SQL update executed.<br>");

        // Check if update was successful
        if (rowsAffected > 0) {
            // Redirect back to dashboard with success message
            out.println("<script>alert('Category updated successfully.');</script>");
            response.sendRedirect("admincategory.jsp?updateSuccess=true");
        } else {
            // Redirect back to dashboard with error message
            out.println("<script>alert('No category was updated. Please check the category ID.');</script>");
            response.sendRedirect("admincategory.jsp?updateSuccess=false");
        }

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to update category. Please try again.');</script>");
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
