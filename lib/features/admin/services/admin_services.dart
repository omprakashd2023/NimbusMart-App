import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

import '../../../common/utils/utils.dart';
import '../../../common/utils/error_handling.dart';

import '../../../models/product.dart';

class AdminServices {
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
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic('dbnapbyof', 'a5wggotd');
      final List<String> imageUrls = [];
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

      final product = Product(
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
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.of(context).pop();
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
