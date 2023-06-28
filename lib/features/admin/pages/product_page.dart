import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/admin_services.dart';

import '../../../provider/product.dart';

import '../../../models/product.dart';

import '../../../common/widgets/product_tile.dart';

import '../../../routes.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final AdminService _adminServices = AdminService();
  List<Product> allProducts = [];
  bool isLoading = true;
  void navigateToAddProductPage() {
    Navigator.of(context).pushNamed(Routes.addProduct);
  }

  @override
  void initState() {
    startTimer();
    _adminServices.fetchAllProducts(context: context).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (allProducts.isEmpty) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    allProducts = productProvider.allProducts;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : allProducts.isEmpty
              ? const Center(
                  child: Text('No products'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: allProducts.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: ProductTile(
                            image: allProducts[index].images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                ),
                                child: Text(
                                  allProducts[index].productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _adminServices.deleteProduct(
                                  context: context,
                                  id: allProducts[index].id!,
                                );

                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .removeProduct(
                                  product: allProducts[index],
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProductPage,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
