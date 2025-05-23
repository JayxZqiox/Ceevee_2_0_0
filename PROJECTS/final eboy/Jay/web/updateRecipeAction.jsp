<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Retrieve form parameters
    int recipeId = Integer.parseInt(request.getParameter("recipeId"));
    String name = request.getParameter("name");
    String image = request.getParameter("image");
    String ingredients = request.getParameter("ingredients");
   String instructions = request.getParameter("instructions");
    String category = request.getParameter("category");
    String rating = request.getParameter("rating");

    // SQL query to update recipe details
    String updateSql = "UPDATE recipes SET name = ?, image  = ?, ingredients = ?,instructions =?, category = ?, rating = ? WHERE id = ?";

    // Initialize the database connection and prepared statement
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create a prepared statement to execute the SQL update query
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setString(1, name);
        pstmt.setString(2, image);
        pstmt.setString(3, ingredients);
                pstmt.setString(4, instructions);

        pstmt.setString(5, category);
        pstmt.setString(6, rating);
        pstmt.setInt(7, recipeId);

        // Execute the update query
        int rowsAffected = pstmt.executeUpdate();

        // Check if update was successful
        if (rowsAffected > 0) {
            // Redirect back to dashboard with success message
            response.sendRedirect("admindashboard.jsp?updateSuccess=true");
        } else {
            // Redirect back to dashboard with error message
            response.sendRedirect("admindashboard.jsp?updateSuccess=false");
        }

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to update recipe. Please try again.');</script>");
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
