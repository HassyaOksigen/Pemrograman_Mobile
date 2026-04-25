<?php

include '../config/database.php';

$query = "SELECT * FROM transaksi ORDER BY created_at DESC";

$result = mysqli_query($conn,$query);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode([
    "transaksi" => $data
]);