<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Page</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body, html { height: 100%; font-family: "Segoe UI", sans-serif; }

        /* Main container */
        .container {
            display: flex;
            height: 100vh;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #fff;
        }

        /* Left panel */
        .left-panel {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            background: radial-gradient(circle at top left, #2563eb, #1e293b 70%);
            padding: 50px;
        }

        .left-panel img {
            max-width: 80%;
            height: auto;
            animation: float 4s ease-in-out infinite;
        }

        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0); }
        }

        /* Right panel */
        .right-panel {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .register-container {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.07);
            padding: 45px 35px;
            border-radius: 18px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.65);
            backdrop-filter: blur(14px);
            animation: slideUp 0.8s ease-out;
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            color: #fff;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .register-container label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            color: #cbd5e1;
        }

        .register-container input[type="text"],
        .register-container input[type="email"],
        .register-container input[type="password"],
        .register-container input[type="file"] {
            width: 100%;
            padding: 12px 14px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
            font-size: 15px;
            transition: all 0.3s;
        }

        .register-container input:focus {
            border: 1px solid #3b82f6;
            box-shadow: 0 0 10px #3b82f6;
            outline: none;
        }

        .register-container input[type="submit"] {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #3b82f6, #06b6d4);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            margin-top: 10px;
        }

        .register-container input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(59,130,246,0.6);
        }

        /* Animation */
        @keyframes slideUp {
            from { transform: translateY(60px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Left panel with graphic -->
    <div class="left-panel">
        <img src="https://workergenix.com/wp-content/uploads/2024/03/03-03-24_LongPostGraphic.webp" alt="AI Assistant Graphic">
    </div>

    <!-- Right panel with form -->
    <div class="right-panel">
        <div class="register-container">
            <h2>Create Your Account</h2>
            <form action="register" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Upload Profile Photo</label>
                    <input type="file" name="profilePhoto" required>
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" required>
                </div>

                <div class="form-group">
                    <label>Upload Resume</label>
                    <input type="file" name="resume" required>
                </div>

                <input type="submit" value="Register">
            </form>
        </div>
    </div>
</div>

</body>
</html>
