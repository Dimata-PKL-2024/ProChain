import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';

class HideView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed('/category'); // Ganti '/category' dengan nama rute kategori
        return false; // Mencegah aksi back default
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Disembunyikan'),
          backgroundColor: const Color(0xFF5F3DC4),
        ),
        body: Obx(() {
          if (controller.hiddenCategories.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada kategori yang disembunyikan.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.hiddenCategories.length,
            itemBuilder: (context, index) {
              final category = controller.hiddenCategories[index];
              return ListTile(
                title: Text(category['name'] ?? 'Kategori Tidak Bernama'),
                subtitle: Text('Kode: ${category['code'] ?? ''}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.removeHiddenCategory(category);
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
