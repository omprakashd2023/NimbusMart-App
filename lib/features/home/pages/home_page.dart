import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/home_services.dart';
import '../widgets/header_section.dart';
import '../widgets/category_section.dart';
import '../widgets/banner_section.dart';
import '../widgets/hero_section.dart';

import '../../../provider/user.dart';

import '../../../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeService _homeServices = HomeService();
  final TextEditingController searchController = TextEditingController();
  void navigateToSearchPage(String searchText) {
    Navigator.of(context).pushNamed(
      Routes.searchRoute,
      arguments: searchText,
    );
  }

  @override
  void initState() {
    _homeServices.fetchAllProducts(context: context);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
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
                child: Container(
                  height: 42.0,
                  margin: const EdgeInsets.only(
                    left: 15.0,
                  ),
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
          children: [
            //Address Section
            HeaderSection(
              name: user.user.name,
              address: user.user.address,
            ),
            const SizedBox(
              height: 10.0,
            ),
            //Category Section
            CategorySection(),
            const SizedBox(
              height: 10.0,
            ),
            //Carousel Listing Offers
            const BannerSection(),
            const SizedBox(
              height: 10.0,
            ),
            //Deal of the day section
            const HeroSection(),
          ],
        ),
      ),
    );
  }
}
