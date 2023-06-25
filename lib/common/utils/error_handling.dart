import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/snackbar.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      print('1');
      onSuccess();
      break;
    case 400:
      print(jsonDecode(response.body)['msg']);
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      print(jsonDecode(response.body)['error']);
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      print('4');
      showSnackBar(context, response.body);
  }
}
