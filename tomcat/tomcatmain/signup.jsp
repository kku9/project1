<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Home Gym Sign Up</title>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Montserrat', sans-serif;
      background-color: #f0f0f0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background-image: url('<%= request.getContextPath() %>/signup.jpg');
      background-size: cover;
      background-position: center;
      opacity: 0.9;
    }
    .banner {
      text-align: center;
      position: absolute;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
      background-color: rgba(255, 255, 255, 0.7);
      padding: 10px 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      font-size: 24px;
      color: #333;
      z-index: 1;
      font-weight: 600;
    }
    .register-box {
      background-color: rgba(255, 255, 255, 0.9);
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      width: 500px;
      height: 400px;
      text-align: center;
      position: relative;
      z-index: 2;
      animation: fadeIn 1s ease-in-out;
    }
    .register-box h2 {
      color: #333;
      font-weight: 600;
      margin-bottom: 20px;
    }
    .register-box input[type="text"],
    .register-box input[type="password"],
    .register-box button {
      width: 100%;
      padding: 15px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
      font-size: 16px;
    }
    .register-box input[type="text"]:focus,
    .register-box input[type="password"]:focus {
      border-color: #4CAF50;
      outline: none;
    }
    .register-box button {
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
      margin-top: 20px;
      font-size: 18px;
      font-weight: 600;
      transition: background-color 0.3s ease;
    }
    .register-box button:hover {
      background-color: #45a049;
    }
    .register-box a {
      color: #666;
      text-decoration: none;
      display: block;
      margin-top: 20px;
    }
    .register-box a:hover {
      text-decoration: underline;
    }
    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: scale(0.9);
      }
      to {
        opacity: 1;
        transform: scale(1);
      }
    }
  </style>
</head>
<body>
  <div class="banner">
    My Home Gym
  </div>
  <div class="register-box">
    <h2>회원가입</h2>
    <form id="register-form" action="<%= request.getContextPath() %>/signup.jsp" method="post" onsubmit="return validateForm()">
      <input type="text" id="register-username" name="username" placeholder="아이디" required>
      <input type="password" id="register-password" name="password" placeholder="비밀번호" required>
      <input type="password" id="confirm-password" placeholder="비밀번호 확인" required>
      <button type="submit">가입하기</button>
    </form>
    <p><a href="<%= request.getContextPath() %>/login.jsp">로그인하기</a></p>
  </div>
  <script>
    function validateForm() {
      var password = document.getElementById('register-password').value;
      var confirmPassword = document.getElementById('confirm-password').value;

      if (password.length < 4) {
        alert('비밀번호는 최소 4자리 이상이어야 합니다.');
        return false;
      }
      
      if (password !== confirmPassword) {
        alert('비밀번호가 일치하지 않습니다. 다시 확인해 주세요.');
        return false;
      }

      return true; // 모든 검사가 통과되면 true를 반환하여 폼을 제출합니다.
    }
  </script>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 데이터베이스 연결 변수
        Connection conn = null;
        PreparedStatement pstmt = null;

        // 사용자 입력 값 받기
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://10.100.0.200:3306/user_management";
            String dbUser = "user_management"; // 데이터베이스 사용자 이름
            String dbPassword = "password"; // 데이터베이스 비밀번호
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // SQL 쿼리
            String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            int result = pstmt.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('회원가입 성공! 이제 로그인해 주세요.'); location.href='login.jsp';</script>");
            } else {
                out.println("<script>alert('회원가입 실패: 아이디가 이미 존재합니다.'); location.href='signup.jsp';</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('SQL 오류 발생: " + e.getMessage() + "'); history.back();</script>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<script>alert('JDBC 드라이버 오류 발생: " + e.getMessage() + "'); history.back();</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
        } finally {
            // 리소스 해제
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
</body>
</html>

