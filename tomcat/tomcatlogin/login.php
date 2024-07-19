<?php
session_start();

// 데이터베이스 연결
$servername = "localhost";
$username = "root"; // 자신의 MySQL 사용자 이름
$password = "your_password"; // 자신의 MySQL 비밀번호
$dbname = "myhomegym"; // 자신의 데이터베이스 이름

$conn = new mysqli($servername, $username, $password, $dbname);

// 연결 확인
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 폼에서 전송된 데이터 받기
$user_username = $_POST['username'];
$user_password = $_POST['password'];

// 데이터베이스에서 사용자 정보 확인
$sql = "SELECT * FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $user_username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    // 비밀번호 검증
    if (password_verify($user_password, $row['password'])) {
        $_SESSION['username'] = $user_username;
        echo "<script>alert('로그인 성공!'); window.location.href = 'index.html';</script>";
    } else {
        echo "<script>alert('비밀번호가 일치하지 않습니다.'); window.location.href = 'login.html';</script>";
    }
} else {
    echo "<script>alert('사용자를 찾을 수 없습니다.'); window.location.href = 'login.html';</script>";
}

// 연결 종료
$stmt->close();
$conn->close();
?>