import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class VendorProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  bool _isLoading = false;
  List<dynamic> _products = []; // Menyimpan data produk dari database

  bool get isLoading => _isLoading;
  List<dynamic> get products => _products;

  // Sesuaikan baseUrl dengan IP server XAMPP kamu
  final String baseUrl = "http://192.168.1.8/GreenLink/api/vendor"; 

  // Mengambil daftar produk milik vendor ini dari database
  Future<void> fetchVendorProducts(String vendorId) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await _dio.get("$baseUrl/get_products.php?vendor_id=$vendorId");
      if (response.data['status'] == 'success') {
        _products = response.data['data'];
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logika untuk menghapus produk dari database
  Future<bool> deleteProduct(String productId) async {
    try {
      var response = await _dio.post(
        "$baseUrl/delete_product.php",
        data: FormData.fromMap({"id_produk": productId}),
      );
      if (response.data['status'] == 'success') {
        _products.removeWhere((prod) => prod['id_produk'] == productId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}