<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<html>
<head>
    <title>Portfolio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #0d1117;
            color: #eaeaea;
        }

        /* NAVBAR */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 60px;
            background: #0d1117;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        nav .logo {
            font-size: 22px;
            font-weight: bold;
            color: #fff;
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 30px;
        }
        nav ul li a {
            text-decoration: none;
            color: #eaeaea;
            font-weight: 500;
        }
        nav ul li a:hover,
        nav ul li a.active {
            color: #00ffff;
        }

        /* HERO SECTION */
        .hero {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 80px 10%;
        }
        .hero-text {
            flex: 1;
        }
        .hero-text h1 {
            font-size: 40px;
            color: #fff;
        }
        .hero-text h2 {
            font-size: 28px;
            font-weight: 600;
            margin: 10px 0;
            color: #00ffff;
        }
        .hero-text p {
            color: #a8a8a8;
            margin: 20px 0;
            max-width: 500px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 30px;
            background: #00ffff;
            color: #0d1117;
            font-weight: bold;
            text-decoration: none;
            transition: 0.3s;
        }
        .btn:hover {
            background: #00cccc;
        }

        /* PROFILE IMAGE */
        .hero-img {
            flex: 1;
            text-align: center;
        }
        .hero-img img {
            width: 280px;
            height: 280px;
            border-radius: 50%;
            border: 6px solid #00ffff;
            box-shadow: 0 0 40px #00ffff;
            object-fit: cover;
        }

        /* SECTIONS */
        .container {
            width: 85%;
            margin: 60px auto;
        }
        .section {
            margin-bottom: 70px;
        }
        .section h3 {
            font-size: 26px;
            margin-bottom: 30px;
            color: #00ffff;
            border-left: 5px solid #00ffff;
            padding-left: 12px;
        }
        .card {
            background: #161b22;
            border-radius: 12px;
            padding: 20px;
            margin: 15px 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.4);
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        /* FOOTER */
        footer {
            background: #0d1117;
            color: #aaa;
            padding: 30px 20px;
            text-align: center;
            margin-top: 50px;
        }
        .footer-contact p {
            margin: 5px 0;
            font-size: 14px;
            color: #eaeaea;
        }
        .footer-socials {
            margin-top: 10px;
        }
        .footer-socials a {
            margin: 0 8px;
            font-size: 22px;
            color: #00ffff;
            text-decoration: none;
            transition: 0.3s;
        }
        .footer-socials a:hover {
            color: #00cccc;
        }
    </style>
</head>
<body>

<!-- NAV -->
<nav>
    <div class="logo">Portfolio.</div>
    <ul>
        <li><a href="#home" class="active">Home</a></li>
        <li><a href="#projects">Projects</a></li>
        <li><a href="#messages">Messages</a></li>
        <li><a href="#export">Export</a></li>
    </ul>
</nav>

<!-- HERO -->
<section id="home" class="hero">
    <div class="hero-text">
        <h1>Hello, It's Me</h1>
        <h2>${portfolio.name}</h2>
        <p>${portfolio.skills}</p>
        <p>${portfolio.experience}</p>
        <a class="btn" href="/exportPortfolioPdf">📤 Download CV</a>
    </div>
    <div class="hero-img">
        <img src="uploads/${portfolio.photoPath}" alt="Profile Photo" width="150" height="150">
    </div>
</section>

<div class="container">

    <!-- Projects -->
    <div id="projects" class="section">
        <h3>🚀 Projects</h3>
        <c:if test="${not empty projects}">
            <div class="grid">
                <c:forEach var="p" items="${projects}">
                    <div class="card">
                        <p><b>Title:</b> ${p.title}</p>
                        <p>${p.description}</p>
                        <c:if test="${not empty p.link}">
                            <p><a href="${p.link}" target="_blank">🔗 Project Link</a></p>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty projects}">
            <p>No projects added yet.</p>
        </c:if>
    </div>

    <!-- Messages -->
    <div id="messages" class="section">
        <h3>📩 Contact Messages</h3>
        <c:if test="${not empty messages}">
            <div class="grid">
                <c:forEach var="m" items="${messages}">
                    <div class="card">
                        <p><b>Name:</b> ${m.name}</p>
                        <p><b>Email:</b> ${m.email}</p>
                        <p><b>Message:</b> ${m.content}</p>
                        <p><i>Sent at: ${m.sentAt}</i></p>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty messages}">
            <p>No messages received yet.</p>
        </c:if>
    </div>

    <!-- Export -->
    <div id="export" class="section" style="text-align:center;">
        <a class="btn" href="/exportPortfolioPdf">📤 Export as PDF</a>
    </div>

</div>

<!-- FOOTER -->
<footer>
    <div class="footer-contact">
        <p><b>📧 Email:</b> ${portfolio.email}</p>
        <p><b>📞 Phone:</b> ${portfolio.phone}</p>
    </div>

    <div class="footer-socials">
        <c:if test="${not empty portfolio.linkedin}">
            <a href="${portfolio.linkedin}" target="_blank"><i class="fab fa-linkedin"></i></a>
        </c:if>
        <c:if test="${not empty portfolio.instagram}">
            <a href="${portfolio.instagram}" target="_blank"><i class="fab fa-instagram"></i></a>
        </c:if>
        <c:if test="${not empty portfolio.twitter}">
            <a href="${portfolio.twitter}" target="_blank"><i class="fab fa-twitter"></i></a>
        </c:if>
        <c:if test="${not empty portfolio.facebook}">
            <a href="${portfolio.facebook}" target="_blank"><i class="fab fa-facebook"></i></a>
        </c:if>
    </div>

    <p style="margin-top:15px;">© ${portfolio.name} | Built with ❤️ and JSP</p>
</footer>

</body>
</html>
