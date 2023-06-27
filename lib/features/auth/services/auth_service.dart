import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

import '../../../routes.dart';

import '../../../models/user.dart';

import '../../../common/utils/error_handling.dart';

import '../../../common/utils/utils.dart';

//todo: Refactor OnSuccess Function

class AuthService {
  //Sign Up User
  final _url = dotenv.env['SERVER_URL'];
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
      final uri = Uri.parse('$_url/api/signup');
      final response = await http.post(
        uri,
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        context: context,
        response: response,
        onSuccess: () async {
          showSnackBar(
            context,
            'Account Created Successfully!',
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final user = Provider.of<UserProvider>(context, listen: false);
          user.setUser(response.body);
          Navigator.of(context).pushNamedAndRemoveUntil(
              user.user.type == 'user' ? Routes.bottomBar : Routes.adminRoute,
              (route) => false);
          await prefs.setString(
              'x-auth-token', jsonDecode(response.body)['token']);
        },
      );
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  //Sign In User
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$_url/api/signin');
      final response = await http.post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        context: context,
        response: response,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final user = Provider.of<UserProvider>(context, listen: false);
          user.setUser(response.body);
          Navigator.of(context).pushNamedAndRemoveUntil(
              user.user.type == 'user' ? Routes.bottomBar : Routes.adminRoute,
              (route) => false);
          await prefs.setString(
              'x-auth-token', jsonDecode(response.body)['token']);
        },
      );
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  //Get already signed in user data
  Future<bool> autoLogin({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('x-auth-token') ?? '';

      if (token == '') {
        prefs.setString('x-auth-token', token);
      }

      final uri = Uri.parse('$_url/api/verify');
      final tokenResponse = await http.post(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      final response = jsonDecode(tokenResponse.body);
      if (response) {
        final url = Uri.parse('$_url/api/user');
        final userResponse = await http.get(url, headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        Provider.of<UserProvider>(context, listen: false)
            .setUser(userResponse.body);
        return true;
      }
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    return false;
  }
}
