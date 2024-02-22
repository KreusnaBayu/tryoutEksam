// quiz_widget.dart
import 'package:flutter/material.dart';
import 'package:tryout/controller/quiz_controller.dart';
import 'package:tryout/model/question_model.dart';

class QuestionWidget extends StatefulWidget {
  final String questionText;
  final List<Answer> options;
  final QuizController quizController;

  QuestionWidget({
    required this.questionText,
    required this.options,
    required this.quizController,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Answer? current;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.questionText,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 12.0),
        // Display options using the 'options' list
        Column(
          children: widget.options.map((option) {
            return RadioListTile(
              title: Text(
                option.jawaban,
                style: TextStyle(
                  color: Colors.black,
                  // Add other style properties as needed
                ),
              ),
              value: option,
              groupValue: current,
              onChanged: (value) {
                setState(() {
                  current = option;
                  widget.quizController.handleAnswer(option);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
