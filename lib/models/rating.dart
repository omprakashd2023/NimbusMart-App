// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rating {
  final String userId;
  final double rating;
  final DateTime reviewedAt;
  Rating({
    required this.userId,
    required this.rating,
    required this.reviewedAt,
  });

  Rating copyWith({
    String? userId,
    double? rating,
    DateTime? reviewedAt,
  }) {
    return Rating(
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'reviewedAt': reviewedAt.millisecondsSinceEpoch,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] as String,
      rating: map['rating'].toDouble(),
      reviewedAt: DateTime.fromMillisecondsSinceEpoch(map['reviewedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
