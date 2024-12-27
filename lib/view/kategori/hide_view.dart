// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../controller/category_controller.dart';

class HideView extends StatelessWidget {
  const HideView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(
            '/category'); 
        return false; 
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            color: Colors.white,
          ),
        ),
        body: Obx(() {
          if (controller.hiddenCategories.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.folder_outlined,
                    color: Colors.grey.shade400,
                    size: 60,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Oops! Kosong :(',
                    style: TextStyle(
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
            );
          }

          return ListView.builder(
            itemCount: controller.hiddenCategories.length,
            itemBuilder: (context, index) {
              final category = controller.hiddenCategories[index];

              return Slidable(
                key: Key(category['code'] ?? index.toString()),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.5,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        _showCustomDialog(
                          context,
                          icon: Icons.lock_open,
                          iconColor: const Color(0xFF5F3DC4),
                          title:
                              'Apakah anda ingin mengembalikan kategori tersebut?',
                          confirmButtonText: 'Lanjutkan',
                          confirmButtonColor: const Color(0xFF5F3DC4),
                          onConfirm: () {
                            controller.unhideCategory(category);
                          },
                        );
                      },
                      backgroundColor: const Color(0xFF5F3DC4),
                      foregroundColor: Colors.white,
                      icon: Icons.visibility,
                      label: 'Show',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _showCustomDialog(
                          context,
                          icon: Icons.delete_outline,
                          iconColor: Colors.red,
                          title:
                              'Apakah anda yakin ingin menghapus kategori ini?',
                          confirmButtonText: 'Hapus',
                          confirmButtonColor: Colors.red,
                          onConfirm: () {
                            controller.removeHiddenCategory(category);
                          },
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Text(
                      category['name'] ?? 'Kategori Tidak Bernama',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Type: ${category['type'] ?? ''}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: Text(
                      category['code'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
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

  void _showCustomDialog(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String confirmButtonText,
    required Color confirmButtonColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 60,
                color: iconColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: confirmButtonColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          color: confirmButtonColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirm();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        confirmButtonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
