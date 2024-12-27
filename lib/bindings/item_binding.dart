import 'package:get/get.dart';
import '../controller/item_controller.dart';

class ItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(() => ItemController());
  }
}
