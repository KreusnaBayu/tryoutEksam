import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tryout/services/api.services.dart';

class ApiReport {
  static final String host = 'https://api-test.eksam.cloud';

  static Future<void> kirimLaporan(String tryoutQuestionId, String laporan) async {
    if (tryoutQuestionId.isEmpty || laporan.isEmpty) {
      print('ID pertanyaan atau laporan tidak boleh kosong.');
      throw Exception('ID pertanyaan atau laporan tidak boleh kosong.');
    }

    String? authToken = ApiLogin.getAuthToken();

    if (kDebugMode) {
      print(authToken);
    }

    if (authToken != null) {
      try {
        final response = await Dio().post(
          '$host/api/v1/tryout/lapor-soal/create',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $authToken",
            },
          ),
          data: {
            'tryout_question_id': tryoutQuestionId,
            'laporan': laporan,
          },
        );

        print('ID jawaban: $tryoutQuestionId');
        print('Isi laporan : $laporan');

        if (response.statusCode == 200) {
          // Sukses
          print('Berhasil mengirim laporan');
        } else {
          // Gagal
          print('Gagal mengirim laporan. Status code: ${response.statusCode}');
          print('Response: ${response.data}');
          throw Exception('Gagal mengirim laporan');
        }
      } catch (error) {
        // Handle other types of errors (e.g., network error)
        print('Error sending report: $error');
        throw Exception('Error sending report');
      }
    } else {
      // Handle case where authToken is null
      print('AuthToken is null. User may not be authenticated.');
      throw Exception('AuthToken is null. User may not be authenticated.');
    }
  }
}
