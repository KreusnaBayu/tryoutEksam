import 'package:flutter/material.dart';
import 'package:tryout/controller/quiz_controller.dart';
import 'package:tryout/screens/loginscreen.dart';
import 'package:tryout/services/api.services.dart';
import 'package:tryout/services/logout.service.dart';
import 'package:tryout/utils/global.color.dart';

class ResultsPage extends StatelessWidget {
  final QuizController controller;
  final int totalScore;

  ResultsPage({required this.totalScore, required this.controller});

  // Fungsi untuk melakukan logout
Future<void> handleLogout(BuildContext context) async {
  String? authToken = ApiLogin.getAuthToken();
  if (authToken != null) {
    bool logoutSuccess = await ApiLogout.logout(authToken);

    if (logoutSuccess) {
      // Redirect ke halaman login atau lakukan tindakan lainnya setelah logout
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      // Tindakan jika logout gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed. Please try again.'),
        ),
      );
    }
  } else {
    print('No auth token found. Unable to logout.'); // Tindakan jika token tidak ditemukan
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/piala2.png',
              width: 400,
              height: 300,
            ),
            SizedBox(height: 16.0),
            Text(
              'Congratulations!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Your total score is: ${totalScore * 4}/ 100',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => handleLogout(context),  // Panggil fungsi logout
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent[700],
                onPrimary: Colors.white,
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}