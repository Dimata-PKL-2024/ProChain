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
          title: const Text('Daftar Item',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent, // Transparan karena sudah dibungkus Container
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white), // Warna ikon burger putih
          elevation: 0,
actions: [
  IconButton(
    icon: const Icon(Icons.description), // Ganti dengan ikon dokumen
    onPressed: () {
      // Fungsi untuk tombol file (misalnya membuka file)
      print('Ikon file diklik');
    },
  ),
],

        ),
      ),
    ),
    drawer: const CustomDrawer(), // Pindahkan drawer ke tingkat Scaffold
    body: Column(
      children: [
        _buildSearchAndFilter(controller), // Panggil widget buildSearchAndFilter di sini
        Expanded(
          child: Obx(() {
            if (controller.filteredItems.isEmpty) {
              return const EmptyItemWidget();
            }
            return _buildItemList(controller.filteredItems);
          }),
        ),
      ],
    ),
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

  Widget _buildSearchAndFilter(ItemController controller) {
    return Obx(() {
      if (controller.items.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        hintText: 'Cari item...',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: InputBorder.none,
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: (value) {
                        controller.searchItems(value);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: Get.context!,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 242, 243, 243),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Filter Kategori',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Nomor Dokumen",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 600,
                                      height: 40,
                                      child: TextField(
                                        controller:
                                            controller.documentNumberController,
                                        decoration: const InputDecoration(
                                          labelText: 'Nomor Dokumen',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Lokasi",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 600,
                                      height: 40,
                                      child: TextField(
                                        controller:
                                            controller.locationController,
                                        decoration: const InputDecoration(
                                          labelText: 'Lokasi',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Kategori",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 600,
                                      height: 40,
                                      child: TextField(
                                        controller:
                                            controller.categoryController,
                                        decoration: const InputDecoration(
                                          labelText: 'Kategori',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tanggal",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 200,
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  controller.dateController,
                                              decoration: const InputDecoration(
                                                labelText: 'Tanggal',
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Icon(Icons.date_range),
                                                ),
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 12.0),
                                              ),
                                              readOnly: true,
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (pickedDate != null) {
                                                  controller
                                                          .dateController.text =
                                                      "${pickedDate.toLocal()}"
                                                          .split(' ')[0];
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Semua",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        Checkbox(
                                          value: controller.isChecked,
                                          onChanged: (bool? value) {
                                            controller.isChecked =
                                                value ?? false;
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                // Status Filter
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Status",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Draft'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 247, 245, 245),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Draft';
                                          },
                                          child: const Text('Draft'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Final'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 250, 249, 249),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Final';
                                          },
                                          child: const Text('Final'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Closed'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 248, 247, 247),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Closed';
                                          },
                                          child: const Text('Closed'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Posted'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 250, 249, 249),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Posted';
                                          },
                                          child: const Text('Posted'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Sorting Filter
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Urut Berdasarkan",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Nomor'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 247, 245, 245),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Nomor';
                                          },
                                          child: const Text('Nomor'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Tanggal'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 250, 249, 249),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Tanggal';
                                          },
                                          child: const Text('Tanggal'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                        .statusController
                                                        .text ==
                                                    'Lokasi'
                                                ? Colors.purple
                                                : const Color.fromARGB(
                                                    255, 248, 247, 247),
                                          ),
                                          onPressed: () {
                                            controller.statusController.text =
                                                'Lokasi';
                                          },
                                          child: const Text('Lokasi'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.filter_list, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

Widget _buildItemList(List<Map<String, dynamic>> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Slidable(
        key: Key(item.toString()), // Tetap gunakan key unik
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) async {
                final confirmDelete = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.delete,
                              size: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Hapus Item?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Apakah Anda yakin ingin menghapus item ${item['name'] ?? 'Tidak Bernama'}?',
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text('Batal', style: TextStyle(color: Colors.black)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text('Hapus', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                if (confirmDelete == true) {
                  Get.find<ItemController>().deleteItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item "${item['name']}" dihapus')),
                  );
                }
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
