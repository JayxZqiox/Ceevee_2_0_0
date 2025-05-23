<%-- 
    Document   : home
    Created on : Apr 6, 2024, 11:27:42 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background-color: #1c1e22;
;
    overflow-x: clip;
}

ul {
    list-style: none;
}

.tabs {
    width: 80%;
    height: 100px;
    margin: auto;
    margin-top: 50px;
    display: flex;
    align-items: center;
    box-shadow: 10px 10px 19px #1c1e22, -10px -10px 19px #262a2e;
    overflow: hidden;
    border-radius: 10px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -ms-border-radius: 10px;
    -o-border-radius: 10px;
}

.tabs li {
    background-color: #1c1e22;
    width: 25%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #c4cfde;
    font-family: 'Poppins', sans-serif;
    transition: .5s;
    -webkit-transition: .5s;
    -moz-transition: .5s;
    -ms-transition: .5s;
    -o-transition: .5s;
    cursor: pointer;
}

.tabs li:hover {
    background: linear-gradient(145deg, #1e2024, #23272b);
    box-shadow: 10px 10px 19px #1c1e22, -10px -10px 19px #262a2e;
    color: #f9004d;
    position: relative;
    z-index: 1;
    border-radius: 10px;
}

.active {
    background: linear-gradient(145deg, #1e2024, #23272b);
    box-shadow: 10px 10px 19px #1c1e22, -10px -10px 19px #262a2e;
    color: #f9004d !important;
    position: relative;
    z-index: 1;
    border-radius: 10px;
}

.contents {
    width: 80%;
    margin: auto;
    margin-top: 50px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 30px;
}

.box {
    gap: 20px;
    background: linear-gradient(145deg, #1e2024, #23272b);
    box-shadow: 10px 10px 19px #1c1e22, -10px -10px 19px #262a2e;
    border-radius: 10px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -ms-border-radius: 10px;
    -o-border-radius: 10px;
    padding: 20px;
    width: 100%;
    animation: moving 1s ease;
    -webkit-animation: moving 1s ease;
}

.box img {
    width: 450px;
    border-radius: 10px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -ms-border-radius: 10px;
    -o-border-radius: 10px;
}

.box h3 {
    color: #c4cfde;
    font-family: 'Poppins', sans-serif;
    font-size: 2rem;
    margin-bottom: 20px;
}

.box p {
    color: #c4cfde;
    opacity: .5;
    font-family: 'Poppins', sans-serif;
    font-size: 1rem;
}

.show {
    display: flex;
}

.hide {
    display: none;
}

@keyframes moving {
    from {
        transform: translateX(-50px);
        -webkit-transform: translateX(-50px);
        -moz-transform: translateX(-50px);
        -ms-transform: translateX(-50px);
        -o-transform: translateX(-50px);
        opacity: 0;
    }

    to {
        transform: translateX(0px);
        -webkit-transform: translateX(0px);
        -moz-transform: translateX(0px);
        -ms-transform: translateX(0px);
        -o-transform: translateX(0px);
        opacity: 1;
    }
}
.box button {
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

.box button:hover {
    background: linear-gradient(145deg, #1e2024, #23272b);
    color: #f9004d;
}
.box2 button {
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

.box2 button:hover {
    background: linear-gradient(145deg, #1e2024, #23272b);
    color: #f9004d;
}
a{
    text-decoration: none;
    color: inherit;
}
        </style>
    </head>
    <body>
        <div class="box2">
    <button><a href="/jaysius/login">Logout</a></button>
        </div>
    <ul class="tabs">
        <li class="active" data-id="0">About Me</li>
        <li data-id="1">Letter</li>
        <li data-id="2">Video</li>
        <li data-id="3">Converter</li>
    </ul>

    <div class="contents">

        <div class="box show" data-content="0">
            <img src="https://scontent.xx.fbcdn.net/v/t1.6435-9/117556791_1689581107876835_4656939590889537816_n.jpg?stp=dst-jpg_s851x315&_nc_cat=108&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGG7AlLodUtk5tWBicUHWTsBge2H0OcgicGB7YfQ5yCJ4hNkLh6SPYgbGx6ljdSsccWoOTYmsxj4Mw_lh7zIYj6&_nc_ohc=4gJqoP47yt4Ab4hQefm&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=00_AfAIup8ImsidwF8n367BRJWRAT7rSFnGvkfcKcbqWzrwNQ&oe=663D782B" alt="">
            <div>
                <h3>About Me</h3>
                <p>

Create a captivating "About Me" webpage where I introduce myself succinctly and engagingly. It should feature sections covering my background, education, work experience, skills, passions, and contact information. I'll include visuals like photos to add a personal touch and encourage visitors to connect with me. The design will be clean, visually appealing, and reflect my personality. With a clear call to action, I'll prompt visitors to reach out, subscribe, or follow me on social media, ensuring an interactive and memorable experience.
                </p>
                <button><a href="https://erownnnnn.github.io/jasius2.0/">Proceed</a></button>
            </div>
        </div>

        <div class="box hide" data-content="1">
            <img src="https://i.pinimg.com/564x/ac/f9/b2/acf9b212bc5bafa0817e64ef0423e8ad.jpg" alt="">
            <div>
                <h3>Letter Only</h3>
                <p>

"Our 'letter only' files feature tailored messages crafted for effective communication. With personalized salutations, clear content, and professional closings, they're suitable for various contexts. Designed with attention to detail, these letters leave a lasting impression, ensuring successful message delivery."
                </p>
                 <button><a href="/jaysius/letter">Proceed</a></button>
            </div>
        </div>

        <div class="box hide" data-content="2">
            <img src="https://i.pinimg.com/564x/68/78/fc/6878fc9738d5c50b59abc46a432c6578.jpg" alt="">
            <div>
                <h3>Video</h3>
                <p>

Experience a captivating webpage filled with an eclectic mix of entertaining GIFs and videos. From hilarious memes to breathtaking landscapes, explore a diverse range of content curated to delight and inspire. With seamless navigation and intuitive design, enjoy moments of joy, wonder, and relaxation with every click. Whether seeking a quick laugh or a moment of awe-inspiring beauty, find endless entertainment and inspiration at your fingertips.
                </p>
                 <button><a href="/jaysius/video">Proceed</a></button>
            </div>
        </div>

        <div class="box hide" data-content="3">
            <img src="https://i.pinimg.com/564x/17/4e/19/174e196a0267a2bcdc3b5052742698c6.jpg" alt="">
            <div>
                <h3>Temperature Converter</h3>
                <p>
Discover the ultimate temperature converter tool! Effortlessly convert between Celsius, Fahrenheit, and Kelvin with a user-friendly interface. Input your desired temperature value and select the units to convert to instantly get accurate results. Whether you're planning a trip abroad or simply curious about the weather, this handy converter makes temperature conversions a breeze. Simplify your calculations and stay informed with this essential tool for any weather enthusiast.
                </p>
                 <button><a href="/jaysius/convert">Proceed</a></button>
            </div>
        </div>
    </div>
        <script>
            'use strict';
const tabs = document.querySelectorAll('[data-id]');
const contents = document.querySelectorAll('[data-content]');
let id = 0;

tabs.forEach(function (tab) {
    tab.addEventListener('click', function () {
        tabs[id].classList.remove('active');
        tab.classList.add('active');
        id = tab.getAttribute('data-id');
        contents.forEach(function (box) {
            box.classList.add('hide');
            if (box.getAttribute('data-content') == id){
                box.classList.remove('hide');
                box.classList.add('show');
            }
        });
    });
});
        </script>     
    </body>
</html>
