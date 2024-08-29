
import 'dart:io';
import 'dart:ui';

import 'package:baiti_residential_services/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();
  TextEditingController _firstNameTextEditingController = TextEditingController();
  TextEditingController _lastNameTextEditingController = TextEditingController();
  TextEditingController _cityTextEditingController = TextEditingController();
  TextEditingController _countryTextEditingController = TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? imageFileOfUser;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: const Text(
          "Create New Account ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              child: Image.asset(
                "images/signup.png",
                width: 240,
              ),
            ),
            const Text(
              "Tell us about you:",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          suffixIcon: Icon(Icons.email),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _emailTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write valid email.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "First Name",
                          suffixIcon: Icon(Icons.person),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _firstNameTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your first name.";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          suffixIcon: Icon(Icons.person),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _lastNameTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your last name.";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "City",
                          suffixIcon: Icon(Icons.location_city),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _cityTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your city name.";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Country",
                          suffixIcon: Icon(Icons.flag),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _countryTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your country name.";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Bio",
                          suffixIcon: Icon(Icons.info),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        maxLines: 4,
                        controller: _bioTextEditingController,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: MaterialButton(
                        onPressed: () async
                         {
                           var imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                           if(imageFile != null)
                           {
                            imageFileOfUser = File(imageFile.path);

                            setState(() {
                              imageFileOfUser;
                            });
                           }
                          // Implement the functionality to select and display image
                        },
                        child: imageFileOfUser == null
                            ? const Icon(Icons.add_a_photo)
                            : CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: MediaQuery.of(context).size.width / 5.0,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(imageFileOfUser!),
                                  radius:
                                      MediaQuery.of(context).size.width / 5.0,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 44.0, right: 80, left: 80),
              child: ElevatedButton(
                onPressed: ()
                 {
                  
                  if (!_formKey.currentState!.validate() || imageFileOfUser == null)
                   {
                    Get.snackbar("Field Missing", "Please choose image and fill out complete sign up form.");
                    return;
                    // Handle account creation logic here
                  }
                  if(_emailTextEditingController.text.isEmail && _passwordTextEditingController.text.isEmail)
                  {
                      Get.snackbar("Field Missing", "Please fill out complete sign up form.");
                    return;
                  }

                  userViewModel.signUp(
                  _emailTextEditingController.text.trim(),
                  _passwordTextEditingController.text.trim(),
                  _firstNameTextEditingController.text.trim(),
                  _lastNameTextEditingController.text.trim(),
                  _cityTextEditingController.text.trim(),
                  _countryTextEditingController.text.trim(),
                  _bioTextEditingController.text.trim(),
                  imageFileOfUser!,
                  // idher image k last par ! nahi ata video ma but mery pass error ata tha is liaya
                  //add kia aur kisi b account say login hota ho tou image k hi show hoti ha yee issue ha
                  );
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
