import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lat_prochain/view/add_category_screen.dart';
import '../controller/category_controller.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Scaffold(
      appBar: _buildAppBar(controller, context),
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
           // _buildCategoryList(controller.subCategories, 'Sub kategori'),
          ],
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(CategoryController controller, BuildContext context) {
    return AppBar(
      title: const Text(
        'Daftar Kategori',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      backgroundColor: const Color(0xFF5F3DC4),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
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
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

Widget _buildCategoryList(List categories, String categoryName) {
  return Obx(() {
    if (categories.isEmpty) {
      return Center(
        child: Text('Belum ada $categoryName ditambahkan.'),
      );
    }
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category['name'] ?? 'Kategori Tidak Bernama'),
          subtitle: Text('Type: ${category['type'] ?? 'Tidak Ada Kode'}'),
          trailing: Text(category['code'] ?? ''),
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
                Get.to(() => AddCategoryScreen());
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
