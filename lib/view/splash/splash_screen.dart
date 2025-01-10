import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lat_prochain/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay 3 detik, lalu arahkan ke halaman utama
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.LOGIN);  // Arahkan ke halaman utama (CATEGORY)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Atur warna latar belakang sesuai keinginan
      body: Center(
        child: Image.asset(
          'assets/prochain.jpg',  // Gambar splash screen
          width: 250,  
          height: 250 
        ),
      ),
    );
  }
}
