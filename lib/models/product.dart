import 'dart:convert';

class Product {
  final String productName;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  // final List<Rating>? rating;

  Product({
    required this.productName,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    // this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      // 'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      /* rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,*/
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
