import 'package:flutter/material.dart';
import 'package:tryout/screens/quizscreen.dart';
import 'package:tryout/screens/registerscreen.dart';
import 'package:tryout/utils/global.color.dart';
import '../services/api.services.dart';

import '../widget/button.global.dart';
import '../widget/social.login.dart';
import '../widget/text.form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ApiLogin apiLogin = ApiLogin();

Future<void> login() async {
  try {
    // Get user input from text controllers
    String username = emailController.text;
    String password = passwordController.text;

    // Call the login API endpoint using your instantiated ApiService
    bool loginSuccess = await ApiLogin.login(username, password);

    // Check if the login was successful
    if (loginSuccess) {
      // Show success popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Successful"),
            content: Text("You have successfully logged in."),
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

      // Navigate to the landing screen on successful login
      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage()));
    } else {
      // Show error popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Login failed. Please check your credentials."),
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
    }
  } catch (error) {
    // Handle other errors (you may want to log the error or perform additional actions)
    print('Login failed: $error');
  }
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
                  child: Text(
                    "Logo",
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Login to your acoount",
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //Email Input
                TextForm(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                //Password Input
                TextForm(
                    controller: passwordController,
                    textInputType: TextInputType.text,
                    obscure: true,
                    text: 'Password'),
                const SizedBox(
                  height: 10,
                ),
                ButtonGlobal(
              info: 'Sign in',
              onPressed: login,
            ),
                const SizedBox(
                  height: 10,
                ),
                SocialLogin(Sign: '-Or sign in with',),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an acoount?'),
            InkWell(
              onTap: () {
                // Pindah ke halaman baru di sini
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SignUp()), // Gantilah HalamanBaru dengan nama halaman yang ingin Anda tuju
                );
              },
              child: Text(
                ' Sign Up',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}