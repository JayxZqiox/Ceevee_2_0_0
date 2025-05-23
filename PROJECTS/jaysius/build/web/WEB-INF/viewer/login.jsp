<%-- 
    Document   : login
    Created on : Apr 6, 2024, 11:25:10 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>@import url("https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap");
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Quicksand", sans-serif;
}

body {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: #111;
  overflow: hidden;
}

.ring {
  position: relative;
  width: 300px;
  height: 300px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
}

.ring i {
  position: absolute;
  inset: 0;
  border: 2px solid #fff;
  transition: 0.5s;
}

.ring i:nth-child(1) {
  border-radius: 50%;
  animation: animate 6s linear infinite;
}

.ring i:nth-child(2) {
  border-radius: 50%;
  animation: animate 4s linear infinite;
}

.ring i:nth-child(3) {
  border-radius: 50%;
  animation: animate2 10s linear infinite;
}

.ring:hover i {
  border: 6px solid #fff;
  filter: drop-shadow(0 0 20px #fff);
}

@keyframes animate {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes animate2 {
  0% {
    transform: rotate(360deg);
  }
  100% {
    transform: rotate(0deg);
  }
}

.login {
  width: 300px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
}

.login h2 {
  font-size: 2em;
  color: #fff;
  margin-bottom: 20px;
}

.login .inputBx {
  position: relative;
  margin-bottom: 20px;
}

.login .inputBx input {
  width: 100%;
  padding: 12px 20px;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid #fff;
  border-radius: 40px;
  font-size: 1.2em;
  color: #fff;
  outline: none;
}

.login .inputBx input[type="submit"] {
  background: linear-gradient(45deg, #ff357a, #fff172);
  border: none;
  cursor: pointer;
}

.login .inputBx input::placeholder {
  color: rgba(255, 255, 255, 0.75);
}

.login .links {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.login .links a {
  color: #fff;
  text-decoration: none;
}

</style>
    </head>
<body>
    <!--ring div starts here-->
    <div class="ring">
        <i style="--clr:#00ff0a;"></i>
        <i style="--clr:#ff0057;"></i>
        <i style="--clr:#fffd44;"></i>
        <div class="login">
            <h2>Login</h2>
            <form method="post"> <!-- Modify action to the servlet or JSP where validation will be handled -->
                <div class="inputBx">
                    <input type="text" name="username" placeholder="Username"> <!-- Added name attribute -->
                </div><br>
                <div class="inputBx">
                    <input type="password" name="password" placeholder="Password"> <!-- Added name attribute -->
                </div><br>
                <div class="inputBx">
                    <input type="submit" value="Sign in">
                </div>
            </form>
<%@page import="java.io.*"%>
<%
    // Retrieve username and password from request parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Initialize error message
    String errorMessage = "";

    // Check if username and password match
    if ("jd".equals(username) && "1234".equals(password)) {
        // Redirect to another JSP page upon successful login
        response.sendRedirect("/jaysius/home"); // Replace "welcome.jsp" with the desired destination
    }
    else if ("jay".equals(username) && "1234".equals(password)) {
        // Redirect to another JSP page upon successful login
        response.sendRedirect("/jaysius/home2"); // Replace "welcome.jsp" with the desired destination
    } else {
        // Set error message for authentication failure
        errorMessage = "Incorrect username or password";
    }
    
%>
        </div>
    </div>
    <!--ring div ends here-->
</body>
</html>
