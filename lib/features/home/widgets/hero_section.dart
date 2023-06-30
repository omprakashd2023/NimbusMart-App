import 'package:flutter/material.dart';

import '../../../common/widgets/rating_bar.dart';
import '../../../models/product.dart';
import '../services/home_services.dart';

import '../../../routes.dart';

//Deal of the day section
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final HomeService _homeServices = HomeService();
  Product? _dealOfTheDay;

  @override
  void initState() {
    _fetchDealOfTheDay();
    super.initState();
  }

  void _fetchDealOfTheDay() async {
    _dealOfTheDay = await _homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToProductDetailPage() {
    Navigator.of(context).pushNamed(
      Routes.productDetailRoute,
      arguments: _dealOfTheDay!.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dealOfTheDay == null
        ? const SizedBox(
          height: 350,
          child: Center(
              child: CircularProgressIndicator(),
            ),
        )
        : _dealOfTheDay!.productName == ''
            ? const Center(
                child: Text('No deal of the day'),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        top: 5.0,
                      ),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Image.network(
                      _dealOfTheDay!.images[0],
                      height: 235.0,
                      fit: BoxFit.fitHeight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _dealOfTheDay!.productName,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: RatingBar(
                            rating: _dealOfTheDay!.avgRating!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '₹${_dealOfTheDay!.price}/-',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _dealOfTheDay!.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (_dealOfTheDay!.images.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _dealOfTheDay!.images
                                .map(
                                  (e) => Image.network(
                                    e,
                                    fit: BoxFit.fitWidth,
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: navigateToProductDetailPage,
                        child: Text(
                          'See all deals',
                          style: TextStyle(
                            color: Colors.cyan[800],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
