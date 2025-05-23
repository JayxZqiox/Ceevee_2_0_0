<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

        // Initialize userId with a default value
    int userId = 0;

    // Retrieve and parse userId from request parameter
    String userIdParam = request.getParameter("userId");
    if (userIdParam != null && !userIdParam.isEmpty()) {
        userId = Integer.parseInt(userIdParam);
    } else {
        // Handle the case where userId is not provided
        out.println("<script>alert('User ID is missing or invalid.');</script>");
        response.sendRedirect("adminuser.jsp"); // Redirect to appropriate page
        return;
    }
    // Retrieve form parameters
    String username = request.getParameter("username");
    String age = request.getParameter("age");
    String phone = request.getParameter("phone");
    String nationality = request.getParameter("nationality");
    String gender = request.getParameter("gender");
    String password = request.getParameter("password");

    // SQL query to update recipe details
    String updateSql = "UPDATE login SET username=?, age = ?, phone_number = ?, nationality = ?, gender = ?, password = ? WHERE id = ?";

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
        pstmt.setString(1, username);
        pstmt.setString(2, age);
        pstmt.setString(3, phone);
        pstmt.setString(4, nationality);
        pstmt.setString(5, gender);
        pstmt.setString(6, password);
        pstmt.setInt(7, userId);

        // Execute the update query
        int rowsAffected = pstmt.executeUpdate();

        // Check if update was successful
        if (rowsAffected > 0) {
            // Redirect back to dashboard with success message
            response.sendRedirect("adminuser.jsp?updateSuccess=true");
        } else {
            // Redirect back to dashboard with error message
            response.sendRedirect("adminuser.jsp?updateSuccess=false");
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
