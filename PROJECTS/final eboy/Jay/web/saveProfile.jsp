<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Save Profile</title>
</head>
<body>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    String newUsername = request.getParameter("username");
    String newGender = request.getParameter("gender");
    String newAge = request.getParameter("age");
    String newPhone = request.getParameter("phone");
    String newNationality = request.getParameter("nationality");

    String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
    String username = "root";
    String password = "";
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(databaseUrl, username, password);

        String query = "UPDATE login SET username = ?, gender = ?, age = ?, phone_number = ?, nationality = ? WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, newUsername);
        stmt.setString(2, newGender);
        stmt.setString(3, newAge);
        stmt.setString(4, newPhone);
        stmt.setString(5, newNationality);
        stmt.setInt(6, userId);

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            out.println("<script>alert('Profile updated successfully!'); window.location='profile.jsp';</script>");
        } else {
            out.println("<script>alert('Error updating profile.'); window.location='profile.jsp';</script>");
        }

        stmt.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
