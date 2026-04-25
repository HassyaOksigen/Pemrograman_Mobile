import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  final String baseUrl = "http://192.168.68.197/greenlink_api/auth"; 

  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      var formData = FormData.fromMap({"email": email, "password": password});
      var response = await _dio.post("$baseUrl/login.php", data: formData);

      if (response.data['status'] == 'success') {
        _user = UserModel.fromJson(response.data['data']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_nama', _user!.nama);
        await prefs.setBool('isLogin', true);
        
        _isLoading = false;
        notifyListeners();
        return {"success": true, "message": response.data['message']};
      } else {
        _isLoading = false;
        notifyListeners();
        return {"success": false, "message": response.data['message']};
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {"success": false, "message": "Kesalahan Jaringan"};
    }
  }

  Future<Map<String, dynamic>> register(String nama, String email, String password, String noHp) async {
    _isLoading = true;
    notifyListeners();
    try {
      var formData = FormData.fromMap({
        "nama": nama,
        "email": email,
        "password": password,
        "no_hp": noHp
      });
      var response = await _dio.post("$baseUrl/register.php", data: formData);
      _isLoading = false;
      notifyListeners();
      return {"success": response.data['status'] == 'success', "message": response.data['message']};
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {"success": false, "message": "Gagal terhubung ke server"};
    }
  }

  // Tambahkan ini di dalam class AuthProvider
Future<void> logout() async {
  _isLoading = true;
  notifyListeners();

  try {
    final prefs = await SharedPreferences.getInstance();
    
    // Menghapus semua data session yang tersimpan
    await prefs.remove('isLogin');
    await prefs.remove('user_data'); // Jika kamu menyimpan data user dalam bentuk String
    
    _user = null; // Kosongkan variabel user di memory
    
    // Opsional: Beri sedikit delay agar transisi loading terlihat halus
    await Future.delayed(const Duration(milliseconds: 500));
    
  } catch (e) {
    debugPrint("Error saat logout: $e");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}
