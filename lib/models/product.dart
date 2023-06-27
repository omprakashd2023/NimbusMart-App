import 'dart:convert';

class Product {
  final String? id;
  final String productName;
  final String description;
  final String category;
  final double price;
  final int quantity;
  final List<String> images;
  // User Id
  //Rating

  Product({
    this.id,
    required this.productName,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    required this.images,
  });

  Product copyWith({
    String? id,
    String? productName,
    String? description,
    String? category,
    double? price,
    int? quantity,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'description': description,
      'category': category,
      'price': price,
      'quantity': quantity,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] != null ? map['id'] as String : null,
      productName: map['productName'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      images: List<String>.from(
        (map['images']),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
