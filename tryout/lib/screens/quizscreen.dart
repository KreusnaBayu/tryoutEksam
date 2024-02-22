// lib/screens/quizscreen.dart
import 'package:flutter/material.dart';
import 'package:tryout/controller/quiz_controller.dart';
import 'package:tryout/model/question_model.dart';
import 'package:tryout/screens/score.screen.dart';
import 'package:tryout/utils/global.color.dart';
import 'package:tryout/widget/buttom_sheet.dart';
import 'package:tryout/widget/quiz_widget.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<Question> futureQuestion;
  final QuizController controller = QuizController();
  
  Answer? get option => null;

  @override
  void initState() {
    super.initState();
    futureQuestion = controller.getCurrentQuestion();
  
  }

  void _showReportBottomSheet() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReportBottomSheet();
      },
    );
  }

  void _finishQuiz() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Finish Quiz',
            style: TextStyle(color:  Colors.black),
          ),
          content: Text(
            'Are you sure you want to finish the quiz?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Finish the quiz and display the total score
                int totalScore = controller.calculateTotalScore();
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(totalScore: totalScore, controller: controller)));
              },
              child: Text(
                'Finish',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  onPressed: _showReportBottomSheet,
                  icon: Icon(Icons.report, color: Colors.red),
                  label: Text('Report', style: TextStyle(color: Colors.red)),
                ),
              ),
              SizedBox(height: 16.0),
              // Tambahkan LinearProgressIndicator di sini
              LinearProgressIndicator(
                value: controller.currentQuestionId / 5, // Sesuaikan dengan jumlah total pertanyaan
                color: GlobalColors.mainColor,
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FutureBuilder<Question>(
                    future: futureQuestion,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        print(snapshot.stackTrace);
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return Text('No data available');
                      }

                      return QuestionWidget(
                        questionText: snapshot.data!.soal,
                        options: snapshot.data!.options,
                        quizController: controller,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                Question previousQuestion = await controller.getPreviousQuestion();
                setState(() {
                  controller.setCurrentQuestionId(previousQuestion.id!);
                  futureQuestion = controller.getCurrentQuestion();
                  QuizController.currentAnswer = option;
                });
              },
              icon: Icon(Icons.arrow_back, color: GlobalColors.mainColor),
              label: Text('', style: TextStyle(color: GlobalColors.mainColor)),
              style: ElevatedButton.styleFrom(
                primary: controller.currentQuestionId == 1 ? Colors.grey : null,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _finishQuiz,
              icon: Icon(Icons.check, color: GlobalColors.mainColor),
              label: Text('Finish', style: TextStyle(color: GlobalColors.mainColor)),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Question nextQuestion = await controller.getNextQuestion();
                setState(() {
                  controller.setCurrentQuestionId(nextQuestion.id!);
                  futureQuestion = controller.getCurrentQuestion();
                });
              },
              icon: Icon(Icons.arrow_forward, color: GlobalColors.mainColor),
              label: Text('', style: TextStyle(color: GlobalColors.mainColor)),
              style: ElevatedButton.styleFrom(
                primary: controller.currentQuestionId == 5 ? Colors.grey : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
