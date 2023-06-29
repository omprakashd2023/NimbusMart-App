import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/error_handling.dart';

import '../../../common/utils/utils.dart';

import '../../../models/product.dart';

import '../../../provider/product.dart';
import '../../../provider/user.dart';

class HomeService {
  final _url = dotenv.env['SERVER_URL'];
  void fetchAllProducts({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    List<Product> allProducts = [];
    try {
      final url = Uri.parse('$_url/api/product/get-products');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
      );
      final products = jsonDecode(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < products["products"].length; i++) {
            allProducts.add(
              Product.fromJson(
                jsonEncode(
                  products["products"][i],
                ),
              ),
            );
          }
          Provider.of<ProductProvider>(context, listen: false)
              .setProducts(products: allProducts);
        },
      );
    } catch (err) {
      print(err.toString());
      showSnackBar(context, err.toString());
    }
  }

  Future<List<Product>> fetchSearchedProducts({
    required BuildContext context,
    required String searchText,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      final url = Uri.parse('$_url/api/product/search/$searchText');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      final searchResults = jsonDecode(response.body)["searchResults"];

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          if (searchResults.length != 0) {
            for (int i = 0; i < searchResults.length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    searchResults[i],
                  ),
                ),
              );
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void rateProduct({
    required BuildContext context,
    required String productId,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    DateTime dateTime = DateTime.now();
    int reviewedAt = dateTime.millisecondsSinceEpoch;
    double sum = 0;
    double avgRating = 0;
    var product = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(id: productId);
    if (product.avgRating != 0) {
      for (int j = 0; j < product.rating!.length; j++) {
        if (product.rating![j].userId == userProvider.user.id) {
          sum += rating;
        } else {
          sum += product.rating![j].rating;
        }
      }
      avgRating = sum / product.rating!.length;
      product = product.copyWith(
        avgRating: avgRating,
        rating: product.rating!
            .map((e) => e.userId == userProvider.user.id
                ? e.copyWith(rating: rating)
                : e)
            .toList(),
      );
    } else {
      product = product.copyWith(avgRating: rating);
      avgRating = rating;
    }
    Provider.of<ProductProvider>(context, listen: false)
        .addProduct(product: product);

    try {
      final url = Uri.parse('$_url/api/product/rate-product');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "productId": productId,
            "rating": rating,
            "reviewedAt": reviewedAt,
            "avgRating": avgRating,
          },
        ),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (err) {
      print(err.toString());
      showSnackBar(context, err.toString());
    }
  }
}
