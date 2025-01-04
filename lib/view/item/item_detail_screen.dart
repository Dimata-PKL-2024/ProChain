import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  ItemDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Batal',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] ?? 'Nama Item Tidak Ada',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Harga Beli\nRp ${item['purchasePrice'] ?? '0'} per box',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Harga Jual\nRp ${item['sellPrice'] ?? '0'} per box',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                        : const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Ringkasan Stock
              _buildSectionHeader('Ringkasan Stock', Icons.bar_chart_outlined),
              const SizedBox(height: 8),
              _buildStockRow('Safety Stocks', '${item['safetyStock'] ?? '0'}'),
              _buildStockRow('Min. Stocks', '${item['minStock'] ?? '0'}'),
              _buildStockRow('Real Stocks', '${item['realStock'] ?? '0'}'),
              const Divider(height: 32),

              // Informasi Item
              _buildInformationSection(),
            ],
          ),
        ),
      ),
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
      const SizedBox(height: 12), // Jarak antara header dan tabel
      Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(), // Kolom kiri
          2: IntrinsicColumnWidth(), // Kolom kanan
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildTableRowWithColumn('SKU', item['sku'] ?? 'Tidak Ada SKU', 'Kategori', item['category'] ?? 'Tidak Ada Kategori'),
          _buildTableRowWithColumn('Barcode', item['barcode'] ?? 'Tidak Ada Barcode', 'HPP', 'Rp ${item['hpp'] ?? '0'}'),
          _buildTableRowWithColumn('Unit', item['unit'] ?? 'Tidak Ada Unit', 'Mata Uang', item['currency'] ?? 'IDR (Rupiah)'),
          _buildTableRowWithColumn('Merk', item['brand'] ?? 'Tidak Ada Merk', 'Margin', '${item['margin'] ?? '0'} (${item['marginPercent'] ?? '0'}%)'),
          _buildTableRowWithColumn('Supplier', item['supplier'] ?? 'Tidak Ada Supplier', '', ''),
        ],
      ),
    ],
  );
}

TableRow _buildTableRowWithColumn(String leftLabel, String leftValue, String rightLabel, String rightValue) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0), // Jarak lebih kecil
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftLabel,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              leftValue,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(width: 5), // Jarak horizontal antar kolom
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0), // Jarak lebih kecil
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rightLabel,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              rightValue,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  );
}


  void _showOptionsBottomSheet(Map<String, dynamic> item) {
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
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit'),
              onTap: () => Get.offNamed('/edit-item'),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Hapus'),
              onTap: () => Get.offNamed('/items'),
            ),
          ],
        ),
      ),
    );
  }
}
