import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/category_controller.dart';

class SearchAndFilterWidget extends StatelessWidget {
  final CategoryController controller;

  const SearchAndFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categories.isEmpty && controller.hiddenCategories.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(children: [
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
                      hintText: 'Cari kategori...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                    onChanged: (value) {
                      controller.searchCategories(value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 242, 243, 243),
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
                                  TextField(
                                    controller: controller.documentNumberController,
                                    decoration: const InputDecoration(
                                      labelText: 'Nomor Dokumen',
                                      border: OutlineInputBorder(),
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
                                  TextField(
                                    controller: controller.locationController,
                                    decoration: const InputDecoration(
                                      labelText: 'Lokasi',
                                      border: OutlineInputBorder(),
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
                                  TextField(
                                    controller: controller.categoryController,
                                    decoration: const InputDecoration(
                                      labelText: 'Kategori',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        TextField(
                                          controller: controller.dateController,
                                          decoration: const InputDecoration(
                                            labelText: 'Tanggal',
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(Icons.date_range),
                                            ),
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                          ),
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (pickedDate != null) {
                                              controller.dateController.text =
                                                  "${pickedDate.toLocal()}".split(' ')[0];
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
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
      ]);
    });
  }
}
