<%@page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Recipe</title>
</head>
<body>
<%
    int recipeId = Integer.parseInt(request.getParameter("recipeId"));
    String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
    String username = "root";
    String password = "";
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(databaseUrl, username, password);

        String deleteQuery = "DELETE FROM recipes WHERE id = ?";
        stmt = conn.prepareStatement(deleteQuery);
        stmt.setInt(1, recipeId);

        stmt.executeUpdate();
        response.sendRedirect("profile.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println(e.getMessage());
    } finally {
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
