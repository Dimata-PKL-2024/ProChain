import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lat_prochain/widgets/custom_drawer.dart';
import '../../controller/item_controller.dart';
import '../../routes/app_routes.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();

return Scaffold(
  appBar: PreferredSize(
    preferredSize: const Size.fromHeight(80), // Tinggi AppBar lebih besar
    child: Container(
      padding: const EdgeInsets.only(top: 10), // Tambahkan jarak di atas header
      color: const Color(0xFF5F3DC4), // Warna latar belakang header
      child: AppBar(
        title: const Text('Daftar Item', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent, // Transparan karena sudah dibungkus Container
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon burger putih
        elevation: 0, 
      ),
    ),
  ),
      drawer: const CustomDrawer(), // Pindahkan drawer ke tingkat Scaffold
      body: Obx(() {
        if (controller.filteredItems.isEmpty) {
          return const EmptyItemWidget();
        }
        return _buildItemList(controller.filteredItems);
      }),
      floatingActionButton: Obx(() {
        if (controller.filteredItems.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () => Get.toNamed(AppRoutes.ADD_ITEM),
            backgroundColor: const Color(0xFF5F3DC4),
            child: const Icon(Icons.add, color: Colors.white),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

Widget _buildItemList(List<Map<String, dynamic>> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Slidable(
        key: Key(item['id']?.toString() ?? index.toString()),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                Get.find<ItemController>().deleteItem(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item "${item['name']}" dihapus')),
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Hapus',
            ),
          ],
        ),
        child: GestureDetector(
          // onTap: () {
          //   Get.to(() => ItemDetailScreen(item: item));
          // },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Gambar Item
                  item['image'] != null && item['image'].isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(item['image']),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                  const SizedBox(width: 16),

                  // Informasi Item
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] ?? 'Item Tidak Bernama',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'SKU : ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: item['sku'] ?? 'Tidak Ada SKU',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stock dan Unit
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item['stock']?.toString() ?? '0'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item['unit']?.toString() ?? 'Tidak Ada Unit'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

}

class EmptyItemWidget extends StatelessWidget {
  const EmptyItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.folder_outlined, color: Colors.grey.shade400, size: 60),
          const SizedBox(height: 12),
          const Text(
            'Oops! Item Kosong :(',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Belum ada data item',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.ADD_ITEM),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5F3DC4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Tambah',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
