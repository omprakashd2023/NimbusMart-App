import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../provider/user.dart';
import '../../../provider/product.dart';

import '../../../common/utils/utils.dart';
import '../../../common/utils/error_handling.dart';

import '../../../models/product.dart';

class AdminService {
  final _url = dotenv.env['SERVER_URL'];

  void addProduct({
    required String productName,
    required String description,
    required String category,
    required double price,
    required int quantity,
    required List<File> images,
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      final List<String> imageUrls = [];
      final cloudinary = CloudinaryPublic('dbnapbyof', 'ttfgghay');
      for (final image in images) {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            folder: productName,
            resourceType: CloudinaryResourceType.Image,
          ),
        );
        imageUrls.add(response.secureUrl);
      }

      var product = Product(
        productName: productName,
        description: description,
        category: category,
        price: price,
        quantity: quantity,
        images: imageUrls,
      );

      final url = Uri.parse('$_url/api/admin/add-product');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
        body: product.toJson(),
      );
      final addedProduct = jsonDecode(response.body);
      product = Product.fromJson(jsonEncode(addedProduct["product"]));
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Provider.of<ProductProvider>(context, listen: false).addProduct(
            product: product,
          );
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.of(context).pop();
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<void> fetchAllProducts({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    List<Product> allProducts = [];
    try {
      final url = Uri.parse('$_url/api/admin/get-products');
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
      showSnackBar(context, err.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required String id,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      final url = Uri.parse('$_url/api/admin/delete-product/$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
      );
      final deletedProduct = jsonDecode(response.body);
      print(deletedProduct["product"]);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Deleted Successfully!');
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
