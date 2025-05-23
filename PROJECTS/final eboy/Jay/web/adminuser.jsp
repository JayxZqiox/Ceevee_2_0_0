<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Initialize search query
    String searchQuery = request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "";

    // SQL query to fetch recipes from the database
    String fetchSql = "SELECT * FROM login";
    if (!searchQuery.isEmpty()) {
        fetchSql += " WHERE username LIKE ?";
    }

    // Initialize the database connection and statement
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create a prepared statement to execute the SQL query
        pstmt = conn.prepareStatement(fetchSql);
        if (!searchQuery.isEmpty()) {
            String searchPattern = "%" + searchQuery + "%";
            pstmt.setString(1, searchPattern);
        }

        // Execute the query to fetch recipes from the database
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Accounts</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        .button-controls {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease-in-out;
        }
        .button:hover {
            background-color: #555;
        }
        .searchbar1 {
            margin-top: 50px;
            display: flex;
            align-items: center;
        }
        .searchbar1 input[type="text"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px 0 0 5px;
        }
        .searchbar button {
            padding: 10px 20px;
            border-radius: 0 5px 5px 0;
            border: 1px solid #ddd;
            background-color: #333;
            color: #fff;
        }
        .searchbar button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
<div class="app-library-container">
    <div class="grid-container">
        <!-- navigation -->
        <nav class="navigation">
            <div class="navigation-brand">
                <i class="fal fa-angle-left"></i>
                <span>ADMIN DASHBOARD</span>
                <a href="admindashboard.jsp"><button class="button">Recipes</button></a>
                <a href="adminuser.jsp"><button class="button">Users</button></a>
                <a href="admincategory.jsp"><button class="button">Category</button></a>
                <a href="login.jsp"><button class="button">Logout</button></a>
            </div>
        </nav>

        <!-- app container -->
        <div class="app-info-box">
            <div class="app-info-content">
                <!-- headline -->
                <div class="headline">
                    <h2>User Accounts</h2>
                    <h3>Dashboard</h3>
                </div>

                <!-- searchbar -->
                <div class="searchbar1">
                    <form action="adminuser.jsp" method="get">
                        <i class="fal fa-search"></i>
                        <input type="text" name="searchQuery" placeholder="Search Recipe" value="<%= searchQuery %>">
                        <button type="submit" class="button">Search</button>
                    </form>
                </div>
                <!-- user accounts list -->
                <section class="app-library">
                    <table>
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Age</th>
                                <th>Phone Number</th>
                                <th>Nationality</th>
                                <th>Gender</th>
                                <th>Password</th>
                                <th>Action</th>
                                <!-- Add more table headers as needed -->
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                while (rs.next()) {
                                    String username = rs.getString("username");
                                    String age = rs.getString("age");
                                    String phone = rs.getString("phone_number");
                                    String nationality = rs.getString("nationality");
                                    String gender = rs.getString("gender");
                                    String password = rs.getString("password");
                                    // Add more fields as needed
                            %>
                            <tr>
                                <td><%= username %></td>
                                <td><%= age %></td>
                                <td><%= phone %></td>
                                <td><%= nationality %></td>
                                <td><%= gender %></td>
                                <td><%= password%></td>
                                <td class="action-buttons">
                                       <form action="updateUser.jsp" method="post">
                                            <input type="hidden" name="userId" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="button">Update</button>
                                        </form>
                                        <form action="deleteUser.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this User?');">
                                            <input type="hidden" name="userId" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="button red">Delete</button>
                                        </form>
                                </td>
                                <!-- Add more table cells as needed -->
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </section>

                <!-- button controls -->
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to fetch user accounts. Please try again.');</script>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    } finally {
        // Close the database resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
