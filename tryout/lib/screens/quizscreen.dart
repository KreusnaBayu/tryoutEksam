import 'package:flutter/material.dart';
import 'package:tryout/controller/quiz_controller.dart';
import 'package:tryout/widget/quiz_widget.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizController _quizController = QuizController();
  late Future<void> _fetchQuestionsFuture;

  @override
  void initState() {
    super.initState();
    _fetchQuestionsFuture = _quizController.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement report functionality
                },
                icon: Icon(Icons.report),
                label: Text('Report'),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_quizController.currentIndex}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    FutureBuilder<void>(
                      future: _fetchQuestionsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Loading question...');
                        } else if (snapshot.hasError) {
                          return Text('Error loading question: ${snapshot.error}');
                        } else {
                          return _quizController.getCurrentQuestion() != null
                              ? QuestionWidget(
                                  question: _quizController.getCurrentQuestion(),
                                )
                              : Text('No question available');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _quizController.previousQuestion();
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Previous'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement finish quiz functionality
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Finish Quiz'),
                          content: Text('Are you sure you want to finish the quiz?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implement logic for finishing the quiz
                                Navigator.of(context).pop();
                              },
                              child: Text('Finish'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.check),
                  label: Text('Finish'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _quizController.nextQuestion();
                    });
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
