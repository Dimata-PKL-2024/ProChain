import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  var categories = <Map<String, String>>[].obs;
  var hiddenCategories = <Map<String, String>>[].obs;
  var filteredCategories = <Map<String, String>>[].obs;
  var searchController = TextEditingController();

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taxTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pointPriceController = TextEditingController();
  final TextEditingController priceIncreaseController = TextEditingController();
  final documentNumberController = TextEditingController();
  final locationController = TextEditingController();
  final categoryController = TextEditingController();
  final dateController = TextEditingController();
  final statusController = TextEditingController();
  final sortFieldController = TextEditingController();
  bool isChecked = false;

  var selectedParentCategory = Rxn<String>();
  var selectedType = ''.obs;
  var selectedFilter = Rxn<String>();
  var showMoreFields = false.obs;
  var isHidden = false.obs;

var filterNumber = ''.obs;
  var filterLocation = ''.obs;
  var filterCategory = ''.obs;
  var filterDate = ''.obs;

  void applyFilters() {
    // Logika untuk menerapkan filter berdasarkan inputan
    filteredCategories.value = categories.where((category) {
      return (filterNumber.isEmpty || category['number'] == filterNumber.value) &&
             (filterLocation.isEmpty || category['location'] == filterLocation.value) &&
             (filterCategory.isEmpty || category['name'] == filterCategory.value) &&
             (filterDate.isEmpty || category['date'] == filterDate.value);
    }).toList();
  }


  var locations = <String>["Kandang Pengumbaran", "Kandang Pengiang", "Kandang Pullet", "Kandang Pullet 2", "Gudang Pakan", "Kandang Songandak"].obs;
  var filteredLocations = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // Sinkronisasi filteredCategories dengan categories
    filteredCategories.assignAll(categories);

    // Reset pencarian setiap kali categories berubah
    ever(categories, (_) => searchCategories(''));

    // Sinkronisasi filteredLocations dengan locations
    filteredLocations.assignAll(locations);
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
      hiddenCategories.add(category);
    } else {
      categories.add(category);
    }
    clearForm();

    // Setelah menyimpan, kembalikan isHidden ke false
    isHidden.value = false;
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredCategories.assignAll(
        categories.where((category) {
          final name = category['name']?.toLowerCase() ?? '';
          return name.contains(lowerCaseQuery);
        }),
      );
    }
  }

  void searchLocations(String query) {
    if (query.isEmpty) {
      filteredLocations.assignAll(locations);
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredLocations.assignAll(
        locations.where((location) => location.toLowerCase().contains(lowerCaseQuery)),
      );
    }
  }

  void filterCategories(String type) {
    selectedFilter.value = type;
    if (type.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
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
    documentNumberController.dispose();
    locationController.dispose();
    categoryController.dispose();
    dateController.dispose();
    statusController.dispose();
    sortFieldController.dispose();
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

  void unhideCategory(Map<String, String> category) {
    hiddenCategories.remove(category); // Hapus dari kategori tersembunyi
    categories.add(category); // Tambahkan ke kategori biasa
    filteredCategories.assignAll(categories); // Sinkronisasi data yang ditampilkan
  }

void deleteCategory(Map<String, String> category) {
  categories.remove(category);
  filteredCategories.assignAll(categories);
}

void hideCategory(Map<String, String> category) {
  categories.remove(category);
  hiddenCategories.add(category);
  filteredCategories.assignAll(categories);
}


  
}