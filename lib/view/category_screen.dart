import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';
import '../routes/app_routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil instance controller dari Binding
    final controller = Get.find<CategoryController>();

    return Scaffold(
      appBar: _buildAppBar(controller),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          _buildSearchAndFilter(controller), // Tambahkan pencarian dan filter
          Expanded(
            child: Obx(() {
              if (controller.categories.isEmpty) {
                return TabBarView(
                  controller: controller.tabController,
                  children: [
                    EmptyCategoryWidget(categoryName: 'Kategori'),
                    EmptyCategoryWidget(categoryName: 'Sub kategori'),
                  ],
                );
              }
              return TabBarView(
                controller: controller.tabController,
                children: [
                  _buildCategoryList(controller.filteredCategories, 'Kategori'),
                  // untuk sub kategori, tamba'hkan di sini
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
                  BorderRadius.circular(100), // Membuatnya bulat sempurna
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
        color: Colors.white, // Mengubah warna burger button menjadi putih
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

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF5F3DC4),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Kategori'),
            onTap: () {
              Get.offNamed(AppRoutes.CATEGORY); // Navigasi ke halaman kategori
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () {
              // Tambahkan navigasi ke halaman pengaturan jika ada
            },
          ),
        ],
      ),
    );
  }



 Widget _buildSearchAndFilter(CategoryController controller) {
  return Obx(() {
    if (controller.categories.isEmpty && controller.hiddenCategories.isEmpty) {
      return const SizedBox.shrink(); // Tidak tampil jika tidak ada kategori atau tersembunyi
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Search Box
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
                    controller.searchCategories(
                        value); // Filter kategori berdasarkan pencarian
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Filter Icon
            GestureDetector(
              onTap: () {
                // Buka dialog atau bottom sheet untuk filter
                showModalBottomSheet(
                  context: Get.context!,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Filter Kategori',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            leading: const Icon(Icons.tune),
                            title: const Text('Tipe 1'),
                            onTap: () {
                              controller.filterCategories('Type 1');
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.tune),
                            title: const Text('Tipe 2'),
                            onTap: () {
                              controller.filterCategories('Type 2');
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.tune),
                            title: const Text('Tipe 3'),
                            onTap: () {
                              controller.filterCategories('Type 3');
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.tune, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      if (controller.hiddenCategories.isNotEmpty) // Cek jika ada kategori tersembunyi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              // Aksi saat "Disembunyikan" diklik
              Get.toNamed(AppRoutes.HIDE_VIEW); // Ganti dengan aksi yang sesuai
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0, horizontal: 16.0), // Menurunkan sedikit jarak vertikal
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(1.0), // Membuat sudut membulat
                border: Border(
                  top: BorderSide(
                      color: Colors.grey.shade400, width: 1.0), // Garis atas
                  bottom: BorderSide(
                      color: Colors.grey.shade400, width: 1.0), // Garis bawah
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.visibility_off, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Disembunyikan',
                      style: const TextStyle(
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.visibility_off,
                              size: 60,
                              color: const Color(0xFF5F3DC4),
                            ),
                            const SizedBox(height: 16),
                            Text(
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
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

  const EmptyCategoryWidget({required this.categoryName});

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
                // Navigasi menggunakan rute
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