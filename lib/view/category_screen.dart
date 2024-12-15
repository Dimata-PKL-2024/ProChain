import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';
import '../routes/app_routes.dart';

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
  Widget _buildCategoryList(List categories, String categoryName) {
    return Obx(() {
      if (categories.isEmpty) {
        return Center(
          child: Text(
            'Belum ada $categoryName ditambahkan.',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF5F3DC4),
                child: const Icon(Icons.category, color: Colors.white),
              ),
              title: Text(
                category['name'] ?? 'Kategori Tidak Bernama',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Type: ${category['type'] ?? 'Tidak Ada Kode'}'),
              trailing: Text(category['code'] ?? ''),
            ),
          );
        },
      );
    });
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