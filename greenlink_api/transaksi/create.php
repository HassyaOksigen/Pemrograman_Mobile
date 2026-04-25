<?php

include '../config/database.php';

$data = json_decode(file_get_contents("php://input"), true);

if(!$data){
    echo json_encode("Data tidak lengkap");
    exit;
}

$id_pengguna = $data['id_pengguna'];
$metode_pembayaran = $data['metode_pembayaran'];
$items = $data['items'];

if(empty($items)){
    echo json_encode([
        "message" => "Item transaksi kosong"
    ]);
    exit;
}

$total_harga = 0;

foreach($items as $item){
    $total_harga += $item['jumlah'] * $item['harga'];
}

$status_pembayaran = "pending";
$status = "baru";
$created_at = date("Y-m-d H:i:s");

$query = "INSERT INTO transaksi
(id_pengguna,total_harga,metode_pembayaran,status_pembayaran,status,created_at)
VALUES
('$id_pengguna','$total_harga','$metode_pembayaran','$status_pembayaran','$status','$created_at')";

if(mysqli_query($conn,$query)){

    $id_transaksi = mysqli_insert_id($conn);

    foreach($items as $item){

        $id_produk = $item['id_produk'];
        $jumlah = $item['jumlah'];
        $harga = $item['harga'];

        $query_detail = "INSERT INTO detail_transaksi
        (id_transaksi,id_produk,jumlah,harga)
        VALUES
        ('$id_transaksi','$id_produk','$jumlah','$harga')";

        mysqli_query($conn,$query_detail);
    }

    echo json_encode(["Transaksi berhasil disimpan", "id_transaksi" => $id_transaksi]);

}else{

    echo json_encode("Transaksi gagal");
}