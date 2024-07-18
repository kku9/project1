<?php
// 데이터베이스 연결 설정
$servername = "localhost";
$username = "root";
$password = "your_password"; // 자신의 MySQL 비밀번호
$dbname = "myhomegym"; // 자신의 데이터베이스 이름

// 연결 생성
$conn = new mysqli($servername, $username, $password, $dbname);

// 연결 확인
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 폼에서 전송된 데이터 받기
$user_username = $_POST['username'];
$user_password = $_POST['password'];

// 비밀번호 해시 처리
$hashed_password = password_hash($user_password, PASSWORD_DEFAULT);

// 데이터베이스에 사용자 정보 삽입
$sql = "INSERT INTO users (username, password) VALUES (?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $user_username, $hashed_password);

if ($stmt->execute()) {
    echo "<script>alert('회원가입 성공! 이제 로그인해 주세요.'); window.location.href = 'login.html';</script>";
} else {
    echo "<script>alert('회원가입 실패: 아이디가 이미 존재합니다.'); window.location.href = 'signup.html';</script>";
}

// 연결 종료
$stmt->close();
$conn->close();
?>