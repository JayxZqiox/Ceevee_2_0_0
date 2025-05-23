<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
    String username = "root";
    String password = "";

    // Get user ID from cookies
    Cookie[] cookies = request.getCookies();
    int userId = -1;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("userId".equals(cookie.getName())) {
                userId = Integer.parseInt(cookie.getValue());
                break;
            }
        }
    }

    if (userId == -1) {
        response.sendRedirect("login.jsp"); // Redirect to login if user ID is not found in cookies
        return;
    }

    int mealId = Integer.parseInt(request.getParameter("mealId"));
    String comment = request.getParameter("comment");

    String query = "INSERT INTO comments (meal_id, user_id, comment, created_at) VALUES (?, ?, ?, NOW())";
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(databaseUrl, username, password);
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, mealId);
        stmt.setInt(2, userId);
        stmt.setString(3, comment);
        stmt.executeUpdate();

        response.sendRedirect("mealDetails.jsp?id=" + mealId);
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println(e.getMessage());
    } finally {
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
