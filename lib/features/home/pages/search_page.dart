import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../widgets/header_section.dart';
import '../widgets/search_product.dart';

import '../services/home_services.dart';

class SearchPage extends StatefulWidget {
  final String searchText;
  const SearchPage({
    super.key,
    required this.searchText,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Product> products = [];
  final HomeService _homeServices = HomeService();

  @override
  void initState() {
    setState(() {
      searchController.text = widget.searchText;
    });
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct([String? searchText]) async {
    setState(() {
      isSearching = true;
    });
    print(searchText);
    print(widget.searchText);
    products = await _homeServices.fetchSearchedProducts(
      context: context,
      searchText: searchText ?? widget.searchText,
    );
    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        fetchSearchedProduct(searchText);
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
      body: isSearching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : products.isEmpty && searchController.text.isNotEmpty
              ? HeaderSection(
                  searchText: searchController.text,
                  isProductEmpty: true,
                )
              : Column(
                  children: [
                    HeaderSection(
                      searchText: searchController.text,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: SearchedProduct(
                              product: products[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
