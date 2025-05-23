<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snake Game</title>
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
        #game-container {
            width: 400px;
            height: 400px;
            margin: 0 auto;
            border: 2px solid #f9004d;
            position: relative;
        }
        #score {
            text-align: center;
            font-size: 20px;
            margin-top: 10px;
        }
        button{
            background-color: #212327;
            color: #c4cfde;
            border: 1px solid #f9004d;
            padding: 10px 20px;
            border-radius: 5px;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            cursor: pointer;
            width: 110px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #1e2024;
            color: #f9004d;
        }
        button:focus {
            outline: none;
        }
        a{
            text-decoration: none;
            color: inherit;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>Snake Game</h1>
    <div id="game-container">
        <canvas id="game-canvas"></canvas>
        <div id="score">Score: <span id="score-value">0</span></div>
        <button><a href="/jaysius/home2">Back</a></button>
    </div>
    <script>
        // JavaScript code
        document.addEventListener('DOMContentLoaded', function () {
            const canvas = document.getElementById('game-canvas');
            const ctx = canvas.getContext('2d');
            const gridSize = 20; // Size of each grid cell
            const columns = 20; // Number of columns in the game grid
            const rows = 20; // Number of rows in the game grid

            canvas.width = columns * gridSize;
            canvas.height = rows * gridSize;

            let snake = [{ x: 10, y: 10 }]; // Initial position of the snake
            let food = getRandomFoodPosition(); // Initial position of the food
            let dx = 0; // Horizontal velocity of the snake
            let dy = 0; // Vertical velocity of the snake
            let score = 0;

            document.addEventListener('keydown', handleKeyPress);

            function handleKeyPress(event) {
                const key = event.key;
                switch (key) {
                    case 'ArrowUp':
                        if (dy !== 1) { dx = 0; dy = -1; }
                        break;
                    case 'ArrowDown':
                        if (dy !== -1) { dx = 0; dy = 1; }
                        break;
                    case 'ArrowLeft':
                        if (dx !== 1) { dx = -1; dy = 0; }
                        break;
                    case 'ArrowRight':
                        if (dx !== -1) { dx = 1; dy = 0; }
                        break;
                }
            }

            function getRandomFoodPosition() {
                return {
                    x: Math.floor(Math.random() * columns),
                    y: Math.floor(Math.random() * rows)
                };
            }

            function draw() {
                // Clear the canvas
                ctx.clearRect(0, 0, canvas.width, canvas.height);

                // Draw the snake
                snake.forEach((segment, index) => {
                    ctx.fillStyle = index === 0 ? 'white' : 'green'; // Head is red, tail is green
                    ctx.fillRect(segment.x * gridSize, segment.y * gridSize, gridSize, gridSize);
                });

                // Draw the food as a circle
                ctx.fillStyle = 'red';
                ctx.beginPath();
                ctx.arc((food.x + 0.5) * gridSize, (food.y + 0.5) * gridSize, gridSize / 2, 0, Math.PI * 2);
                ctx.fill();

                // Draw the score
                document.getElementById('score-value').innerText = score;
            }

            function update() {
                // Move the snake
                const head = { x: snake[0].x + dx, y: snake[0].y + dy };
                snake.unshift(head);

                // Check if snake eats food
                if (head.x === food.x && head.y === food.y) {
                    score++;
                    food = getRandomFoodPosition();
                } else {
                    snake.pop();
                }

                // Check for collision with walls
                if (head.x < 0 || head.x >= columns || head.y < 0 || head.y >= rows) {
                    gameOver();
                }

                // Check for collision with self
                if (snake.some((segment, index) => index !== 0 && segment.x === head.x && segment.y === head.y)) {
                    gameOver();
                }
            }

            function gameOver() {
                alert('Game Over! Your score: ' + score);
                location.reload();
            }

            function main() {
                update();
                draw();
                setTimeout(main, 100);
            }

            main();
        });
    </script>
</body>
</html>
