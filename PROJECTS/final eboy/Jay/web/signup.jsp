<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // SQL query to insert new user into the database
    String insertSql = "INSERT INTO login (username, age, phone_number, nationality, gender, password) VALUES (?, ?, ?, ?, ?, ?)";
    String checkUsernameSql = "SELECT * FROM login WHERE username = ?";

    if (request.getParameter("signupBtn") != null) {
      String username = request.getParameter("username");
      String age = request.getParameter("age");
      String number = request.getParameter("phone_number");
      String nationality = request.getParameter("nationality");
      String gender = request.getParameter("gender");
      String password = request.getParameter("password");
      String confirm_password = request.getParameter("confirm_password");

      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Check if username already exists
        pstmt = conn.prepareStatement(checkUsernameSql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
          // Username already exists, show error
          out.println("<script>alert('Username already taken. Please choose another username.');</script>");
        } else {
          // Username is available, proceed with inserting new user
          pstmt = conn.prepareStatement(insertSql);
          pstmt.setString(1, username);
          pstmt.setString(2, age);
          pstmt.setString(3, number);
          pstmt.setString(4, nationality);
          pstmt.setString(5, gender);
          pstmt.setString(6, password);

          pstmt.executeUpdate();

          // Redirect to login page after successful signup
          response.sendRedirect("login.jsp");
        }
      } catch (Exception ex) {
        // Handle any errors
        out.println("<script>alert('Failed to create account. Please try again.');</script>");
        ex.printStackTrace();
      } finally {
        try {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        } catch (SQLException ex) {
          ex.printStackTrace();
        }
      }
    }
  %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
  <style>
   @use postcss-preset-env {
      stage: ;
    }

    /* config.css */
    :root {
      --baseColor: #606468;
    }

    /* helpers/align.css */
    .align {
      display: grid;
      place-items: center;
      min-height: 100vh;
    }

    .grid {
      inline-size: 90%;
      margin-inline: auto;
      max-inline-size: 20rem;
    }

    /* helpers/hidden.css */
    .hidden {
      border: 0;
      clip: rect(0 0 0 0);
      height: 1px;
      margin: -1px;
      overflow: hidden;
      padding: 0;
      position: absolute;
      width: 1px;
    }

    /* helpers/icon.css */
    :root {
      --iconFill: var(--baseColor);
    }

    .icons {
      display: none;
    }

    .icon {
      block-size: 1em;
      display: inline-block;
      fill: var(--iconFill);
      inline-size: 1em;
      vertical-align: middle;
    }

    /* layout/base.css */
    :root {
      --htmlFontSize: 100%;

      --bodyBackgroundColor: #2c3338;
      --bodyColor: var(--baseColor);
      --bodyFontFamily: "Open Sans";
      --bodyFontFamilyFallback: sans-serif;
      --bodyFontSize: 0.875rem;
      --bodyFontWeight: 400;
      --bodyLineHeight: 1.5;
    }

    * {
      box-sizing: inherit;
    }

    html {
      box-sizing: border-box;
      font-size: var(--htmlFontSize);
    }

    body {
      background-color: var(--bodyBackgroundColor);
      color: var(--bodyColor);
      font-family: var(--bodyFontFamily), var(--bodyFontFamilyFallback);
      font-size: var(--bodyFontSize);
      font-weight: var(--bodyFontWeight);
      line-height: var(--bodyLineHeight);
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    /* modules/anchor.css */
    :root {
      --anchorColor: #eee;
    }

    a {
      color: var(--anchorColor);
      outline: 0;
      text-decoration: none;
    }

    a:focus,
    a:hover {
      text-decoration: underline;
    }

    /* modules/form.css */
    :root {
      --formGap: 0.875rem;
    }

    input {
      background-image: none;
      border: 0;
      color: inherit;
      font: inherit;
      margin: 0;
      outline: 0;
      padding: 0;
      transition: background-color 0.3s;
    }

    input[type="submit"] {
      cursor: pointer;
    }

    .form {
      display: grid;
      gap: var(--formGap);
    }

    .form input[type="password"],
    .form input[type="text"],
    .form input[type="number"],
    .form input[type="tel"],
    .form select,
    .form input[type="submit"] {
      inline-size: 100%;
    }

    .form__field {
      display: flex;
    }

    .form__input {
      flex: 1;
    }

    /* modules/login.css */
    :root {
      --loginBorderRadus: 0.25rem;
      --loginColor: #eee;

      --loginInputBackgroundColor: #3b4148;
      --loginInputHoverBackgroundColor: #434a52;

      --loginLabelBackgroundColor: #363b41;

      --loginSubmitBackgroundColor: #ea4c88;
      --loginSubmitColor: #eee;
      --loginSubmitHoverBackgroundColor: #d44179;
    }

    .login {
      color: var(--loginColor);
    }

    .login label,
    .login input[type="text"],
    .login input[type="number"],
    .login input[type="tel"],
    .login select,
    .login input[type="password"],
    .login input[type="submit"] {
      border-radius: var(--loginBorderRadus);
      padding: 1rem;
    }

    .login label {
      background-color: var(--loginLabelBackgroundColor);
      border-bottom-right-radius: 0;
      border-top-right-radius: 0;
      padding-inline: 1.25rem;
    }

    .login input[type="text"],
    .login input[type="number"],
    .login input[type="tel"],
    .login select,
    .login input[type="password"] {
      background-color: var(--loginInputBackgroundColor);
      border-bottom-left-radius: 0;
      border-top-left-radius: 0;
    }

    .login input[type="text"]:focus,
    .login input[type="number"]:focus,
    .login input[type="tel"]:focus,
    .login select:focus,
    .login input[type="password"]:focus,
    .login input[type="text"]:hover,
    .login input[type="number"]:hover,
    .login input[type="tel"]:hover,
    .login select:hover,
    .login input[type="password"]:hover {
      background-color: var(--loginInputHoverBackgroundColor);
    }

    .login input[type="submit"] {
      background-color: var(--loginSubmitBackgroundColor);
      color: var(--loginSubmitColor);
      font-weight: 700;
      text-transform: uppercase;
    }

    .login input[type="submit"]:focus,
    .login input[type="submit"]:hover {
      background-color: var(--loginSubmitHoverBackgroundColor);
    }

    /* modules/text.css */
    p {
      margin-block: 1.5rem;
    }

    .text--center {
      text-align: center;
    }
    select, option{
        font-size: 14px;
        color:#606468;
    }
  </style>
  
</head>
<body>
  <div class="align">
    <div class="grid">
      <form action="signup.jsp" method="post" class="form login">
        <div class="form__field">
          <label for="login__username"><svg class="icon">
              <use xlink:href="#icon-user"></use>
            </svg><span class="hidden">Username</span></label>
          <input id="login__username" type="text" name="username" class="form__input" placeholder="Username" required>
        </div>
        <div class="form__field">
          <label for="login__age"><svg class="icon">
              <use xlink:href="#icon-age"></use>
            </svg><span class="hidden">Age</span></label>
          <input id="login__age" type="number" name="age" class="form__input" placeholder="Age" min="1" max="1000" required>
        </div>
        <div class="form__field">
          <label for="login__number"><svg class="icon">
              <use xlink:href="#icon-phone"></use>
            </svg><span class="hidden">Phone Number</span></label>
          <input id="login__number" type="tel" name="phone_number" class="form__input" placeholder="Phone Number" required>
        </div>
          <div class="form__field">
          <label for="login__nationality"><svg class="icon">
              <use xlink:href="#icon-nationality"></use>
            </svg><span class="hidden">Nationality</span></label>
          <select id="login__nationality" name="nationality" class="form__input" required>
            <option value="" disabled selected>Select Nationality</option>
            <option value="Filipino">Filipino</option>
            <option value="Chinese">Chinese</option>
            <option value="Japanese">Japanese</option>
            <option value="Korean">Korean</option>
            <option value="American">American</option>
            <option value="Canadian">Canadian</option>
            <option value="British">British</option>
            <option value="Australian">Australian</option>
            <option value="Indian">Indian</option>
            <option value="Other">Other</option>
          </select>
        </div>
        <div class="form__field">
          <label for="login__gender"><svg class="icon">
              <use xlink:href="#icon-gender"></use>
            </svg><span class="hidden">Gender</span></label>
          <select id="login__gender" name="gender" class="form__input" required>
            <option value="" disabled selected>Gender</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
          </select>
        </div>
        <div class="form__field">
          <label for="login__password"><svg class="icon">
              <use xlink:href="#icon-lock"></use>
            </svg><span class="hidden">Password</span></label>
          <input id="login__password" type="password" name="password" class="form__input" placeholder="Password" required>
        </div>
          <div class="form__field">
        <label for="login__confirm_password"><svg class="icon">
            <use xlink:href="#icon-lock"></use>
          </svg><span class="hidden">Confirm Password</span></label>
        <input id="login__confirm_password" type="password" name="confirm_password" class="form__input" placeholder="Confirm Password" required>
      </div>
        <div class="form__field">
          <input type="submit" name="signupBtn" value="Sign Up">
        </div>
      </form>

      <p class="text--center">Already a member? <a href="login.jsp">Log in now</a>
        <svg class="icon">
          <use xlink:href="#icon-arrow-right"></use>
        </svg>
      </p>
    </div>
  </div>

<!-- SVG Icons -->
    <svg xmlns="http://www.w3.org/2000/svg" class="icons">
        <symbol id="icon-arrow-right" viewBox="0 0 1792 1792">
            <path d="M1600 960q0 54-37 91l-651 651q-39 37-91 37-51 0-90-37l-75-75q-38-38-38-91t38-91l293-293H245q-52 0-84.5-37.5T128 1024V896q0-53 32.5-90.5T245 768h704L656 474q-38-36-38-90t38-90l75-75q38-38 90-38 53 0 91 38l651 651q37 35 37 90z"/>
        </symbol>
        <symbol id="icon-lock" viewBox="0 0 1792 1792">
            <path d="M640 768h512V576q0-106-75-181t-181-75-181 75-75 181v192zm832 96v576q0 40-28 68t-68 28H416q-40 0-68-28t-28-68V864q0-40 28-68t68-28h32V576q0-184 132-316t316-132 316 132 132 316v192h32q40 0 68 28t28 68z"/>
        </symbol>
        <symbol id="icon-user" viewBox="0 0 1792 1792">
            <path d="M1600 1405q0 120-73 189.5t-194 69.5H459q-121 0-194-69.5T192 1405q0-53 3.5-103.5t14-109T236 1084t43-97.5 62-81 85.5-53.5T538 832q9 0 42 21.5t74.5 48 108 48T896 971t133.5-21.5 108-48 74.5-48 42-21.5q61 0 111.5 20t85.5 53.5 62 81 43 97.5 26.5 108.5 14 109 3.5 103.5zm-320-893q0 159-112.5 271.5T896 896 624.5 783.5 512 512t112.5-271.5T896 128t271.5 112.5T1280 512z"/>
        </symbol>
        <symbol id="icon-age" viewBox="0 0 1792 1792">
            <path d="M896 0C402.3 0 0 402.3 0 896s402.3 896 896 896 896-402.3 896-896S1389.7 0 896 0zm0 1696c-441.4 0-800-358.6-800-800S454.6 96 896 96s800 358.6 800 800-358.6 800-800 800zm48-1184h-96v352h96V512zm0 448h-96v160h96V960z"/>
        </symbol>
        <symbol id="icon-phone" viewBox="0 0 1792 1792">
            <path d="M1280 1184q0-40-28-68l-448-448q-28-28-68-28t-68 28l-96 96q-28 28-28 68 0 15 11 48.5t23 57 23 53.5 11 37q0 20-28 68-36 72-76 144-22 38-43.5 72t-44.5 65.5-45.5 58T478 1340.5 451 1285q-16-31-35-52t-41-40.5-46.5-34-50-22.5T192 1120q-40 0-68 28t-28 68q0 20 12 56.5t31 67 37 68.5 37 63.5 32 49.5q16 32 48 71.5T343 1662t81.5 79.5T525 1771q58 20 126.5 34.5T768 1824t148 1.5 139-28.5q44-18 81-51.5t58-66.5q20-32 35-60t20-57q12-47 26-111.5T1280 1184z"/>
        </symbol>
        <symbol id="icon-nationality" viewBox="0 0 1792 1792">
            <path d="M896 0C402.3 0 0 402.3 0 896s402.3 896 896 896 896-402.3 896-896S1389.7 0 896 0zm0 1696c-441.4 0-800-358.6-800-800S454.6 96 896 96s800 358.6 800 800-358.6 800-800 800zm96-1184H800v384h192V512zm0 448H800v96h192v-96z"/>
        </symbol>
        <symbol id="icon-gender" viewBox="0 0 1792 1792">
            <path d="M896 0c442 0 800 358 800 800s-358 800-800 800-800-358-800-800S454 0 896 0zm48 1248h-96v96h-64v-96H640v-64h48v-352H640v-64h64v-32q0-66 46.5-113T896 576q68 0 116 46.5T1058 736v32h64v64h-64v352h48v64h-48v96h-64v-96zm-48-576q-40 0-68 28t-28 68v32h192v-32q0-40-28-68t-68-28zm192 128v384h-192v-384h192z"/>
        </symbol>
    </svg>
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            var password = document.getElementById('login__password').value;
            var confirm_password = document.getElementById('login__confirm_password').value;

            if (password !== confirm_password) {
                alert('Passwords do not match');
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
