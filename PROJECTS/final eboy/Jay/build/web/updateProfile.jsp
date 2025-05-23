<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@2.1.0/css/boxicons.min.css">
    <title>Update Profile</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap');
        body {
            background-color: #F3F0D7;
            font-family: "Poppins", sans-serif;
            transition: background 0.4s linear;
            position: relative;
            min-height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            width: 60%;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 1px 1px 18px rgba(14,14,14,0.3);
        }
        .container h3 {
            text-align: center;
            font-size: 32px;
            color: #F29191;
            transition: color 0.4s ease-in-out;
            cursor: pointer;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #F29191;
        }
        button {
            width: 100%;
            background-color: #F29191;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }
        button:hover {
            background-color: #D85C5C;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Update Profile</h3>
    <%
        int userId = Integer.parseInt(request.getParameter("userId"));
        String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
        String username = "root";
        String password = "";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String userName = "";
        String email = "";
        String gender = "";
        String age = "";
        String phone = "";
        String nationality = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(databaseUrl, username, password);

            String query = "SELECT username, gender, age, phone_number, nationality FROM login WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                userName = rs.getString("username");
                gender = rs.getString("gender");
                age = rs.getString("age");
                phone = rs.getString("phone_number");
                nationality = rs.getString("nationality");
            }

            rs.close();
            stmt.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <form action="saveProfile.jsp" method="post">
        <input type="hidden" name="userId" value="<%= userId %>">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" value="<%= userName %>" required>
        </div>
        <div class="form-group">
            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
            </select>
        </div>
        <div class="form-group">
            <label for="age">Age</label>
            <input type="number" id="age" name="age" value="<%= age %>" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone" value="<%= phone %>" required>
        </div>
        <div class="form-group">
            <label for="nationality">Nationality</label>
            <input type="text" id="nationality" name="nationality" value="<%= nationality %>" required>
        </div>
        <button type="submit">Save Changes</button>
    </form>
</div>
</body>
</html>
