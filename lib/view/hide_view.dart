import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';

class HideView extends StatelessWidget {
  const HideView({super.key});

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
          title: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center, // Menjaga teks di tengah
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Daftar Disembunyikan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${controller.hiddenCategories.length} Kategori',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }),
          backgroundColor: const Color(0xFF5F3DC4),
          iconTheme: const IconThemeData(
            color: Colors.white, // Mengubah warna ikon menjadi putih
          ),
        ),
        body: Obx(() {
          // Jika tidak ada kategori yang disembunyikan
          if (controller.hiddenCategories.isEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      color: Colors.grey.shade400,
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Oops! Kosong :(',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Belum ada data kategori yang disembunyikan',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Jika ada kategori yang disembunyikan
          return ListView.builder(
            itemCount: controller.hiddenCategories.length,
            itemBuilder: (context, index) {
              final category = controller.hiddenCategories[index];

              return Dismissible(
                key: Key(category['code'] ?? index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text('Apa Anda yakin ingin menghapus kategori ini?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Hapus'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    controller.removeHiddenCategory(category);
                  }
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Text(
                      category['name'] ?? 'Kategori Tidak Bernama',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Kode: ${category['code'] ?? ''}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                      onPressed: () {
                        // Menampilkan dialog konfirmasi untuk unhide kategori
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text('Apakah Anda ingin menampilkan kategori ini?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Menutup dialog
                                },
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.unhideCategory(category); // Menampilkan kategori
                                  Navigator.of(context).pop(); // Menutup dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}