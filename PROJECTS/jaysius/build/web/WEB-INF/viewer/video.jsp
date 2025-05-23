<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Video Player</title>
    <style>
        /* Add CSS styles to match the design */
        body {
            background-color: #212428;
            color: #c4cfde;
            font-family: 'Poppins', sans-serif;
            display: flex;
         justify-content: center;
         align-items: center;
         height: 100vh;
            padding: 0;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            margin-top: 50px;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
            border: 2px solid #f9004d; /* Add border */
            padding: 20px; /* Add padding */
            border-radius: 10px;
        }

        video,
        .back-button {
            margin-bottom: 20px;
        }

        .back-button button {
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

        .back-button button:hover {
            background-color: #1e2024;
            color:#f9004d;
        }

        .back-button button:focus {
            outline: none;
        }

        .back-button button a {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>   
    <div class="container">
    <h1>Video Player</h1>
    

        <!-- Replace the image URL with your video source -->
        <img src="https://i.pinimg.com/originals/a3/1d/7f/a31d7f5c20b885859e84ceea2d71d7b6.gif" alt="Animated GIF"><br>
        
        <div class="back-button">
            <button><a href="/jaysius/home">Back</a></button>
        </div>
    </div>
</body>
</html>
