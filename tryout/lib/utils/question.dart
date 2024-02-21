// question.dart
 // Import the Option class

import 'package:tryout/utils/option.dart';

class Question {
  final int id;
  final String questionText;
  final List<Option> options; // Ganti Map<String, dynamic> dengan List<Option>
  final int tryoutQuestionId;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.tryoutQuestionId,
  });
}