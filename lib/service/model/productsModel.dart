class ProductModel {
  String productId;
  String qrCode;
  String name;
  String price;
  String count;
  String imageUrl; // New field

  ProductModel({
    required this.productId,
    required this.qrCode,
    required this.name,
    required this.price,
    required this.count,
    required this.imageUrl, // Include the imageUrl field in the constructor
  });

  // A named constructor to create a copy of the object with optional parameters.
  ProductModel copyWith({
    String? productId,
    String? qrCode,
    String? name,
    String? price,
    String? count,
    String? imageUrl, // Include imageUrl in the copyWith method
  }) =>
      ProductModel(
        productId: productId ?? this.productId,
        qrCode: qrCode ?? this.qrCode,
        name: name ?? this.name,
        price: price ?? this.price,
        count: count ?? this.count,
        imageUrl: imageUrl ?? this.imageUrl, // Update imageUrl in copyWith
      );

  // Factory method to create a ProductModel from JSON data.
  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      productId: jsonData['productId'] as String? ?? '',
      qrCode: jsonData['qrCode'] as String? ?? '',
      name: jsonData['name'] as String? ?? '',
      price: jsonData['price'] as String? ?? '',
      count: jsonData['count'] as String? ?? '',
      imageUrl: jsonData['imageUrl'] as String? ?? '', // Deserialize imageUrl
    );
  }

  // Method to convert the object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'qrCode': qrCode,
      'name': name,
      'price': price,
      'count': count,
      'imageUrl': imageUrl, // Serialize imageUrl
    };
  }

  @override
  String toString() {
    return '''
      'productId': $productId,
      'qrCode': $qrCode,
      'name': $name,
      'price': $price,
      'count': $count,
      'imageUrl': $imageUrl,
      ''';
  }
}
