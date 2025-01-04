import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final unitController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final stockController = TextEditingController();
  final currencyController = TextEditingController();
  final supplierController = TextEditingController();
  final dateController = TextEditingController();
  final statusController = TextEditingController();
  final documentNumberController = TextEditingController();
  final locationController = TextEditingController();
  bool isChecked = false;

  var selectedType = ''.obs;
  var allowReturn = false.obs;
  var purchaseInfoEnabled = false.obs;
  var filteredItems = <Map<String, String>>[].obs;

  var items = <Map<String, String>>[].obs;

  // Supplier-related variables
  var suppliers = <String>[
    "Kandang Pengumbaran",
    "Kandang Pengiang",
    "Kandang Pullet",
    "Kandang Pullet 2",
    "Gudang Pakan",
    "Kandang Songandak"
  ].obs;
  var filteredSuppliers = <String>[].obs;
  var selectedSupplier = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    filteredItems.assignAll(items); // Sinkronisasi awal
    ever(items, (_) => filteredItems.assignAll(items)); // Perbarui otomatis

    // Initialize supplier list
    filteredSuppliers.assignAll(suppliers);
  }

  void saveItem(String? imagePath) {
    final item = {
      'name': nameController.text,
      'sku': skuController.text,
      'unit': unitController.text,
      'category': categoryController.text,
      'description': descriptionController.text,
      'purchasePrice': purchasePriceController.text,
      'stock': stockController.text,
      'currency': currencyController.text,
      'supplier': selectedSupplier.value ?? '', // Save selected supplier
      'allowReturn': allowReturn.value.toString(),
      'image': imagePath ?? '', // Ensure it's always a string
    };

    items.add(item); // Add to item list
    clearForm();
  }

  void addItem() {
    items.add({
      'name': nameController.text,
      'sku': skuController.text,
      'unit': unitController.text,
      'category': categoryController.text,
      'description': descriptionController.text,
      'purchasePrice': purchasePriceController.text,
      'stock': stockController.text,
      'currency': currencyController.text,
      'supplier': selectedSupplier.value ?? '', // Save selected supplier
      'allowReturn': allowReturn.value.toString(),
    });
    clearForm();
  }

  void clearForm() {
    nameController.clear();
    skuController.clear();
    unitController.clear();
    categoryController.clear();
    descriptionController.clear();
    purchasePriceController.clear();
    stockController.clear();
    currencyController.clear();
    supplierController.clear();
    selectedType.value = '';
    allowReturn.value = false;
    purchaseInfoEnabled.value = false;
    selectedSupplier.value = null; // Reset selected supplier
  }

  void deleteItem(Map<String, dynamic> item) {
    items.remove(item); // Remove item
    filteredItems.assignAll(items); // Update filtered items
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(items); // Show all items if query is empty
    } else {
      filteredItems.assignAll(
        items.where((item) {
          return item['name']!.toLowerCase().contains(query.toLowerCase()) ||
                 item['category']!.toLowerCase().contains(query.toLowerCase());
        }).toList(),
      );
    }
  }

  void searchSuppliers(String query) {
    if (query.isEmpty) {
      filteredSuppliers.assignAll(suppliers); // Show all if query is empty
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredSuppliers.assignAll(
        suppliers.where((supplier) => supplier.toLowerCase().contains(lowerCaseQuery)),
      );
    }
  }

  
}
