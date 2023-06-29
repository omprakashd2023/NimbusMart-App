import 'dart:convert';

import './rating.dart';

class Product {
  final String productName;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;
  final double? avgRating;

  Product({
    required this.productName,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
    this.avgRating,
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
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] as String,
      description: map['description'] as String,
      quantity: map['quantity'],
      images: List<String>.from(
        (map['images']),
      ),
      category: map['category'] as String,
      price: map['price'].toDouble(),
      id: map['_id'] != null ? map['_id'] as String : null,
      rating: map['rating'] != null
          ? List<Rating>.from(
              (map['rating']).map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
      avgRating: map['avgRating'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Product copyWith({
    String? productName,
    String? description,
    int? quantity,
    List<String>? images,
    String? category,
    double? price,
    String? id,
    List<Rating>? rating,
    double? avgRating,
  }) {
    return Product(
      productName: productName ?? this.productName,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      id: id ?? this.id,
      rating: rating ?? this.rating,
      avgRating: avgRating ?? this.avgRating,
    );
  }
}
