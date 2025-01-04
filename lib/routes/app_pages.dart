import 'package:get/get.dart';
import 'package:lat_prochain/view/item/add_item_screen.dart';
import 'package:lat_prochain/view/item/edit_item_screen.dart';
import 'package:lat_prochain/view/item/item_detail_screen.dart';
import 'package:lat_prochain/view/kategori/hide_view.dart';
import '../bindings/category_binding.dart';
import '../bindings/item_binding.dart';
import '../view/kategori/category_screen.dart';
import '../view/kategori/add_category_screen.dart';
import '../view/kategori/edit_category_screen.dart';
import '../view/item/items_screen.dart';
//import '../view/unit_screen.dart'; // Pastikan file view ini ada
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.CATEGORY;

  static final routes = [
    GetPage(
      name: AppRoutes.CATEGORY,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_CATEGORY,
      page: () => AddCategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.HIDE_VIEW,
      page: () => const HideView(),
    ),
    GetPage(
      name: AppRoutes.EDIT_CATEGORY,
      page: () => EditCategoryScreen(),
    ),
    GetPage(
      name: AppRoutes.ITEMS,
      page: () => const ItemsScreen(), // Halaman untuk "Items"
      binding: ItemBinding(),
    ),
     GetPage(
      name: AppRoutes.ADD_ITEM,
      page: () => AddItemScreen(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_ITEM,
      page: () => ItemDetailScreen(item: {},),
      binding: ItemBinding(),
    ),
    GetPage(
      name: AppRoutes.EDIT_ITEM,
      page: () => EditItemScreen(),
      binding: ItemBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.UNIT,
    //   page: () => const UnitScreen(), // Halaman untuk "Satuan / Unit"
    // ),
  ];
}