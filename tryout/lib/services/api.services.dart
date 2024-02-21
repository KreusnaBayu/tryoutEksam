import 'package:dio/dio.dart'; // Import Dio package


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

  static Future<Map<String, dynamic>> validateCredentials(String email, String password) async {
    const apiUrl = '$baseUrl/login'; // Ganti dengan API endpoint validasi sesuai kebutuhan

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
      // Validate credentials first
      Map<String, dynamic> userData = await validateCredentials(email, password);

      if (userData.isNotEmpty) {
        // Continue with the login process
        const loginUrl = '$baseUrl/login'; // Ganti dengan API endpoint login yang sesuai

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
          // Login berhasil
          print('Login successful');

          // Lakukan sesuatu dengan data pengguna yang masuk
          print('User data: $userData');

          return true;
        } else {
          // Login gagal
          print('Login failed with status code: ${response.data['status_code']}');
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
