import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      print(1);
      break;
    case 400:
      print(2);
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['reason']);
      print(3);
      break;
    default:
      print(4);
      showSnackBar(context, response.body);
  }
}
