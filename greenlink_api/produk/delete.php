<?php
header("Content-Type: application/json");
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

if(!isset($data['id'])){
    echo json_encode("ID produk tidak ditemukan");
    exit;
}

$id = $data['id'];

$query = "DELETE FROM produk WHERE id='$id'";

$result = mysqli_query($conn,$query);

if($result){
    echo json_encode("Produk berhasil dihapus");
}else{
    echo json_encode("Gagal menghapus produk");
}
?>