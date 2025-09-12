<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Contact Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dff9fb, #e0f7fa, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        /* Subtle floating animation for background */
        body::before {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(0,122,204,0.2) 0%, transparent 70%);
            top: -100px;
            left: -100px;
            animation: float 10s infinite alternate ease-in-out;
            z-index: 0;
        }

        body::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(46,125,50,0.15) 0%, transparent 70%);
            bottom: -80px;
            right: -120px;
            animation: float 12s infinite alternate-reverse ease-in-out;
            z-index: 0;
        }

        .box {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(12px);
            padding: 50px 60px;
            border-radius: 20px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 480px;
            animation: fadeIn 0.9s ease-in-out;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .box:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .box h2 {
            font-size: 32px;
            color: #2e7d32;
            margin-bottom: 12px;
            letter-spacing: 1px;
            font-weight: 700;
        }

        .box p {
            font-size: 17px;
            color: #444;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .box a {
            text-decoration: none;
            background: linear-gradient(135deg, #007acc, #00b4d8);
            color: #fff;
            padding: 14px 36px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.35s ease;
            box-shadow: 0 4px 15px rgba(0, 122, 204, 0.35);
            display: inline-block;
        }

        .box a:hover {
            background: linear-gradient(135deg, #005fa3, #0096c7);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 122, 204, 0.5);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(25px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes float {
            from { transform: translateY(0px) translateX(0px); }
            to { transform: translateY(40px) translateX(40px); }
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>✅ Thank You!</h2>
        <p>Your message has been sent successfully.</p>
        <a href="/welcome">⬅ Back to Dashboard</a>
    </div>
</body>
</html>
