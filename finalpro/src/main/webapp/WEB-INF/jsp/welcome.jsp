<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Welcome - Portfolio</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #0d1117;
            --card: #161b22;
            --accent: #00ffff;
            --accent-dark: #00cccc;
            --text: #eaeaea;
            --muted: #aaa;
            --radius: 18px;
            --shadow: 0 6px 22px rgba(0,0,0,0.5);
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: var(--bg);
            color: var(--text);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: #111827;
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: fixed;
            top: 0; left: 0; bottom: 0;
            border-right: 1px solid rgba(255,255,255,0.1);
            box-shadow: var(--shadow);
        }

        .sidebar h2 {
            margin-bottom: 35px;
            font-size: 20px;
            font-weight: 700;
            color: var(--accent);
        }

        .nav a {
            display: block;
            padding: 12px 16px;
            margin-bottom: 12px;
            border-radius: var(--radius);
            color: var(--text);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav a:hover {
            background: var(--accent);
            color: #000;
            transform: translateX(6px);
        }

        /* Main */
        .container {
            flex: 1;
            margin-left: 270px;
            padding: 35px;
        }

        .card {
            background: var(--card);
            padding: 28px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 30px rgba(0,255,255,0.25);
        }

        h2 {
            margin-bottom: 18px;
            font-size: 24px;
            font-weight: 700;
            color: var(--accent);
            position: relative;
        }

        /* Profile Photo */
        .profile-photo {
            width: 140px;
            border-radius: 50%;
            border: 5px solid var(--accent);
            margin: 12px 0;
            box-shadow: 0 0 25px var(--accent);
            transition: transform 0.3s ease;
        }
        .profile-photo:hover {
            transform: scale(1.05);
        }

        /* Skills */
        .skills span {
            display: inline-block;
            margin: 6px;
            padding: 8px 16px;
            background: var(--accent);
            color: #000;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 0 15px rgba(0,255,255,0.3);
        }
        .skills span:hover {
            transform: scale(1.1);
            box-shadow: 0 0 25px rgba(0,255,255,0.6);
        }

        /* Inputs */
        input, textarea {
            width: 100%;
            padding: 14px;
            margin: 8px 0 18px;
            border: none;
            border-radius: var(--radius);
            font-size: 15px;
            background: #222;
            color: var(--text);
        }
        input:focus, textarea:focus {
            border: 2px solid var(--accent);
            outline: none;
        }

        /* Buttons */
        button, a.btn {
            display: inline-block;
            padding: 12px 22px;
            background: var(--accent);
            color: #000;
            border: none;
            border-radius: var(--radius);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: 0.3s ease;
            margin-top: 6px;
            box-shadow: 0 0 20px rgba(0,255,255,0.4);
        }
        button:hover, a.btn:hover {
            background: var(--accent-dark);
            box-shadow: 0 0 30px rgba(0,255,255,0.7);
        }

        /* Alerts */
        .success {
            background: rgba(0,255,200,0.15);
            color: var(--accent);
            padding: 14px;
            border-radius: var(--radius);
            margin-bottom: 20px;
            border-left: 6px solid var(--accent);
            font-weight: 500;
        }

        /* Responsive */
        @media (max-width: 950px) {
            .sidebar { display: none; }
            .container { margin: 0; padding: 25px; }
        }
    </style>
</head>
<body>

<!-- Sidebar Navigation -->
<div class="sidebar">
    <div>
        <h2>📂 Dashboard</h2>
        <div class="nav">
            <a href="/welcome">🏠 Home</a>
            <a href="#skills">💡 Skills</a>
            <a href="#projects">🚀 Projects</a>
            <a href="#contact">📩 Contact</a>
            <a href="/viewPortfolio">👁 Portfolio</a>
        </div>
    </div>
    <div>
        <a href="/logout" class="btn">🚪 Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="container">

    <!-- Profile -->
    <div class="card">
        <h2>👋 Welcome, ${user.username}!</h2>
        <c:if test="${not empty user.profilePhoto}">
            <img src="/uploads/${user.profilePhoto}" alt="Profile Photo" class="profile-photo" />
        </c:if>
        <p><b>Email:</b> ${user.email}</p>
        <p><b>Resume Views:</b> ${user.resumeViews}</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>
    <c:if test="${not empty msg}">
        <div class="success">${msg}</div>
    </c:if>

    <!-- Skills -->
    <div class="card" id="skills">
        <h2>💡 Skills</h2>
        <div class="skills">
            <c:forEach var="skill" items="${fn:split(user.skills, ',')}">
                <span>${skill}</span>
            </c:forEach>
        </div>
        <form method="post" action="/updateSkills">
            <label>Update Skills:</label>
            <input type="text" name="skills" placeholder="Java, Spring Boot, React" />
            <button type="submit">Update Skills</button>
        </form>
    </div>

    <!-- Projects -->
    <div class="card" id="projects">
        <h2>🚀 My Projects</h2>
        <c:forEach var="project" items="${projects}">
            <div>
                <h3 style="color:var(--accent);">${project.title}</h3>
                <p>${project.description}</p>
                <c:if test="${not empty project.link}">
                    <a href="${project.link}" target="_blank">🔗 View Project</a>
                </c:if>
                <hr style="border:1px solid rgba(255,255,255,0.1)"/>
            </div>
        </c:forEach>

        <h3 style="color:var(--accent);">➕ Add New Project</h3>
        <form method="post" action="/addProject">
            <input type="text" name="title" placeholder="Project Title" required />
            <textarea name="description" placeholder="Project Description" required></textarea>
            <input type="text" name="link" placeholder="Project Link (optional)" />
            <button type="submit">Add Project</button>
        </form>
    </div>

    <!-- Contact -->
    <div class="card" id="contact">
        <h2>📩 Contact Me</h2>
        <form method="post" action="/sendMessage">
            <input type="text" name="name" placeholder="Your Name" required />
            <input type="email" name="email" placeholder="Your Email" required />
            <input type="text" name="phone" placeholder="Phone Number" />
            <input type="text" name="twitter" placeholder="Twitter Handle" />
            <input type="text" name="instagram" placeholder="Instagram ID" />
            <input type="text" name="facebook" placeholder="Facebook ID" />
            <textarea name="message" placeholder="Write your message..." required></textarea>
            <button type="submit">Send Message</button>
        </form>
    </div>

</div>
</body>
</html>
