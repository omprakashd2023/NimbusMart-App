import 'package:flutter/material.dart';

import '../../../models/product.dart';

import '../../../common/widgets/rating_bar.dart';
import '../../../routes.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(
          Routes.productDetailRoute,
          arguments: product.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            Image.network(
              product.images[0],
              fit: BoxFit.fitWidth,
              height: 135.0,
              width: 135.0,
            ),
            Column(
              children: [
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 5.0,
                  ),
                  child: RatingBar(rating: product.avgRating!),
                ),
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 5.0,
                  ),
                  child: const Text(
                    'Eligible for FREE shipping',
                  ),
                ),
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 5.0,
                  ),
                  child: Text(
                    '₹${product.price}/-',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 5.0,
                  ),
                  child: const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
