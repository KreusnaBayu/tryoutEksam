import 'package:dio/dio.dart'; // Import Dio package

class ApiService {
  static const String baseUrl = 'https://api-test.eksam.cloud/api/v1/auth';

  static Future<void> signup(String name,String email, String password) async {
    final apiUrl = '$baseUrl/register'; // Replace with your actual API endpoint

    try {
      final response = await Dio().post(
        apiUrl,
        data: {"name": name, "email": email, "password": password},
      );

      if (response.statusCode == 200) {
        print('Signup successful');
      } else {
        print('Signup failed with status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (error) {
      print('Error during signup: $error');
    }
  }
}

class ApiLogin {
  static const String baseUrl = 'https://api-test.eksam.cloud/api/v1/auth';

  static Future<bool> validateCredentials(String email, String password) async {
    final apiUrl = '$baseUrl/login'; // Replace with your actual API endpoint for validation

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

      if (response.statusCode == 200) {
        print('Credentials are valid');
        return true;
      } else if (response.statusCode == 401) {
        print('Invalid username or password');
      } else {
        print('Validation failed with status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (error) {
      print('Error during validation: $error');
    }

    return false;
  }

  static Future<bool> login(String email, String password) async {
    try {
      // Validate credentials first
      bool isValidCredentials = await validateCredentials(email, password);

      if (isValidCredentials) {
        // Continue with the login process
        final loginUrl = '$baseUrl/login'; // Replace with your actual login API endpoint

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

        if (response.statusCode == 200) {
          // Login berhasil
          if (response.data['status'] == "Success") {
            print('Login successful');
            return true;
          } else {
            // Login gagal: Status message tidak sesuai
            print('Login failed with status message: ${response.data['status']}');
            print('Response body: ${response.data}');
          }
        } else {
          // Login gagal: Password salah atau pengguna tidak ditemukan
          print('Login failed with status code: ${response.statusCode}');
          print('Response body: ${response.data}');
        }
      } else {
        // Login gagal: Kredensial tidak valid
        print('Login failed: Invalid credentials');
      }
    } catch (error) {
      // Tangani kesalahan selama login
      print('Error during login: $error');
    }

    return false;
  }
}
