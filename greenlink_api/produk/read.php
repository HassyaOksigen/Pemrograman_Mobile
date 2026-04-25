<?php
header("Content-Type: application/json");
include "../config/database.php";

$query = "SELECT 
produk.id,
produk.nama_produk,
produk.deskripsi_produk,
produk.harga,
produk.stok,
kategori.nama_kategori,
pengguna.nama as vendor
FROM produk
JOIN kategori ON produk.id_kategori = kategori.id
JOIN pengguna ON produk.id_vendor = pengguna.id";

$result = mysqli_query($conn,$query);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);
?>