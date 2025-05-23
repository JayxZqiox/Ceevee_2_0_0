<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Temperature Converter</title>
    <style>
        /* Add CSS styles to match the design */
        body {
            background-color: #212428;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            margin-top: 80px;
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
            margin-top: 0; /* Remove default margin */
            margin-bottom: 20px; /* Add space between h1 and form */
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        label {
            color: #c4cfde;
            margin-bottom: 10px;
        }

        select,
        input[type="text"] {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #c4cfde;
            background-color: #212327;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            margin-bottom: 10px;
        }

        select:focus,
        input[type="text"]:focus {
            outline: none;
            border-color: #f9004d;
        }

        input[type="submit"],
        input[type="button"],
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

        input[type="submit"]:hover,
        input[type="button"]:hover,
        button:hover {
            background-color: #1e2024;
            color:#f9004d;
        }

        input[type="submit"]:focus,
        input[type="button"]:focus,
        button:focus {
            outline: none;
        }

        button a {
            text-decoration: none;
            color: inherit;
        }

        .converter-container {
            display: flex;
            justify-content: space-around;
            width: 100%;
            margin-bottom: 20px;
        }

        .buttons-container {
            display: flex;
            justify-content: space-around;
            width: 20%;
            margin-bottom: 20px;
            margin-right: 100px;
        }

        .back-button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Temperature Converter</h1> <!-- Move h1 inside container -->
        
        <div class="converter-container">
            <form method="post">
                <label for="unitFrom">From:</label>
                <select id="unitFrom" name="unitFrom">
                    <option value="Celsius">Celsius</option>
                    <option value="Fahrenheit">Fahrenheit</option>
                    <option value="Kelvin">Kelvin</option>
                </select>
                <br>
                <label for="unitTo">To:</label>
                <select id="unitTo" name="unitTo">
                    <option value="Celsius">Celsius</option>
                    <option value="Fahrenheit">Fahrenheit</option>
                    <option value="Kelvin">Kelvin</option>
                </select>
                <br>
                <label for="valueFrom">Value:</label>
                <input type="text" id="valueFrom" name="valueFrom">
        </div>
        <div class="buttons-container">
            <input type="submit" value="Convert">
            <input type="button" value="Clear" onclick="clearFields()">
            <button><a href="/jaysius/home">Back</a></button>
        </div>
        </form>

        <form method="post">
            <div>
                <label for="convertedValue">Converted Value:</label>
                <input type="text" id="convertedValue" name="convertedValue" readonly>
            </div>
        </form>
    </div>

    <!-- JavaScript and Java code here -->

    <script>
        // JavaScript function to clear form fields
        function clearFields() {
            document.getElementById("unitFrom").selectedIndex = 0;
            document.getElementById("unitTo").selectedIndex = 0;
            document.getElementById("valueFrom").value = "";
            document.getElementById("convertedValue").value = "";
        }
    </script>
</body>
</html>
