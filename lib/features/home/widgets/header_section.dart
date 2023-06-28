import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final String address;
  final String searchText;
  final bool isProductEmpty;
  const HeaderSection({
    super.key,
    this.name = '',
    this.address = '',
    this.searchText = 'Nothing',
    this.isProductEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 26, 130, 221),
            Color.fromARGB(255, 107, 158, 199),
          ],
          stops: [
            0.5,
            1.0,
          ],
        ),
      ),
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      child: Row(
        children: [
          Icon(
            isProductEmpty
                ? Icons.not_interested_sharp
                : Icons.location_on_outlined,
            color: isProductEmpty ? Colors.red : Colors.white,
            size: 20.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: searchText == 'Nothing'
                  ? Text(
                      'Delivery to $name - $address',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(
                      !isProductEmpty
                          ? 'Search results for "$searchText"'
                          : 'No results found for "$searchText"',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          if (!isProductEmpty)
            const Padding(
              padding: EdgeInsets.only(
                left: 5.0,
                top: 2.0,
              ),
              child: Icon(
                Icons.arrow_drop_down_outlined,
                size: 18.0,
              ),
            )
        ],
      ),
    );
  }
}
