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
      body: Obx(() {
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
            _buildCategoryList(controller.categories, 'Kategori'),
            // untuk sub kategori, tambahkan di sini
          ],
        );
      }),
floatingActionButton: Obx(() {
  if (controller.categories.isNotEmpty) {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(AppRoutes.ADD_CATEGORY);
      },
      backgroundColor: const Color(0xFF5F3DC4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100), // Membuatnya bulat sempurna
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
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
