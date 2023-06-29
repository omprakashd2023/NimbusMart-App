import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rating_bar;
import 'package:provider/provider.dart';

import '../../../models/rating.dart';
import '../services/home_services.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/rating_bar.dart';

import '../../../provider/product.dart';
import '../../../provider/user.dart';

import '../../../routes.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double avgRating = 0;
  double myRating = 0;
  final HomeService _homeService = HomeService();
  final TextEditingController searchController = TextEditingController();
  void navigateToSearchPage(String searchText) {
    Navigator.of(context).pushNamed(
      Routes.searchRoute,
      arguments: searchText,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context)
        .getProductById(id: widget.productId);
    final user = Provider.of<UserProvider>(context).user;
    double userRating = product.rating != null
        ? product.rating!
            .firstWhere(
              (element) => element.userId == user.id,
              orElse: () => Rating(
                userId: user.id,
                rating: 0,
                reviewedAt: DateTime.now(),
              ),
            )
            .rating
        : 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E88E5),
                  Color(0xFF64B5F6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 42.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    elevation: 1.0,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (searchText) {
                        navigateToSearchPage(searchText);
                        searchController.clear();
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 6.0,
                          ),
                          child: Icon(
                            Icons.search_outlined,
                            size: 23.0,
                            color: Colors.black,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                          top: 10.0,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        hintText: 'Search for products',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: const Icon(
                  Icons.mic_none_outlined,
                  color: Colors.black,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Category: ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: product.category,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RatingBar(
                    rating: product.avgRating!,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10.0,
              ),
              child: Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            CarouselSlider(
              items: product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200.0,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300.0,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '₹${product.price}',
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: () {},
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            rating_bar.RatingBar.builder(
              initialRating: userRating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _homeService.rateProduct(
                  context: context,
                  productId: product.id!,
                  rating: rating,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
