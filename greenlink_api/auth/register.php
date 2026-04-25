<?php
echo json_encode(["test" => "MASUK REGISTER"]);
exit;

header("Content-Type: application/json");
include '../config/database.php';

// 🔥 TAMPILKAN ERROR (DEBUG MODE)
ini_set('display_errors', 1);
error_reporting(E_ALL);

// ================= AMBIL DATA (AMAN) =================
$nama     = $_POST['nama'] ?? '';
$email    = $_POST['email'] ?? '';
$passwordRaw = $_POST['password'] ?? '';
$no_hp    = $_POST['no_hp'] ?? '';
$id_peran = $_POST['id_peran'] ?? '';

// ================= VALIDASI WAJIB =================
if ($nama == '' || $email == '' || $passwordRaw == '' || $no_hp == '' || $id_peran == '') {
    echo json_encode([
        "status" => "error",
        "message" => "Semua field wajib diisi"
    ]);
    exit;
}

// ================= VALIDASI EMAIL =================
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode([
        "status" => "error",
        "message" => "Format email tidak valid"
    ]);
    exit;
}

// ================= VALIDASI NO HP =================
if (!preg_match('/^[0-9]{10,}$/', $no_hp)) {
    echo json_encode([
        "status" => "error",
        "message" => "Nomor HP minimal 10 digit"
    ]);
    exit;
}

// ================= HASH PASSWORD =================
$password = password_hash($passwordRaw, PASSWORD_DEFAULT);

// ================= FIX TIPE DATA =================
$id_peran = (int)$id_peran;
$is_active = 1;

// ================= CEK EMAIL =================
$checkEmail = mysqli_prepare($conn, "SELECT id FROM pengguna WHERE email = ?");
if (!$checkEmail) {
    echo json_encode([
        "status" => "error",
        "message" => "Prepare checkEmail gagal: " . mysqli_error($conn)
    ]);
    exit;
}

mysqli_stmt_bind_param($checkEmail, "s", $email);
mysqli_stmt_execute($checkEmail);
$result = mysqli_stmt_get_result($checkEmail);

if (mysqli_num_rows($result) > 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Email sudah digunakan"
    ]);
    exit;
}

// ================= INSERT DATA =================
$query = "INSERT INTO pengguna 
          (nama, email, password, no_hp, id_peran, is_active, created_at, updated_at) 
          VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";

$stmt = mysqli_prepare($conn, $query);

if (!$stmt) {
    echo json_encode([
        "status" => "error",
        "message" => "Prepare INSERT gagal: " . mysqli_error($conn)
    ]);
    exit;
}

mysqli_stmt_bind_param($stmt, "ssssii", $nama, $email, $password, $no_hp, $id_peran, $is_active);

if (mysqli_stmt_execute($stmt)) {
    echo json_encode([
        "status" => "success",
        "message" => "Registrasi berhasil"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Gagal insert: " . mysqli_error($conn)
    ]);
}

exit;
?>