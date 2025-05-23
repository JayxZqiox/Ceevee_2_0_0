<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Spinner Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #212428;
            color: #c4cfde;
            margin: 0;
            margin-top: 100px;
            padding: 0;
            box-sizing: border-box;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 50px;
            border: 2px solid #f9004d; /* Add border */
            padding: 20px; /* Add padding */
            width: 50%; /* Set width */
            margin: 0 auto; /* Center horizontally */
            border-radius: 10px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            color: #c4cfde;
            margin-bottom: 10px;
        }
        input[type="number"], input[type="text"] {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #c4cfde;
            background-color: #212327;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            margin-bottom: 10px;
            width: 210px;
        }
        input[type="text"]:focus, input[type="number"]:focus {
            outline: none;
            border-color: #f9004d;
        }
        button{
            background-color: #212327;
            color: #c4cfde;
            border: 1px solid #c4cfde;
            padding: 10px 20px;
            border-radius: 5px;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            cursor: pointer;
            width: 110px;
            transition: background-color 0.3s ease;
        }
        button[type="submit"]{
            margin-left: 88px;
        }
        button:hover {
            background-color: #1e2024;
            color: #f9004d;
        }
        button:focus {
            outline: none;
        }
        input[type="text"][readonly] {
            background-color: #212327;
            color: #c4cfde;
            border: none;
            padding: 10px;
            width: 210px;
        }
        a{
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Spinner Calculator</h1>
        <form method="post">
            <label for="number1">Number 1:</label>
            <input type="number" id="number1" name="number1">
            <br>
            <label for="number2">Number 2:</label>
            <input type="number" id="number2" name="number2">
            <br>
            <button type="submit" name="action" value="calculate">Enter</button>
            <button><a href="/jaysius/home2">Back</a></button>
            <br>
            <label for="result">Result:</label>
            <input type="text" id="result" name="result" readonly>
        </form>

        <% if ("calculate".equals(request.getParameter("action"))) {
                int number1 = Integer.parseInt(request.getParameter("number1"));
                int number2 = Integer.parseInt(request.getParameter("number2"));
                int sum = number1 + number2;
        %>
                <script>
                    document.getElementById("result").value = <%= sum %>;
                </script>
        <% } %>
    </div>
</body>
</html>
