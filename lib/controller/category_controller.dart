import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var categories = <Map<String, String>>[].obs;
  var hiddenCategories = <Map<String, String>>[].obs;
  var filteredCategories = <Map<String, String>>[].obs; // Untuk menampilkan hasil pencarian dan filter

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taxTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pointPriceController = TextEditingController();
  final TextEditingController priceIncreaseController = TextEditingController();

  var selectedParentCategory = Rxn<String>();
  var selectedType = ''.obs;
  var selectedFilter = Rxn<String>(); // Pilihan filter
  var showMoreFields = false.obs;
  var isHidden = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // Awalnya, filteredCategories menampilkan semua kategori
    filteredCategories.assignAll(categories);

    // Pantau perubahan pada categories untuk sinkronisasi otomatis
    ever(categories, (_) {
      searchCategories(''); // Reset pencarian dan filter saat data berubah
    });
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

  void saveCategory() {
    final category = {
      'code': codeController.text,
      'name': nameController.text,
      'taxType': taxTypeController.text,
      'description': descriptionController.text,
      'parentCategory': selectedParentCategory.value ?? '',
      'type': selectedType.value,
    };

    if (isHidden.value) {
      hiddenCategories.add(category); // Simpan ke data hidden
    } else {
      categories.add(category); // Simpan ke data normal
    }
    clearForm();
  }

  // Logika untuk pencarian kategori berdasarkan nama
  void searchCategories(String query) {
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua kategori
      filteredCategories.assignAll(categories);
    } else {
      // Filter kategori berdasarkan nama (case-insensitive)
      final lowerCaseQuery = query.toLowerCase();
      filteredCategories.assignAll(
        categories.where((category) {
          final name = category['name']?.toLowerCase() ?? '';
          return name.contains(lowerCaseQuery);
        }),
      );
    }
  }

  // Logika untuk filter berdasarkan tipe
  void filterCategories(String type) {
    selectedFilter.value = type; // Simpan filter yang dipilih
    if (type.isEmpty) {
      // Jika tidak ada filter, tampilkan semua kategori
      filteredCategories.assignAll(categories);
    } else {
      // Filter kategori berdasarkan tipe
      filteredCategories.assignAll(
        categories.where((category) => category['type'] == type),
      );
    }
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


void addHiddenCategory(Map<String, String> category) {
  hiddenCategories.add(category);
}

void removeHiddenCategory(Map<String, String> category) {
  hiddenCategories.remove(category);
}

void clearHiddenCategories() {
  hiddenCategories.clear();
}

}