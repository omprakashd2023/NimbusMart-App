import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../common/utils/constants.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: Constants.carouselImages
          .map(
            (item) => Builder(
              builder: (context) => Image.network(
                item,
                fit: BoxFit.cover,
                height: 200.0,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 2),
        autoPlay: true,
        viewportFraction: 1,
        height: 200.0,
      ),
    );
  }
}
