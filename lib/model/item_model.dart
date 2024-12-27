class ItemModel {
  String code;
  String name;
  String? description;
  String? type; // 'Barang' atau 'Jasa'
  bool isReturnable;
  double? purchasePrice;
  int? stock;
  String? currency;
  String? supplier;

  ItemModel({
    required this.code,
    required this.name,
    this.description,
    this.type,
    this.isReturnable = false,
    this.purchasePrice,
    this.stock,
    this.currency,
    this.supplier,
  });

  // Optional: Method untuk mengubah ke JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'type': type,
      'isReturnable': isReturnable,
      'purchasePrice': purchasePrice,
      'stock': stock,
      'currency': currency,
      'supplier': supplier,
    };
  }

  // Optional: Method untuk membuat model dari JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      code: json['code'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      isReturnable: json['isReturnable'] ?? false,
      purchasePrice: json['purchasePrice'],
      stock: json['stock'],
      currency: json['currency'],
      supplier: json['supplier'],
    );
  }
}
