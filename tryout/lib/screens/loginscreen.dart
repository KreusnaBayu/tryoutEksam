import 'package:flutter/material.dart';
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

  void login() {
    // Navigate to the landing screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
                ButtonGlobal(info: 'Sign In',
                onPressed: () {
                  login();
                },),
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