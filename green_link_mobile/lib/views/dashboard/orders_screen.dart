import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // background: #F9FAFB
      body: Stack(
        children: [
          // HEADER HIJAU (Container background: #2E7D32)
          Container(
            height: 123.95,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2E7D32),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.only(top: 47.98, left: 23.99),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Orders", // h1
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Track your order history", // p
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // EMPTY STATE CONTENT
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60), // Penyesuaian agar tidak tertutup header
                // ICON PACKAGE (Vector)
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64, // width/height: 64px
                  color: const Color(0xFFD1D5DC), // border color dari CSS
                ),
                const SizedBox(height: 15.99), // gap: 15.99px
                const Text(
                  "No orders yet", // p
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6A7282), // color: #6A7282
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}