import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'dashboard/main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  void _checkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;

    // Delay 3 detik sesuai estetika splash screen
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (isLogin) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const MainNavigation()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Sesuai CSS: background: linear-gradient(180deg, #2E7D32 0%, #1B5E20 100%)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF1B5E20),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Lingkaran Putih (motion.div / div)
            Positioned(
              top: 341, // Sesuai CSS top: 341px
              child: Container(
                width: 95.99,
                height: 95.99,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  // Ikon Daun (Leaf / Vector)
                  child: Icon(
                    Icons.eco, 
                    size: 47.98, // Sesuai CSS width/height: 47.98px
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ),
            ),

            // Teks GreenLink (motion.h1)
            Positioned(
              top: 460.98, // Sesuai CSS top: 460.98px
              child: const Text(
                "GreenLink",
                style: TextStyle(
                  fontFamily: 'Inter', // Pastikan sudah tambah font Inter di pubspec.yaml
                  fontSize: 36,
                  fontWeight: FontWeight.w700, // Bold
                  color: Colors.white,
                  letterSpacing: -0.18,
                ),
              ),
            ),

            // Slogan (motion.p)
            Positioned(
              top: 508.96, // Sesuai CSS top: 508.96px
              child: Text(
                "Connect for a Greener Future",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.9), // Sesuai CSS rgba(255, 255, 255, 0.9)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}