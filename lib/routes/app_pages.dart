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
import 'app_routes.dart';
import '../view/splash/splash_screen.dart';  // Import SplashScreen

class AppPages {
  static const initial = AppRoutes.SPLASH;  // Set initial route to SplashScreen

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,  // Add route for SplashScreen
      page: () => SplashScreen(),
    ),
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
      page: () => const ItemsScreen(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_ITEM,
      page: () => AddItemScreen(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_ITEM,
      page: () => ItemDetailScreen(item: {}),
      binding: ItemBinding(),
    ),
    GetPage(
      name: AppRoutes.EDIT_ITEM,
      page: () => EditItemScreen(),
      binding: ItemBinding(),
    ),
    // Add other routes as needed...
  ];
}
