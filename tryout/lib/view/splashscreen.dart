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
      Get.to(LoginScreen());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Text(
          "Logo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
      ),
    );
  }
}