import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:lat_prochain/view/add_category_screen.dart';
import 'package:lat_prochain/view/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Daftar Kategori',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CategoryScreen(), 
    );
  }
}