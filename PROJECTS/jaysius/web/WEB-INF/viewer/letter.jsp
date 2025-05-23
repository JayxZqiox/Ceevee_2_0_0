<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Letter Only</title>
    <style>
        /* Add CSS styles to match the design */
        body {
            background-color: #212428;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            border: 2px solid #f9004d;
            padding: 20px;
            max-width: 400px;
            width: 100%;
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }

        label {
            color: #c4cfde;
            margin-bottom: 10px;
        }

        input[type="text"] {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #c4cfde;
            background-color: #212327;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            margin-bottom: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #f9004d;
        }

        button {
            background-color: #212327;
            color: #c4cfde;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #1e2024;
            color: #f9004d;
        }

        button:focus {
            outline: none;
        }

        button a {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>    
    <div class="container">
        <h1>Letter Only</h1>

        <form method="post">
            <label for="letterInput">Enter Letter:</label>
            <input type="text" id="letterInput" name="letterInput" onkeypress="return allowLettersOnly(event)">
            <br>
            <button><a href="/jaysius/home">Back</a></button>
        </form>
        
        <%!
            // Define a Java function to allow only letters and space characters
            public boolean allowLettersOnly(char c) {
                return Character.isLetter(c) || c == ' ' || Character.isISOControl(c);
            }
        %>
        
        <%!
            // Define a Java function to handle form submission
            public void processForm(String letterInput) {
                // Process the form data here
            }
        %>
        
        <%
            // Check if form submission is detected
            if (request.getMethod().equalsIgnoreCase("post")) {
                String letterInput = request.getParameter("letterInput");
                // Process form data
                processForm(letterInput);
            }
        %>
    </div>
</body>
</html>
