import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/vendor_provider.dart';

class VendorDashboard extends StatefulWidget {
  final String vendorId; // Didapat saat login berhasil
  
  const VendorDashboard({super.key, required this.vendorId});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  final Color primaryGreen = const Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    // Mengambil data dari database saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorProvider>(context, listen: false).fetchVendorProducts(widget.vendorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendorData = Provider.of<VendorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background clean
      appBar: AppBar(
        title: const Text('Vendor Dashboard', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long, color: Colors.black87),
            onPressed: () {
              // Navigasi ke halaman Melihat Pesanan Masuk
            },
          ),
        ],
      ),
      body: vendorData.isLoading
          ? Center(child: CircularProgressIndicator(color: primaryGreen))
          : vendorData.products.isEmpty
              ? _buildEmptyState()
              : _buildProductList(vendorData),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        onPressed: () {
          // Navigasi ke halaman Menambahkan produk/jasa
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Tambah Produk", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.storefront_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('Belum ada produk/jasa', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildProductList(VendorProvider vendorData) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80), // Ruang untuk FAB
      itemCount: vendorData.products.length,
      itemBuilder: (ctx, i) {
        final product = vendorData.products[i];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Gambar Produk
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: product['image_url'] != null
                      ? DecorationImage(image: NetworkImage(product['image_url']), fit: BoxFit.cover)
                      : null,
                ),
                child: product['image_url'] == null ? Icon(Icons.image, color: Colors.grey[400]) : null,
              ),
              const SizedBox(width: 16),
              // Detail Produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['nama_produk'] ?? 'Nama Produk',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${product['harga']}',
                      style: TextStyle(color: primaryGreen, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stok: ${product['stok']}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Tombol Edit & Delete
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                    onPressed: () {
                      // Navigasi ke halaman Edit Produk
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _confirmDelete(context, vendorData, product['id_produk'].toString()),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // Dialog Konfirmasi Hapus Produk
  void _confirmDelete(BuildContext context, VendorProvider vendorData, String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: const Text('Tindakan ini tidak dapat dibatalkan dan akan terhapus dari database.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              bool success = await vendorData.deleteProduct(productId);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produk dihapus!')));
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}