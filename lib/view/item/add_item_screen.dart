import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/item_controller.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final ItemController controller = Get.find<ItemController>();
  File? _image; // Variabel untuk menyimpan gambar yang dipilih/diambil

  // Fungsi untuk memilih gambar dari kamera/galeri
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    Get.back(); // Tutup bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _sectionTitle('Informasi Item'),
              const SizedBox(height: 16),
              _buildItemTypeRow(),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.nameController,
                label: 'Nama Item',
              ),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: controller.skuController,
                label: 'SKU',
                icon: Icons.qr_code_scanner,
              ),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: controller.unitController,
                label: 'Unit',
                icon: Icons.add,
              ),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: controller.categoryController,
                label: 'Kategori',
                icon: Icons.add,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.descriptionController,
                label: 'Keterangan',
                isTextArea: true,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.allowReturn.value,
                      onChanged: (value) {
                        controller.allowReturn.value = value!;
                      },
                    ),
                  ),
                  const Text('Boleh Diretur'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _sectionTitle('Informasi Pembelian'),
                  Obx(
                    () => Switch(
                      value: controller.purchaseInfoEnabled.value,
                      onChanged: (value) {
                        controller.purchaseInfoEnabled.value = value;
                      },
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.purchaseInfoEnabled.value
                    ? Column(
                        children: [
                          _buildTextField(
                            controller: controller.purchasePriceController,
                            label: 'Harga Beli',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: controller.stockController,
                            label: 'Stock',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: controller.currencyController,
                            label: 'Mata Uang',
                          ),
                          const SizedBox(height: 16),
                          _buildTextFieldWithIcon(
                            controller: controller.supplierController,
                            label: 'Supplier',
                            icon: Icons.add,
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 32),
              _buildSaveButton(),
              const SizedBox(height: 16), // Tambahkan jarak dari bawah
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      title: const Text(
        'Tambah Item',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: TextButton(
        onPressed: () => Get.back(),
        child: const Text(
          'Batal',
          style: TextStyle(
            color: Color(0xFF6200EE),
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildItemTypeRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tipe Item',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    _buildChoiceChip('Barang', controller.selectedType.value == 'Barang'),
                    const SizedBox(width: 8),
                    _buildChoiceChip('Jasa', controller.selectedType.value == 'Jasa'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _showImageBottomSheet,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _image == null
                ? const Center(child: Icon(Icons.image, size: 35, color: Colors.grey))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  void _showImageBottomSheet() {
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
              'Gambar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.image, color: Color(0xFF6200EE)),
              title: const Text('Ambil Dari Perangkat'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF6200EE)),
              title: const Text('Ambil Foto'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (isSelected) {
        if (isSelected) {
          controller.selectedType.value = label;
        }
      },
      selectedColor: const Color(0xFF6200EE),
      backgroundColor: const Color(0xFFBDBDBD),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isTextArea = false,
  }) {
    return TextField(
      controller: controller,
      maxLines: isTextArea ? 4 : 1,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

Widget _buildSaveButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        controller.saveItem(_image?.path); // Kirim path gambar ke controller
        Get.toNamed('/items'); // Mengarahkan ke halaman item
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6200EE),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: const Text(
        'Simpan',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Inter',
          color: Colors.white,
        ),
      ),
    ),
  );
}

}
