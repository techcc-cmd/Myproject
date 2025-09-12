<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Messages</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            margin: 0;
            padding: 0;
            color: #333;
            min-height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 50px auto;
            position: relative;
            z-index: 1;
        }

        h2 {
            text-align: center;
            color: #1a237e;
            margin-bottom: 40px;
            font-size: 34px;
            letter-spacing: 1px;
            font-weight: 700;
            background: linear-gradient(90deg, #007acc, #00b4d8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: fadeInDown 1s ease-in-out;
        }

        .card {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            padding: 24px 28px;
            margin-bottom: 22px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            transition: all 0.35s ease;
            border-left: 6px solid transparent;
            background-image: linear-gradient(white, white), 
                              linear-gradient(135deg, #007acc, #00b4d8);
            background-origin: border-box;
            background-clip: padding-box, border-box;
            animation: fadeInUp 0.7s ease-in-out;
        }

        .card:hover {
            transform: translateY(-6px) scale(1.02);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .card p {
            margin: 10px 0;
            font-size: 16px;
            line-height: 1.6;
            color: #333;
        }

        .card b {
            color: #1a237e;
            font-weight: 600;
        }

        .card small {
            color: #555;
            font-size: 13px;
            display: block;
            margin-top: 10px;
            font-style: italic;
        }

        p.empty {
            text-align: center;
            color: #444;
            background: rgba(255, 255, 255, 0.85);
            padding: 22px;
            border-radius: 14px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
            font-size: 18px;
            backdrop-filter: blur(8px);
            animation: pulse 1.5s infinite ease-in-out;
        }

        /* Animations */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { transform: scale(1); box-shadow: 0 6px 18px rgba(0,0,0,0.08); }
            50% { transform: scale(1.02); box-shadow: 0 8px 24px rgba(0,0,0,0.12); }
            100% { transform: scale(1); box-shadow: 0 6px 18px rgba(0,0,0,0.08); }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📩 Messages Received</h2>

    <c:if test="${empty messages}">
        <p class="empty">No messages yet.</p>
    </c:if>

    <c:forEach var="m" items="${messages}">
        <div class="card">
            <p><b>Name:</b> ${m.name}</p>
            <p><b>Email:</b> ${m.email}</p>
            <p><b>Message:</b> ${m.content}</p>
            <p><small>Sent at: ${m.sentAt}</small></p>
        </div>
    </c:forEach>
</div>
</body>
</html>
