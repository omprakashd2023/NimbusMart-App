import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../models/user.dart';

import '../../../common/utils/error_handling.dart';

import '../../../common/widgets/snackbar.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      final url = dotenv.env['SERVER_URL'];
      final uri = Uri.parse('$url/api/signup');
      final response = await http.post(
        uri,
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (kDebugMode) {
        print(response.body);
      }

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        context: context,
        response: response,
        onSuccess: () {
          showSnackBar(
            context,
            'Account Created Successfully!',
          );
        },
      );
    } catch (err) {
      print(err.toString());
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }
}
