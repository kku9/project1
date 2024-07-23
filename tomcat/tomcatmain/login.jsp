<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Home Gym Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background-image: url('<%= request.getContextPath() %>/login.png');
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
    .login-box {
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
    .login-box h2 {
      color: #333;
    }
    .login-box input[type="text"],
    .login-box input[type="password"],
    .login-box button {
      width: 100%;
      padding: 15px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
      font-size: 16px;
    }
    .login-box button {
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
      margin-top: 20px;
    }
    .login-box button:hover {
      background-color: #45a049;
    }
    .login-box a {
      color: #666;
      text-decoration: none;
    }
    .login-box a:hover {
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
  <div class="login-box">
    <h2>로그인</h2>
    <form id="login-form" action="<%= request.getContextPath() %>/login.jsp" method="post">
      <input type="text" id="login-username" placeholder="아이디" name="username" required>
      <input type="password" id="login-password" placeholder="비밀번호" name="password" required>
      <button type="submit">로그인</button>
    </form>
    <p><a href="<%= request.getContextPath() %>/signup">회원가입</a></p>
  </div>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    // 데이터베이스 연결 변수
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

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
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            out.println("<script>alert('로그인 성공!'); location.href='index';</script>");
        } else {
            out.println("<script>alert('아이디 또는 비밀번호가 올바르지 않습니다. 다시 시도해주세요.'); location.href='login';</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('SQL 오류 발생: " + e.getMessage() + "'); location.href='login';</script>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<script>alert('JDBC 드라이버 오류 발생: " + e.getMessage() + "'); location.href='login';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); location.href='login';</script>");
    } finally {
        // 리소스 해제
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}
%>
</body>
</html>

