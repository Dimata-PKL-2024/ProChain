import 'dart:io';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lat_prochain/routes/app_routes.dart';
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
                label: 'Nama Item*',
                tooltipText:
                    'Nama item adalah nama produk atau jasa yang akan Anda tambahkan.',
              ),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: controller.skuController,
                label: 'SKU*',
                icon: Icons.qr_code_scanner,
                tooltipText:
                    'SKU adalah kode unik untuk mengidentifikasi item.',
              ),

              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: controller.unitController,
                label: 'Unit*',
                icon: Icons.add,
                tooltipText:
                    'Unit adalah satuan barang, seperti pcs, kg, atau liter.',
              ),

              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: controller.categoryController,
                label: 'Kategori*',
                icon: Icons.add,
                tooltipText:
                    'Pilih kategori yang sesuai untuk item ini, seperti Elektronik atau Makanan.',
              ),

              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.descriptionController,
                label: 'Keterangan',
                isTextArea: true,
                tooltipText:
                    'Tambahkan deskripsi detail mengenai item ini, seperti kondisi, warna, atau ukuran.',
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
                  Row(
                    children: [
                      const Text('Boleh Diretur'),
                      IconButton(
                        icon: const Icon(Icons.info_outline,
                            size: 18, color: Colors.grey),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Boleh Diretur'),
                              content: const Text(
                                  'Centang ini jika item boleh dikembalikan oleh pembeli.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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
                            label: 'Harga Beli*',
                            tooltipText: 'Masukkan harga beli untuk item ini.',
                            isNumeric: true, // Hanya angka
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: controller.stockController,
                            label: 'Stock',
                            tooltipText: 'Jumlah stok barang yang tersedia.',
                            isNumeric:
                                true, // Pastikan hanya angka yang bisa dimasukkan
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: controller.currencyController,
                            label: 'Mata Uang',
                            tooltipText:
                                'Mata uang yang digunakan untuk transaksi pembelian.',
                          ),
               const SizedBox(height: 16),
GestureDetector(
  onTap: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Supplier',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.supplierController,
                  onChanged: (value) {
                    controller.searchSuppliers(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari Supplier',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredSuppliers.length,
                      itemBuilder: (context, index) {
                        final supplier =
                            controller.filteredSuppliers[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(supplier),
                          onTap: () {
                            controller.selectedSupplier.value =
                                supplier;
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Text(
            'Supplier',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              size: 18,
              color: Colors.grey,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Supplier'),
                  content: const Text(
                      'Pilih Supplier untuk item ini. Supplier digunakan untuk mencatat sumber barang.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  controller.selectedSupplier.value ?? 'Pilih Supplier',
                  style: const TextStyle(color: Colors.black54),
                )),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    ],
  ),
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
      onPressed: () {
        controller.clearForm(); // Reset form
        Get.offNamed(AppRoutes.ITEMS); // Kembali ke halaman Items
      },
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
                  _buildChoiceChip(
                      'Barang', controller.selectedType.value == 'Barang'),
                  const SizedBox(width: 8),
                  _buildChoiceChip(
                      'Jasa', controller.selectedType.value == 'Jasa'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: _showImageBottomSheet,
        child: _image == null
            ? DottedBorder(
                color: Colors.grey,
                strokeWidth: 1.5,
                dashPattern: [5, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Gambar',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
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
    String? tooltipText,
    bool isNumeric = false, // Tambahkan parameter untuk angka
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tampilkan label secara manual
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (tooltipText != null)
              IconButton(
                icon: const Icon(Icons.info_outline,
                    size: 18, color: Colors.grey),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(label),
                      content: Text(tooltipText),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: isTextArea ? 4 : 1,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumeric
              ? [
                  FilteringTextInputFormatter.digitsOnly
                ] // Hanya angka yang diperbolehkan
              : [],
          decoration: InputDecoration(
            hintText: 'Masukkan $label', // Placeholder dalam field
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
        ),
      ],
    );
  }

Widget _buildTextFieldWithIcon({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  String? tooltipText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (tooltipText != null)
            IconButton(
              icon: const Icon(Icons.info_outline, size: 18, color: Colors.grey),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(label),
                    content: Text(tooltipText),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      const SizedBox(height: 4),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Masukkan $label',
          suffixIcon: icon == Icons.qr_code_scanner
              ? IconButton(
                  icon: Icon(icon),
                  onPressed: () async {
                    // Fungsi pemindaian hanya untuk ikon qr_code_scanner
                    var result = await BarcodeScanner.scan();
                    if (result.rawContent.isNotEmpty) {
                      controller.text = result.rawContent; // Masukkan hasil ke controller
                    }
                  },
                )
              : Icon(icon), // Ikon lain tidak melakukan apa-apa
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
      ),
    ],
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
