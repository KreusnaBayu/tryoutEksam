import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tryout/screens/loginscreen.dart';
import 'package:tryout/utils/global.color.dart';
import 'package:tryout/widget/button.global.dart';
import 'package:tryout/widget/social.login.dart';
import 'package:tryout/widget/text.form.dart';

import '../services/api.services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Instantiate your API service
  ApiService apiService = ApiService();

  Future<void> signup() async {
    try {
      // Get user input
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      // Call the signup API endpoint
      await ApiService.signup(name, email, password);

      // Show success popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Signup Successful"),
            content: Text("You have successfully signed up."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      // Navigate to the login screen on successful signup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (error) {
      // Show error popup with the specific error message from API
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Signup Failed"),
            content: Text("Signup failed. ${getErrorMessages(error)}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      // Handle errors (you may want to log the error or perform additional actions)
      print('Signup failed: $error');
    }
  }

  String getErrorMessages(error) {
    if (error is Exception) {
      // Parse and format error messages from API
      try {
        Map<String, dynamic> errorData = jsonDecode(error.toString());
        if (errorData.containsKey('messages')) {
          Map<String, dynamic> messages = errorData['messages'];
          String errorMessage = '';
          messages.forEach((field, fieldErrors) {
            errorMessage += '$field: ${fieldErrors[0]}\n';
          });
          return errorMessage;
        }
      } catch (e) {
        // Handle JSON parsing error
      }
    }
    return 'An unknown error occurred.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo2.png', // Replace with the actual path to your image
                    width: 150, // Adjust the width as needed
                    height: 150, // Adjust the height as needed
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextForm(
                  controller: nameController,
                  text: 'Username',
                  obscure: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Email Input
                TextForm(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Password Input
                TextForm(
                    controller: passwordController,
                    textInputType: TextInputType.text,
                    obscure: false,
                    text: 'Password'),
                const SizedBox(
                  height: 10,
                ),
                ButtonGlobal(
                  info: 'Sign Up',
                  onPressed: signup,
                ),
                const SizedBox(
                  height: 10,
                ),
                SocialLogin(
                  Sign: '-Or sign up with',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
