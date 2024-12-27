// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lat_prochain/widgets/custom_drawer.dart';
import '../../controller/category_controller.dart';
import '../../routes/app_routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil instance controller dari Binding
    final controller = Get.find<CategoryController>();

    return Scaffold(
      appBar: _buildAppBar(controller),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          _buildSearchAndFilter(controller), 
          Expanded(
            child: Obx(() {
              if (controller.categories.isEmpty) {
                return TabBarView(
                  controller: controller.tabController,
                  children: const [
                    EmptyCategoryWidget(categoryName: 'Kategori'),
                    EmptyCategoryWidget(categoryName: 'Sub kategori'),
                  ],
                );
              }
              return TabBarView(
                controller: controller.tabController,
                children: [
                  _buildCategoryList(controller.filteredCategories, 'Kategori'),
                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        if (controller.categories.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.ADD_CATEGORY);
            },
            backgroundColor: const Color(0xFF5F3DC4),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(100),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(CategoryController controller) {
    return AppBar(
      title: const Text(
        'Daftar Kategori',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      backgroundColor: const Color(0xFF5F3DC4),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white, 
      ),
      bottom: TabBar(
        controller: controller.tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.6),
        indicatorColor: Colors.white,
        tabs: const [
          Tab(text: 'Kategori'),
          Tab(text: 'Sub kategori'),
        ],
      ),
    );
  }

 Widget _buildSearchAndFilter(CategoryController controller) {
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
                  context: Get.context!,
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
                                SizedBox(
                                  width: 600,
                                  height: 40,
                                  child: TextField(
                                    controller: controller.documentNumberController,
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
                                    controller: controller.locationController,
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
                                    controller: controller.categoryController,
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
                                      SizedBox(
                                        width: 200,
                                        height: 40,
                                        child: TextField(
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
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        controller.isChecked = value ?? false;
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Draft' ? Colors.purple : const Color.fromARGB(255, 247, 245, 245),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Draft';
                                      },
                                      child: const Text('Draft'),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Final' ? Colors.purple : const Color.fromARGB(255, 250, 249, 249),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Final';
                                      },
                                      child: const Text('Final'),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Closed' ? Colors.purple : const Color.fromARGB(255, 248, 247, 247),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Closed';
                                      },
                                      child: const Text('Closed'),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Posted' ? Colors.purple : const Color.fromARGB(255, 250, 249, 249),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Posted';
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Nomor' ? Colors.purple : const Color.fromARGB(255, 247, 245, 245),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Nomor';
                                      },
                                      child: const Text('Nomor'),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Tanggal' ? Colors.purple : const Color.fromARGB(255, 250, 249, 249),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Tanggal';
                                      },
                                      child: const Text('Tanggal'),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.statusController.text == 'Lokasi' ? Colors.purple : const Color.fromARGB(255, 248, 247, 247),
                                      ),
                                      onPressed: () {
                                        controller.statusController.text = 'Lokasi';
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
      const SizedBox(height: 8),
      if (controller.hiddenCategories.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.HIDE_VIEW);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0, horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
                border: Border(
                  top: BorderSide(color: Colors.grey.shade400, width: 1.0),
                  bottom: BorderSide(color: Colors.grey.shade400, width: 1.0),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.visibility_off, color: Colors.grey),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Disembunyikan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '(${controller.hiddenCategories.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 33, 30, 247),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ]);
  });
}



Widget _buildCategoryList(List<Map<String, String>> categories, String tabName) {
  return ListView.builder(
    itemCount: categories.length,
    itemBuilder: (context, index) {
      final category = categories[index];
      return Slidable(
        key: Key(category['id'] ?? index.toString()),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.5,
          children: [
            // Tombol Hide
            SlidableAction(
              onPressed: (context) async {
                final confirmHide = await showDialog(
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
                              Icons.visibility_off,
                              size: 60,
                              color: Color(0xFF5F3DC4),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Sembunyikan Kategori?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Apakah Anda yakin ingin menyembunyikan kategori ${category['name'] ?? 'Tidak Bernama'}?',
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
                                    backgroundColor: const Color(0xFF5F3DC4),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text('Sembunyikan', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                if (confirmHide == true) {
                  Get.find<CategoryController>().hideCategory(category);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Kategori "${category['name']}" disembunyikan')),
                  );
                }
              },
              backgroundColor: const Color(0xFF5F3DC4),
              foregroundColor: Colors.white,
              icon: Icons.visibility_off,
              label: 'Hide',
            ),
            // Tombol Delete
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
                              'Hapus Kategori?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Apakah Anda yakin ingin menghapus kategori ${category['name'] ?? 'Tidak Bernama'}?',
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
                  Get.find<CategoryController>().deleteCategory(category);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Kategori "${category['name']}" dihapus')),
                  );
                }
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
            onTap: () {
              Get.toNamed(AppRoutes.EDIT_CATEGORY, arguments: category);
            },
            title: Text(
              category['name'] ?? 'Kategori Tidak Bernama',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Type: ${category['type'] ?? 'Tidak Ada Kode'}'),
            trailing: Text(category['code'] ?? ''),
          ),
        ),
      );
    },
  );
}


}

class EmptyCategoryWidget extends StatelessWidget {
  final String categoryName;

  const EmptyCategoryWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_outlined,
              color: Colors.grey.shade400,
              size: 60,
            ),
            const SizedBox(height: 12),
            Text(
              'Oops! $categoryName Kosong :(',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Belum ada data $categoryName',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.ADD_CATEGORY);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5F3DC4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Tambah',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}