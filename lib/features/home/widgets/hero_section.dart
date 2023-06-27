import 'package:flutter/material.dart';

//Deal of the day section
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          "https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=400",
          height: 235.0,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15.0),
          alignment: Alignment.topLeft,
          child: const Text(
            '₹70,000',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15.0, top: 5.0, right: 40.0),
          child: const Text(
            'https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=400',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=400',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Image.network(
                  'https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=400',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Image.network(
                  'https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=400',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Image.network(
                  'https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=400',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ).copyWith(left: 15.0),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
