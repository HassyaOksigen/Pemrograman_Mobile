import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  
  // Default Role (Sesuai diskusi id_peran sebelumnya)
  int selectedRole = 2; // 2 = Customer, 3 = Vendor

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.99),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 31.99),
              // HEADER
              const Text(
                "Create Account",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join GreenLink today",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Color(0xFF4A5565),
                ),
              ),
              const SizedBox(height: 32),

              // REGISTER CARD (box-shadow: 0px 10px 15px -3px)
              Container(
                padding: const EdgeInsets.all(23.99),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                      spreadRadius: -3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Full Name"),
                    _buildInput(nameController, "Dwi-Hassya-Fahrezi", Icons.person_outline),
                    
                    const SizedBox(height: 16),
                    _buildLabel("Email"),
                    _buildInput(emailController, "your@email.com", Icons.mail_outline),

                    const SizedBox(height: 16),
                    _buildLabel("Phone Number"),
                    _buildInput(phoneController, "08123456789", Icons.phone_android_outlined),

                    const SizedBox(height: 16),
                    _buildLabel("Password"),
                    _buildInput(passController, "Enter password", Icons.lock_outline, isObscure: true),

                    const SizedBox(height: 16),
                    _buildLabel("Confirm Password"),
                    _buildInput(confirmPassController, "Confirm password", Icons.lock_reset_outlined, isObscure: true),

                    const SizedBox(height: 16),
                    _buildLabel("Role"),
                    _buildDropdown(),

                    const SizedBox(height: 32),
                    // REGISTER BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 47.97,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          String email = emailController.text.trim();
                          String pass = passController.text.trim();

                          // 1. Cek apakah kosong
                          if (email.isEmpty || pass.isEmpty) {
                            _showError("Email dan Password tidak boleh kosong");
                            return;
                          }

                          // 2. VALIDASI FORMAT EMAIL (Tambahkan ini!)
                          if (!_isValidEmail(email)) {
                            _showError("Format email salah! Gunakan @gmail.com atau lainnya.");
                            return; // Berhenti di sini, jangan lanjut kirim ke database
                          }
                          if (_validate()) {
                            final res = await auth.register(
                              nameController.text,
                              emailController.text,
                              passController.text,
                              phoneController.text,
                              // role: selectedRole, // Kirim role ke API jika sudah diupdate
                            );
                            if (res['success']) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Daftar!")));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
                            }
                          }
                        },
                        child: auth.isLoading 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Register", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              // LOGIN LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Color(0xFF4A5565), fontSize: 16)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color(0xFF2E7D32), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // VALIDASI PASSWORD MATCH
  bool _validate() {
    if (nameController.text.isEmpty || emailController.text.isEmpty || passController.text.isEmpty) {
      _showError("Semua kolom wajib diisi");
      return false;
    }
    if (passController.text != confirmPassController.text) {
      _showError("Password tidak cocok!");
      return false;
    }
    return true;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  // UI HELPERS
  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF364153))),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint, IconData icon, {bool isObscure = false}) {
    return Container(
      height: 50.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.09),
      ),
      child: TextField(
        controller: controller,
        keyboardType: hint.contains("@") ? TextInputType.emailAddress : TextInputType.text,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
          prefixIcon: Icon(icon, color: const Color(0xFF99A1AF), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 50.15,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.09),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedRole,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF99A1AF)),
          items: const [
            DropdownMenuItem(value: 2, child: Text("Customer")),
            DropdownMenuItem(value: 3, child: Text("Vendor")),
          ],
          onChanged: (val) => setState(() => selectedRole = val!),
        ),
      ),
    );
  }

    bool _isValidEmail(String email) {
    // Rumus RegExp untuk memastikan format: teks@teks.domain
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}