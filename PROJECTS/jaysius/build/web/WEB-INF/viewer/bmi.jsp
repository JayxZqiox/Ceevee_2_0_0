<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BMI Calculator</title>
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

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #c4cfde;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="number"],
        input[type="radio"] {
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

        input[type="radio"] {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #c4cfde;
            background-color: #212327;
            text-align: center;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
            width: 60px; /* Set the width */
            height: 15px; /* Set the height */
            margin-right: 10px; /* Adjust spacing between radio buttons and labels */
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        input[type="radio"]:focus {
            outline: none;
            border-color: #f9004d;
        }

        .radio-container {
            margin-bottom: 20px;
        }

        .radio-container label {
            margin-right: 10px;
            display: inline-block;
            color: #c4cfde;
        }

        .buttons-container {
            display: flex;
            justify-content: space-around;
            width: 20%;
            margin-bottom: 20px;
        }

        .buttons-container button {
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

        .buttons-container button:hover {
            background-color: #1e2024;
            color: #f9004d;
        }

        .buttons-container button:focus {
            outline: none;
        }

        .result {
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            margin-right: 250px;
            margin-left: 250px;
            border-radius: 5px;
            border: 2px solid gray;
        }

        a {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>BMI Calculator</h2>
        <%
            if ("calculate".equals(request.getParameter("action"))) {
                double weight = Double.parseDouble(request.getParameter("weight"));
                double height = Double.parseDouble(request.getParameter("height"));
                String weightUnit = request.getParameter("weightUnit");
                String heightUnit = request.getParameter("heightUnit");

                // Convert weight to kg if necessary
                if (weightUnit.equals("lbs")) {
                    weight *= 0.453592; // convert lbs to kg
                }

                // Convert height to meters if necessary
                if (heightUnit.equals("inch")) {
                    height *= 0.0254; // convert inch to meters
                } else if (heightUnit.equals("cm")) {
                    height *= 0.01; // convert cm to meters
                }

                // Calculate BMI
                double bmi = weight / (height * height);

                // Determine BMI category
                String result = "";
                if (bmi >= 30) {
                    result = "Obese";
                } else if (bmi >= 25) {
                    result = "Overweight";
                } else if (bmi >= 18.5) {
                    result = "Normal weight";
                } else {
                    result = "Underweight";
                }

                // Format BMI result to two decimal places
                java.text.DecimalFormat df = new java.text.DecimalFormat("#.##");
                String formattedBMI = df.format(bmi);

                // Display BMI result
                out.println("<div class='result'>BMI: " + formattedBMI + " - " + result + "</div>");
            }
        %>
        <form method="post">
            <div class="line">
                <input type="text" id="weight" name="weight" placeholder="Enter weight">
                <div class="radio-container">
                    <input type="radio" id="kg" name="weightUnit" value="kg" checked>
                    <label for="kg">kg</label>
                    <input type="radio" id="lbs" name="weightUnit" value="lbs">
                    <label for="lbs">lbs</label>
                </div>
            </div>
            <div class="line">
                <input type="text" id="height" name="height" placeholder="Enter height">
                <div class="radio-container">
                    <input type="radio" id="inch" name="heightUnit" value="inch" checked>
                    <label for="inch">inch</label>
                    <input type="radio" id="cm" name="heightUnit" value="cm">
                    <label for="cm">cm</label>
                </div>
            </div>
            <div class="buttons-container">
                <button type="submit" name="action" value="calculate">Enter</button>
                <button type="reset">Clear</button>
                <button><a href="/jaysius/home2">Back</a></button>
            </div>
        </form>
    </div>
</body>
</html>
