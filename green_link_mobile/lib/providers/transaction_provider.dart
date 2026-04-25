import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  // Variabel untuk menyimpan total harga sementara
  int _totalPrice = 0;

  int get totalPrice => _totalPrice;

  // Fungsi untuk mengupdate total harga dari keranjang
  void setTotalPrice(int amount) {
    _totalPrice = amount;
    notifyListeners(); // Memberitahu UI (CheckoutView) untuk update tampilan
  }

  // Fungsi simulasi jika transaksi berhasil
  void confirmTransaction() {
    // Di sini nanti kamu bisa tambahkan logika simpan ke database
    _totalPrice = 0;
    notifyListeners();
  }
}