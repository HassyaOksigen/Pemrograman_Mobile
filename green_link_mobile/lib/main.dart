import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import provider-provider yang kamu miliki
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/transaction_provider.dart';
// Import view utama
import 'views/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        
        ChangeNotifierProvider(create: (_) => CartProvider()),
        
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: const GreenLinkApp(),
    ),
  );
}

class GreenLinkApp extends StatelessWidget {
  const GreenLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Link',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // Tips: Menggunakan useMaterial3 agar tampilan lebih modern seperti desainmu
        useMaterial3: true, 
      ),
      home: const SplashScreen(),
    );
  }
}