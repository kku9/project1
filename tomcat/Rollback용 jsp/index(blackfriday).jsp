<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>My Home GYM</title>
    <meta charset="utf-8" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet" />
    <link href="style.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000000; /* 배경색을 검정으로 변경 */
            color: #ffffff; /* 텍스트 색상을 흰색으로 변경 */
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .navbar .logo {
            font-size: 25px;
            font-weight: bold;
        }
        .products {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }
        .product-item {
            background-color: #fff;
            border: 1px solid #ddd;
            margin: 10px;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            color: #333;
            width: 200px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            flex: 1 0 30%; /* 3개씩 나열하기 위한 설정 */
            box-sizing: border-box;
        }
        .product-item:hover {
            transform: scale(1.05);
        }
        .product-item img {
            max-width: 100%;
            height: auto;
        }
        .price {
            font-weight: bold;
            color: #4CAF50;
        }
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }
        .footer {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: #fff;
        }
        .footer a {
            margin: 0 10px;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a class="logo" href="#">
            <img src="logo.png" height="40px" alt="Logo">
        </a>
        <ul>
            <li><a href="#">Contact</a></li>
            <li><a href="#">Shop</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="signup.jsp">Sign Up</a></li>
        </ul>
    </div>

    <img class="hero_header" src="main.png" alt="Hero Image">
    <h1>Black Friday!</h1>

    <%
        // 데이터베이스 연결 변수
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Map<String, Double> prices = new HashMap<>();
        DecimalFormat df = new DecimalFormat("#"); // 소수점 없는 정수 형식

        // 사용자 입력 값 받기

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://10.100.0.200:3306/user_management";
            String dbUser = "user_management"; // 데이터베이스 사용자 이름
            String dbPassword = "password"; // 데이터베이스 비밀번호
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // SQL 쿼리
            String sql = "SELECT price FROM products3 WHERE name = ?";
            pstmt = conn.prepareStatement(sql);
            String[] productNames = {"pro1", "pro2", "tum", "run", "heaven", "dumb", "form", "pull", "push"};

            for (String productName : productNames) {
                pstmt.setString(1, productName);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    prices.put(productName, rs.getDouble("price"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <div class="products">
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item1.jpg" alt="Whey Protein">
            <p>Whey Protein</p>
            <p class="price"><%= df.format(prices.get("pro1")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item2.jpg" alt="Exten Pro Whey Protein">
            <p>Exten Pro Whey Protein</p>
            <p class="price"><%= df.format(prices.get("pro2")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item3.jpg" alt="Monsterzym Shaker">
            <p>Monsterzym Shaker</p>
            <p class="price"><%= df.format(prices.get("tum")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item4.jpg" alt="Running Machine">
            <p>Running Machine</p>
            <p class="price"><%= df.format(prices.get("run")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item5.jpg" alt="Stairway To Heaven">
            <p>Stairway To Heaven</p>
            <p class="price"><%= df.format(prices.get("heaven")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item6.jpg" alt="Dumbbell">
            <p>Dumbbell</p>
            <p class="price"><%= df.format(prices.get("dumb")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item7.jpg" alt="Form roller">
            <p>Form roller</p>
            <p class="price"><%= df.format(prices.get("form")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item8.jpg" alt="Pull up Bar">
            <p>Pull up Bar</p>
            <p class="price"><%= df.format(prices.get("pull")) %>원</p>
        </div>
        <div class="product-item">
            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
            <img src="item9.jpg" alt="Push up Bar">
            <p>Push up Bar</p>
            <p class="price"><%= df.format(prices.get("push")) %>원</p>
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="footer">
        <a href="#"><img src="sns1.png" alt="SNS Icon"></a>
        <a href="#"><img src="sns2.png" alt="SNS Icon"></a>
    </div>
</body>
</html>
