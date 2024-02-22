import 'package:dio/dio.dart'; // Import Dio package
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  static const String baseUrl = 'https://api-test.eksam.cloud/api/v1/auth';

  static Future<void> signup(String name, String email, String password) async {
    const apiUrl = '$baseUrl/register'; // Ganti dengan API endpoint yang sesuai

    try {
      final response = await Dio().post(
        apiUrl,
        data: {"name": name, "email": email, "password": password},
      );

      if (response.data['status_code'] == 200) {
        print('Signup successful');
      } else {
        print('Signup failed with status code: ${response.data['status_code']}');
        print('Error messages: ${response.data['messages']}');
        // Tambahkan log atau penanganan kesalahan sesuai kebutuhan Anda
        throw Exception('Signup failed with status code: ${response.data['status_code']}, Error messages: ${response.data['messages']}');
      }
    } catch (error) {
      print('Error during signup: $error');
      // Tambahkan log atau penanganan kesalahan sesuai kebutuhan Anda
      throw Exception('Error during signup: $error');
    }
  }
}


class ApiLogin {
  static const String baseUrl = 'https://api-test.eksam.cloud/api/v1/auth';
  static String? authToken;  // Simpan token di sini

  static Future<Map<String, dynamic>> validateCredentials(String email, String password) async {
    const apiUrl = '$baseUrl/login';

    try {
      final response = await Dio().post(
        apiUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.data['status_code'] == 200) {
        print('Credentials are valid');
        authToken = response.data['data']['access_token'];  // Simpan token setelah login

        // Menyimpan token di SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('authToken', authToken!);

        return response.data['data']['user'];
      } else if (response.data['status_code'] == 401) {
        print('Invalid username or password');
      } else {
        print('Validation failed with status code: ${response.data['status_code']}');
        print('Response body: ${response.data}');
      }
    } catch (error) {
      print('Error during validation: $error');
    }

    return {};
  }

  static Future<bool> login(String email, String password) async {
    try {
      Map<String, dynamic> userData = await validateCredentials(email, password);

      if (userData.isNotEmpty) {
        String loginUrl = '$baseUrl/login'; // Remove 'const' from loginUrl

        final response = await Dio().post(
          loginUrl,
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ),
          data: {
            "email": email,
            "password": password,
          },
        );

        if (response.data['status_code'] == 200) {

          print('User data: $userData');
          return true;
        } else {
          print('Login failed with status code: ${response.data['status_code']}');
          print('Response body: ${response.data}');
        }
      } else {
        print('Login failed: Invalid credentials');
      }
    } catch (error) {
      print('Error during login: $error');
    }

    return false;
  }

  static String? getAuthToken() {
    return authToken;
  }
}