import 'package:flutter/material.dart';

//Widgets
import '../../../common/widgets/custom_textfield.dart';
import '../../../common/widgets/custom_button.dart';

//Services
import '../services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  //todo: Add a client side validation
  //todo: After an user signs up, the user should not be redirected to the sign in page rather he/she should be redirected to the home page

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffebecee),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? Colors.white
                    : const Color(0xffebecee),
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: Colors.amber,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                          isObscureText: true,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextfield(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm Password',
                          isObscureText: true,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? Colors.white
                    : const Color(0xffebecee),
                title: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: Colors.amber,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                          isObscureText: true,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
