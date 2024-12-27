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

  var selectedType = ''.obs;
  var allowReturn = false.obs;
  var purchaseInfoEnabled = false.obs;
  var filteredItems = <Map<String, String>>[].obs;

  var items = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredItems.assignAll(items); // Sinkronisasi awal
    ever(items, (_) => filteredItems.assignAll(items)); // Perbarui otomatis
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
    'supplier': supplierController.text,
    'allowReturn': allowReturn.value.toString(),
    'image': imagePath ?? '', // Pastikan nilainya selalu String
  };

  items.add(item); // Tambah ke daftar item
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
      'supplier': supplierController.text,
      'allowReturn': allowReturn.value.toString(), // Konversi ke String
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
  }

void deleteItem(Map<String, dynamic> item) {
  items.removeWhere((element) => element['id'] == item['id']);
  filteredItems.assignAll(items);
}

}
