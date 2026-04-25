<?php
header("Content-Type: application/json");
include '../config/database.php';

$data = json_decode(file_get_contents("php://input"), true);

$email    = $data['email'] ?? null;
$password = $data['password'] ?? null;

if (!$email || !$password) {
    echo json_encode([
        "status" => "error",
        "message" => "Email dan password wajib diisi"
    ]);
    exit;
}

$query = "SELECT p.*, r.nama_peran 
          FROM pengguna p 
          JOIN peran r ON p.id_peran = r.id 
          WHERE p.email = ? AND p.is_active = 1";

$stmt = mysqli_prepare($conn, $query);
mysqli_stmt_bind_param($stmt, "s", $email);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

if ($user = mysqli_fetch_assoc($result)) {
    if (password_verify($password, $user['password'])) {
        unset($user['password']);
        
        echo json_encode([
            "status" => "success",
            "message" => "Selamat datang, " . $user['nama'],
            "data" => $user
        ]);
    } else {
        echo json_encode(["status" => "error", "message" => "Password salah"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Akun tidak ditemukan atau tidak aktif"]);
}
?>