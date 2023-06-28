import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/error_handling.dart';

import '../../../common/utils/utils.dart';

import '../../../models/product.dart';

import '../../../provider/user.dart';

class HomeService {
  final _url = dotenv.env['SERVER_URL'];
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
}
