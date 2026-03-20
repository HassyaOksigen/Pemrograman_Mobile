import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'dashboard/main_navigation.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white, // background: #FFFFFF
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 63.97, left: 23.99, right: 23.99),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOGO SECTION (motion.div / div)
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E7D32), // background: #2E7D32
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.eco, color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(height: 47.98),

              // HEADER TEXT
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                  height: 1.2, // line-height: 36px / 30px
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Login to continue",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4A5565),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // LOGIN CARD (div with box-shadow)
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
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // EMAIL FIELD
                    const Text("Email", 
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF364153))),
                    const SizedBox(height: 8),
                    _buildInput(
                      controller: emailController,
                      hint: "your@email.com",
                      icon: Icons.mail_outline,
                    ),
                    const SizedBox(height: 16),

                    // PASSWORD FIELD
                    const Text("Password", 
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF364153))),
                    const SizedBox(height: 8),
                    _buildInput(
                      controller: passController,
                      hint: "Enter your password",
                      icon: Icons.lock_outline,
                      isObscure: true,
                    ),
                    const SizedBox(height: 24),

                    // LOGIN BUTTON (motion.button)
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
                          if (emailController.text.isEmpty || passController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Harap isi semua kolom")));
                            return;
                          }
                          final res = await auth.login(emailController.text, passController.text);
                          if (res['success']) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
                          }
                        },
                        child: auth.isLoading 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // REGISTER LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF4A5565), fontSize: 16)),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Color(0xFF2E7D32), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk Input agar tidak menulis kode berulang
  Widget _buildInput({required TextEditingController controller, required String hint, required IconData icon, bool isObscure = false}) {
    return Container(
      height: 50.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.09),
      ),
      child: TextField(
        controller: controller,
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
}