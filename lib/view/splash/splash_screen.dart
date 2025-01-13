import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lat_prochain/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Setup animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),  // Durasi animasi
      vsync: this,
    )..forward();  // Mulai animasi saat splash screen dimuat

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Delay 3 detik, lalu arahkan ke halaman utama
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.LOGIN);  // Arahkan ke halaman utama (LOGIN)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Atur warna latar belakang sesuai keinginan
      body: Center(
        child: FadeTransition(
          opacity: _animation,  // Animasi fade-in
          child: Image.asset(
            'assets/prochain.jpg',  // Gambar splash screen
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
