import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryout/screens/loginscreen.dart';
import 'package:tryout/utils/global.color.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(const LoginScreen());
    });

    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo1.png', // Replace with the actual path to your image
          width: 150, // Adjust the width as needed
          height: 150, // Adjust the height as needed
        ),
      ),
    );
  }
}
