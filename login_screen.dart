

import 'package:baiti_residential_services/view/signup_screen.dart';
import 'package:baiti_residential_services/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // Assuming you have user_view_model.dart for UserViewModel

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final UserViewModel userViewModel = UserViewModel(); // Instantiating the UserViewModel
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange,
              Colors.deepOrangeAccent,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListView(
          children: [
            Image.asset("images/logo.png"),
            const Text(
              "Offer Your Residence..Or Find a Palace to Stay",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Email",
                          suffixIcon: Icon(Icons.email),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _emailTextEditingController,
                        validator: (valueEmail) {
                          if (!valueEmail!.contains("@")) {
                            return "Please enter a valid email.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _passwordTextEditingController,
                        obscureText: _isObscure,
                        validator: (valuePassword) {
                          if (valuePassword!.length < 6) {
                            return "Password must be at least 6 characters.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await userViewModel.login(
                              _emailTextEditingController.text.trim(),
                              _passwordTextEditingController.text.trim(),
                            );
                            // Handle login logic here
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: EdgeInsets.symmetric(horizontal: 60),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignupScreen());
                      },
                      child: const Text(
                        "Don't have an account? Create here",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
