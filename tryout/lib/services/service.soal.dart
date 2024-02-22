
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tryout/model/question_model.dart';
import 'package:tryout/services/api.services.dart';

class ApiSoal {
  final String host = 'https://api-test.eksam.cloud';
  
  Future<Question> fetchQuestion(int questionId) async {
    String? authToken = ApiLogin.getAuthToken();

    if (kDebugMode) {
      print(authToken);
      print('$host/api/v1/tryout/question/$questionId');
    }

      if (authToken != null) {
      try {
        final response = await Dio().get(
          '$host/api/v1/tryout/question/$questionId',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $authToken",
            },
          ),
        );

        if (response.statusCode == 200) {
          final responseData = response.data['data'];
          final question = Question.fromJson({
            'id': int.parse(responseData['id'].toString()),
            'no_soal': responseData['no_soal'],
            'soal': responseData['soal'],
            'tryout_question_option': responseData['tryout_question_option'],
          });

          return question;
        } else {
          // Handle unsuccessful response (e.g., print error message)
          print('Failed to load question with status code: ${response.statusCode}');
          print('Response Body: ${response.data}');
          throw Exception('Failed to load question');
        }
      } catch (error) {
        // Handle other types of errors (e.g., network error)
        print('Error fetching question: $error');
        throw Exception('Failed to load question');
      }
    } else {
      // Handle case where authToken is null
      print('AuthToken is null. User may not be authenticated.');
      throw Exception('Failed to load question');
    }
  }
}