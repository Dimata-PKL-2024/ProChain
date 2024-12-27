import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../controller/item_controller.dart';
import '../../routes/app_routes.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF5F3DC4),
        centerTitle: true,
      ),
      drawer: _buildDrawer(), // Pindahkan drawer ke tingkat Scaffold
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

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 110,
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
          ListTile(
            title: const Text('Kategori'),
            onTap: () => Get.offNamed(AppRoutes.CATEGORY),
          ),
          ListTile(
            title: const Text('Items'),
            onTap: () => Get.offNamed(AppRoutes.ITEMS),
          ),
          ListTile(
            title: const Text('Satuan / Unit'),
            onTap: () => Get.offNamed(AppRoutes.UNIT),
          ),
        ],
      ),
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
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: item['image'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(item['image']), // Gunakan path untuk gambar
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.image_not_supported, size: 50),
            title: Text(
              item['name'] ?? 'Item Tidak Bernama',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SKU: ${item['sku'] ?? 'Tidak Ada SKU'}'),
                Text('Unit: ${item['unit'] ?? 'Tidak Ada Unit'}'),
                Text('Stock: ${item['stock']?.toString() ?? '0'}'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.toNamed(AppRoutes.EDIT_ITEM, arguments: item);
            },
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
