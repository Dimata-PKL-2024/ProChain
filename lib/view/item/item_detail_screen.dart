import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lat_prochain/controller/item_controller.dart';

class ItemDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  ItemDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Batal',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () => _showOptionsBottomSheet(item),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Atas: Nama Item, Harga, dan Gambar
              _buildBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] ?? 'Nama Item Tidak Ada',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              text: 'Harga Beli\n',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Rp ${item['purchasePrice'] ?? '0'}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ' per ${item['unit'] ?? 'unit'}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text.rich(
                            TextSpan(
                              text: 'Harga Jual\n',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Rp ${item['sellPrice'] ?? '0'}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ' per ${item['unit'] ?? 'unit'}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: item['image'] != null && item['image'].isNotEmpty
                          ? Image.file(
                              File(item['image']),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image_not_supported,
                              size: 80, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Ringkasan Stock
              _buildBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                        'Ringkasan Stock', Icons.bar_chart_outlined),
                    const SizedBox(height: 8),
                    _buildStockRow(
                        'Safety Stocks', '${item['safetyStock'] ?? '0'}'),
                    _buildStockRow('Min. Stocks', '${item['minStock'] ?? '0'}'),
                    _buildStockRow(
                        'Real Stocks', '${item['realStock'] ?? '0'}'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Informasi Item
              _buildBox(
                child: _buildInformationSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStockRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Informasi Item', Icons.info_outline),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowWithSpacing('SKU', item['sku'] ?? 'Tidak Ada SKU',
                'Kategori', item['category'] ?? 'Tidak Ada Kategori'),
            _buildRowWithSpacing('Barcode', item['sku'] ?? 'Tidak Ada Barcode',
                'HPP', 'Rp ${item['hpp'] ?? '0'}'),
            _buildRowWithSpacing('Unit', item['unit'] ?? 'Tidak Ada Unit',
                'Mata Uang', item['currency'] ?? 'IDR (Rupiah)'),
            _buildRowWithSpacing(
                'Merk',
                item['brand'] ?? 'Tidak Ada Merk',
                'Margin',
                '${item['margin'] ?? '0'} (${item['marginPercent'] ?? '0'}%)'),
            _buildRowWithSpacing(
                'Supplier', item['supplier'] ?? 'Tidak Ada Supplier', '', ''),
          ],
        ),
      ],
    );
  }

  Widget _buildRowWithSpacing(String leftLabel, String leftValue,
      String rightLabel, String rightValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftLabel,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  leftValue,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rightLabel,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  rightValue,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Menampilkan bottom sheet dengan dua opsi: Edit dan Hapus
  void _showOptionsBottomSheet(Map<String, dynamic> item) {
    final itemController = Get.find<ItemController>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Aksi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF6200EE)),
              title: const Text('Edit'),
              onTap: () {
                Get.back();
                Get.offNamed('/edit-item');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Color(0xFF6200EE)),
              title: const Text('Hapus'),
              onTap: () {
                itemController.deleteItem(
                    item); // Gunakan itemController untuk menghapus item
                Get.back(); // Menutup bottom sheet setelah memilih opsi
                Get.offNamed('/items'); // Navigasi ke layar menu item screen
              },
            ),
          ],
        ),
      ),
    );
  }
}