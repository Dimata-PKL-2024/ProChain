import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Header Drawer
          Container(
            height: 110, // Sesuaikan tinggi header
            decoration: const BoxDecoration(
              color: Color(0xFF5F3DC4),
            ),
            child: const Center(
              child: Text(
                'PT. Dimata Sora Jayate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Expansion Tile Menu
          ExpansionTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Items'),
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.only(left: 53), // Geser submenu
            collapsedShape: const RoundedRectangleBorder(), // Hapus garis bawah saat tertutup
            shape: const RoundedRectangleBorder(), // Hapus garis bawah saat terbuka
            children: <Widget>[
              // Submenu Kategori
              ListTile(
                title: const Text('Kategori'),
                contentPadding: EdgeInsets.zero, // Hapus padding
                onTap: () {
                  Navigator.of(Get.context!).pop(); // Tutup drawer
                  Get.offNamed(AppRoutes.CATEGORY); // Navigasi ke halaman Kategori
                },
              ),
              // Submenu Items
              ListTile(
                title: const Text('Items'),
                contentPadding: EdgeInsets.zero, // Hapus padding
                onTap: () {
                  Navigator.of(Get.context!).pop(); // Tutup drawer
                  Get.offNamed(AppRoutes.ITEMS); // Navigasi ke halaman Items
                },
              ),
              // Submenu Satuan / Unit
              ListTile(
                title: const Text('Satuan / Unit'),
                contentPadding: EdgeInsets.zero, // Hapus padding
                onTap: () {
                  Navigator.of(Get.context!).pop(); // Tutup drawer
                  Get.offNamed(AppRoutes.UNIT); // Navigasi ke halaman Unit
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}