<?php
header("Content-Type: application/json");
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

if(!isset($data['id'])){
    echo json_encode("ID produk tidak ditemukan");
    exit;
}

$id = $data['id'];
$nama_produk = $data['nama_produk'];
$deskripsi_produk = $data['deskripsi_produk'];
$harga = $data['harga'];
$stok = $data['stok'];

$query = "UPDATE produk SET
nama_produk='$nama_produk',
deskripsi_produk='$deskripsi_produk',
harga='$harga',
stok='$stok'
WHERE id='$id'";

$result = mysqli_query($conn,$query);

if($result){
    echo json_encode("Produk berhasil diupdate");
}else{
    echo json_encode("Gagal update produk");
}
?>