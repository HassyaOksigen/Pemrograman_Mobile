import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user (Nama) dari AuthProvider
    final auth = Provider.of<AuthProvider>(context);
    final userName = auth.user?.nama ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // background: #F9FAFB
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION (Container background: #2E7D32)
            Stack(
              children: [
                Container(
                  height: 195.91,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E7D32),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
                Positioned(
                  top: 47.98,
                  left: 23.99,
                  right: 23.99,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, $userName!", // Hello, !
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Find your eco-friendly products",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      // Shopping Cart Button
                      Container(
                        width: 47.97,
                        height: 47.97,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // SEARCH BAR
                Positioned(
                  top: 123.95,
                  left: 23.99,
                  right: 23.99,
                  child: Container(
                    height: 47.97,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF99A1AF)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // CATEGORIES (Horizontal Scroll)
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 23.99),
              child: Row(
                children: [
                  _buildCategory("All", isActive: true),
                  _buildCategory("Recycling"),
                  _buildCategory("Cleaning"),
                  _buildCategory("Energy"),
                  _buildCategory("Products"),
                ],
              ),
            ),

            // FEATURED PRODUCTS SECTION
            const Padding(
              padding: EdgeInsets.fromLTRB(23.99, 24, 23.99, 16),
              child: Text(
                "Featured Products",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
            ),

            // PRODUCT GRID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.99),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.60, // Menyesuaikan tinggi 294px
                children: [
                  _buildProductCard("Eco-Friendly Water Bottle", "Green Store", "Rp 125.000"),
                  _buildProductCard("Solar Panel Kit", "Solar Solutions", "Rp 2.500.000"),
                  _buildProductCard("Reusable Shopping Bag", "Green Store", "Rp 45.000"),
                  _buildProductCard("Composting Service", "Eco Clean", "Rp 300.000"),
                ],
              ),
            ),
            const SizedBox(height: 100), // Memberi ruang untuk BottomNav
          ],
        ),
      ),
    );
  }

  // WIDGET HELPER: CATEGORY BUTTON
  Widget _buildCategory(String title, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2E7D32) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isActive ? null : Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : const Color(0xFF4A5565),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // WIDGET HELPER: PRODUCT CARD
  Widget _buildProductCard(String title, String shop, String price) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE PLACEHOLDER
          Container(
            height: 140,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Center(child: Icon(Icons.image, color: Colors.grey, size: 40)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF101828)),
                ),
                const SizedBox(height: 4),
                Text(shop, style: const TextStyle(fontSize: 12, color: Color(0xFF6A7282))),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF2E7D32)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}