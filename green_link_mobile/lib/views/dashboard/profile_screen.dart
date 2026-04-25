import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../login_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user asli dari AuthProvider
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // background: #F9FAFB
      body: Stack(
        children: [
          // HEADER HIJAU (Container background: #2E7D32)
          Container(
            height: 159.96,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2E7D32),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.only(top: 47.98, left: 23.99),
            child: const Text(
              "Profile",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          // KONTEN UTAMA
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 111.98), // top: 111.98px dari CSS
                
                // KARTU PROFIL PUTIH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.99),
                  child: Container(
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
                      children: [
                        // INFO FOTO & NAMA
                        Row(
                          children: [
                            Container(
                              width: 79.99,
                              height: 79.99,
                              decoration: const BoxDecoration(
                                color: Color(0xFFA5D6A7), // background: #A5D6A7
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, color: Color(0xFF2E7D32), size: 40),
                            ),
                            const SizedBox(width: 15.99),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.nama ?? "John Doe",
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF101828),
                                    ),
                                  ),
                                  Text(
                                    user?.namaPeran ?? "Customer",
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: Color(0xFF6A7282),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.edit_outlined, color: Color(0xFF4A5565)),
                          ],
                        ),
                        const SizedBox(height: 23.99),
                        
                        // DETAIL EMAIL
                        _buildInfoRow(
                          icon: Icons.mail_outline,
                          label: "Email",
                          value: user?.email ?? "email@example.com",
                        ),
                        const Divider(color: Color(0xFFF3F4F6), thickness: 1.09),
                        
                        // DETAIL PHONE
                        _buildInfoRow(
                          icon: Icons.phone_android_outlined,
                          label: "Phone",
                          value: user?.noHp ?? "08123456789",
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 23.99),

                // TOMBOL MENU BAWAH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.99),
                  child: Column(
                    children: [
                      _buildMenuButton(
                        label: "Edit Profile",
                        icon: Icons.edit_note,
                        textColor: const Color(0xFF101828),
                        iconColor: const Color(0xFF99A1AF),
                        onTap: () {},
                      ),
                      const SizedBox(height: 11.99),
                      _buildMenuButton(
                        label: "Logout",
                        icon: Icons.logout,
                        textColor: const Color(0xFFFB2C36), // Logout color: #FB2C36
                        iconColor: const Color(0xFFFB2C36),
                        onTap: () async {
                          // Logika Logout
                          await auth.logout();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Ruang untuk BottomNav
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk baris informasi (Email/Phone)
  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF99A1AF), size: 20),
          const SizedBox(width: 11.99),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6A7282))),
              Text(value, style: const TextStyle(fontSize: 16, color: Color(0xFF101828))),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Tombol Menu (Edit Profile/Logout)
  Widget _buildMenuButton({
    required String label, 
    required IconData icon, 
    required Color textColor, 
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.99, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor)),
            Icon(icon, color: iconColor, size: 20),
          ],
        ),
      ),
    );
  }
}