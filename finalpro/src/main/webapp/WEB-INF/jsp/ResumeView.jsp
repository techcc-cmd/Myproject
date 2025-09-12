<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Resume View</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3498db;
            --primary-dark: #21618c;
            --radius: 16px;
            --shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            color: #2c3e50;
            overflow-x: hidden;
        }

        /* 🌈 Animated Gradient Background */
        body::before {
            content: "";
            position: fixed;
            inset: 0;
            background: linear-gradient(-45deg, #ff6b6b, #3498db, #6a11cb, #2575fc, #f39c12);
            background-size: 500% 500%;
            animation: gradientBG 18s ease infinite;
            z-index: -2;
        }

        body::after {
            content: "";
            position: fixed;
            inset: 0;
            backdrop-filter: blur(50px);
            background: rgba(255, 255, 255, 0.5);
            z-index: -1;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Heading */
        h2 {
            margin: 50px 0 25px;
            font-size: 32px;
            font-weight: 700;
            text-align: center;
            color: #1a1a1a;
            position: relative;
            animation: fadeIn 1.2s ease;
        }
        h2::after {
            content: "";
            display: block;
            width: 80px;
            height: 4px;
            margin: 12px auto 0;
            background: linear-gradient(90deg, #3498db, #6a11cb);
            border-radius: 2px;
            animation: slideUnderline 1.2s ease forwards;
        }

        @keyframes slideUnderline {
            from { width: 0; opacity: 0; }
            to { width: 80px; opacity: 1; }
        }

        /* 📄 Viewer Card */
        .viewer {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(25px);
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: var(--shadow);
            width: 88%;
            max-width: 1050px;
            margin-bottom: 35px;
            border: 1px solid rgba(255,255,255,0.4);
            animation: floatUp 1s ease;
            transition: transform 0.4s ease, box-shadow 0.4s ease;
        }
        .viewer:hover {
            transform: translateY(-6px);
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.3);
        }

        iframe {
            width: 100%;
            height: 680px;
            border: none;
            border-radius: 12px;
            background: #fafafa;
            box-shadow: inset 0 0 12px rgba(0,0,0,0.08);
        }

        /* Buttons */
        .actions {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 18px;
            animation: fadeIn 1.3s ease;
        }

        .btn {
            display: inline-block;
            padding: 13px 28px;
            border-radius: var(--radius);
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.35s ease;
            box-shadow: 0 8px 22px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: "";
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: rgba(255,255,255,0.2);
            transform: skewX(-25deg);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 120%;
        }

        .btn:hover {
            transform: translateY(-3px) scale(1.03);
            background: linear-gradient(135deg, var(--primary-dark), #154360);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.35);
        }

        .btn:active {
            transform: translateY(1px);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes floatUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            iframe { height: 420px; }
            h2 { font-size: 24px; }
            .btn { padding: 10px 20px; font-size: 14px; }
        }
    </style>
</head>
<body>

    <h2>📄 Resume of ${username}</h2>

    <div class="viewer">
        <iframe src="/uploads/${resumePath}" frameborder="0"></iframe>
    </div>

    <div class="actions">
        <a class="btn" href="/uploads/${resumePath}" target="_blank">🔍 Open Fullscreen</a>
        <a class="btn" href="/uploads/${resumePath}" download="Resume-${username}.pdf">⬇ Download Resume</a>
        <a class="btn" href="/welcome">⬅ Back to Dashboard</a>
    </div>

</body>
</html>
