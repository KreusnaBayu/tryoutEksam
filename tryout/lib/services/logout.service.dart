import 'package:dio/dio.dart';


class ApiLogout {
  static const String baseUrl = 'https://api-test.eksam.cloud/api/v1/auth';

  static Future<bool> logout(String authToken) async {
    try {
      String logoutUrl = '$baseUrl/logout';

      final response = await Dio().post(
        logoutUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $authToken",
          },
        ),
      );

      if (response.data['status_code'] == 200) {
        print('Logout successful');
        // Hapus token dari SharedPreferences atau variabel authToken jika diperlukan
        return true;
      } else {
        print('Logout failed with status code: ${response.data['status_code']}');
        print('Response body: ${response.data}');
      }
    } catch (error) {
      print('Error during logout: $error');
    }

    return false;
  }
}

