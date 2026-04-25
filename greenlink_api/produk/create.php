<?php
header("Content-Type: application/json");
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

if(
    !isset($data['nama_produk']) ||
    !isset($data['deskripsi_produk']) ||
    !isset($data['harga']) ||
    !isset($data['stok']) ||
    !isset($data['id_kategori']) ||
    !isset($data['id_vendor'])
){
    echo json_encode("Data tidak lengkap");
    exit;
}

$nama_produk = $data['nama_produk'];
$deskripsi_produk = $data['deskripsi_produk'];
$harga = $data['harga'];
$stok = $data['stok'];
$id_kategori = $data['id_kategori'];
$id_vendor = $data['id_vendor'];

$query = "INSERT INTO produk 
(nama_produk, deskripsi_produk, harga, stok, id_kategori, id_vendor)
VALUES 
('$nama_produk','$deskripsi_produk','$harga','$stok','$id_kategori','$id_vendor')";

$result = mysqli_query($conn,$query);

if($result){
    echo json_encode("Produk berhasil ditambahkan");
}else{
    echo json_encode("Gagal menambahkan produk");
}
?>