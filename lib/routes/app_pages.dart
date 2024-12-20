import 'package:get/get.dart';
import 'package:lat_prochain/view/hide_view.dart';
import '../bindings/category_binding.dart';
import '../view/category_screen.dart';
import '../view/add_category_screen.dart';
import '../view/edit_category_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.CATEGORY;

  static final routes = [
    GetPage(
      name: AppRoutes.CATEGORY,
      page: () => CategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_CATEGORY,
      page: () => AddCategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.HIDE_VIEW,
      page: () => HideView(),
),
    GetPage(
      name: AppRoutes.EDIT_CATEGORY,
      page: () => EditCategoryScreen(),
),
  ];
}
