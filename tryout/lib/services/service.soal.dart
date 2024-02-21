// api_soal.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tryout/utils/option.dart';

class ApiSoal {
  static Future<List<Map<String, dynamic>>> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-test.eksam.cloud/api/v1/tryout/question'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> questionsData = json.decode(response.body);

        // Memastikan respons berupa List<Map<String, dynamic>>
        if (questionsData is List &&
            questionsData.isNotEmpty &&
            questionsData[0] is Map<String, dynamic>) {
          return List<Map<String, dynamic>>.from(questionsData);
        } else {
          throw Exception('Invalid data format in API response');
        }
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Please check your internet connection.');
    }
  }

   static Future<List<Option>> fetchQuestionOptions(int tryoutQuestionId) async {
  try {
    final response = await http.get(
      Uri.parse('https://api-test.eksam.cloud/api/v1/tryout/question-option'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> optionsData = json.decode(response.body);

      // Memastikan respons berupa List<Map<String, dynamic>>
      if (optionsData is List &&
          optionsData.isNotEmpty &&
          optionsData[0] is Map<String, dynamic>) {
        final List<Option> options = optionsData.map((data) => Option(
          id: data['id'],
          inisial: data['inisial'],
          jawaban: data['jawaban'],
          isCorrect: data['iscorrect'] == '1',
          nilai: int.parse(data['nilai']),
          tryoutQuestionId: tryoutQuestionId,  // Menyertakan tryoutQuestionId
        )).toList();

        return options;
      } else {
        throw Exception('Invalid data format in API response');
      }
    } else {
      throw Exception('Failed to load question options: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server. Please check your internet connection.');
  }
}
}