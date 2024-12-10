import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var categories = <Map<String, String>>[].obs;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taxTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pointPriceController = TextEditingController();
  final TextEditingController priceIncreaseController = TextEditingController();

  var selectedParentCategory = Rxn<String>();
  var selectedType = ''.obs;
  var showMoreFields = false.obs;
  var isHidden = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

    void toggleVisibility() {
    isHidden.value = !isHidden.value;
  }


  void addCategory() {
    categories.add({
      'code': codeController.text,
      'name': nameController.text,
      'taxType': taxTypeController.text,
      'description': descriptionController.text,
      'parentCategory': selectedParentCategory.value ?? '',
      'type': selectedType.value,
    });

    clearForm();
  }

  void clearForm() {
    codeController.clear();
    nameController.clear();
    taxTypeController.clear();
    descriptionController.clear();
    pointPriceController.clear();
    priceIncreaseController.clear();
    selectedParentCategory.value = null;
    selectedType.value = '';
    showMoreFields.value = false;
  }

  void toggleMoreFields() {
    showMoreFields.value = !showMoreFields.value;
  }

  void updateSelectedType(String type) {
    selectedType.value = type;
  }

  @override
  void onClose() {
    tabController.dispose();
    codeController.dispose();
    nameController.dispose();
    taxTypeController.dispose();
    descriptionController.dispose();
    pointPriceController.dispose();
    priceIncreaseController.dispose();
    super.onClose();
  }
}