import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';

class AddCategoryScreen extends StatelessWidget {
  
  final CategoryController controller = Get.put(CategoryController());

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
              const Center(
                child: Text(
                  'Silahkan menambahkan Kategori',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7A7A7A),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      controller: controller.codeController,
                      label: 'Kode*',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: controller.nameController,
                      label: 'Nama Kategori',
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled:
                              true, 
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pilih Parent Kategori',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextField(
                                      controller: controller.searchController,
                                      onChanged: (value) {
                                        controller.searchLocations(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Cari Lokasi',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Obx(
                                      () => ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5, // Maks tinggi 50% layar
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .filteredLocations.length,
                                          itemBuilder: (context, index) {
                                            final location = controller
                                                .filteredLocations[index];
                                            return ListTile(
                                              leading: const Icon(Icons.location_on),
                                              title: Text(location),
                                              onTap: () {
                                                controller
                                                    .selectedParentCategory
                                                    .value = location;
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
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                  controller.selectedParentCategory.value ??
                                      'Pilih Parent Kategori',
                                  style: const TextStyle(color: Colors.black54),
                                )),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Tipe",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => _buildChoiceChips(controller: controller)),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: controller.taxTypeController,
                      label: 'Jenis Pajak',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: controller.descriptionController,
                      label: 'Keterangan',
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: controller.toggleMoreFields,
                      child: Obx(() => _MoreRow(
                            isExpanded: controller.showMoreFields.value,
                          )),
                    ),
                    Obx(() {
                      if (controller.showMoreFields.value) {
                        return Column(
                          children: [
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: controller.pointPriceController,
                              label: 'Harga Poin',
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: controller.priceIncreaseController,
                              label: 'Kenaikan Harga',
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildSaveButton(),
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
        'Tambah Kategori',
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 15,
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Batal',
          style: TextStyle(
            color: Color(0xFF6200EE),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      actions: [
        Obx(() => IconButton(
              icon: Icon(
                controller.isHidden.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                controller.toggleVisibility();
                if (controller.isHidden.value) {
                  showDialog(
                    context: Get.context!,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      contentPadding: const EdgeInsets.all(24),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Mode Hide',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E2E2E),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Kategori ini telah disembunyikan!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2E2E2E),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5F3DC4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Selesai',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: Get.context!,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      contentPadding: const EdgeInsets.all(24),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Mode Normal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E2E2E),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Kategori ini telah kembali ke mode normal!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2E2E2E),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5F3DC4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Selesai',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFFBDBDBD),
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget _buildChoiceChips({required CategoryController controller}) {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('Inventory Items'),
            selected: controller.selectedType.value == 'Inventory Items',
            selectedColor: const Color(0xFF6200EE),
            labelStyle: TextStyle(
              color: controller.selectedType.value == 'Inventory Items'
                  ? Colors.white
                  : Colors.black,
            ),
            onSelected: (_) => controller.updateSelectedType('Inventory Items'),
            checkmarkColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ChoiceChip(
            label: const Text('Sales Items'),
            selected: controller.selectedType.value == 'Sales Items',
            selectedColor: const Color(0xFF6200EE),
            labelStyle: TextStyle(
              color: controller.selectedType.value == 'Sales Items'
                  ? Colors.white
                  : Colors.black,
            ),
            onSelected: (_) => controller.updateSelectedType('Sales Items'),
            checkmarkColor: Colors.white,
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
          controller.saveCategory();
          if (controller.isHidden.value) {
            Get.toNamed('/hide-view');
          } else {
            Get.toNamed('/category');
          }
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

class _MoreRow extends StatelessWidget {
  final bool isExpanded;

  const _MoreRow({required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isExpanded ? 'More' : 'More',
          style: const TextStyle(
            color: Color(0xFF6200EE),
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: const Color(0xFF6200EE),
        ),
      ],
    );
  }
}
