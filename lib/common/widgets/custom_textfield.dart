import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscureText = false,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
