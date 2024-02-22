import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryout/model/question_model.dart';
import 'package:tryout/services/service.soal.dart';

class QuizController extends ChangeNotifier {
  late SharedPreferences prefs;
  final ApiSoal api = ApiSoal();
  int currentQuestionId = 1;
  int totalScore = 0;
  List<Map<String, dynamic>> selectedAnswers = [];
  

  Map<int, String?> selectedTryQuestions = {};

  static Answer? currentAnswer;

  Answer? _selectedAnswer;
  Answer? get selectedAnswer => _selectedAnswer;

  set selectedAnswer(Answer? value) {
    _selectedAnswer = value;
    prefs.setInt('selectedAnswerId', value?.id ?? -1);
    notifyListeners();
  }

  Future<Question> getQuestionById(int questionId) async {
    return await api.fetchQuestion(questionId);
  }

  Future<Question> getCurrentQuestion() async {
    return await api.fetchQuestion(currentQuestionId);
  }

  Future<Question> getNextQuestion() async {
    int nextQuestionId = currentQuestionId + 1;
    return await getQuestionById(nextQuestionId);
  }

  Future<Question> getPreviousQuestion() async {
    int previousQuestionId = currentQuestionId - 1;
    return await getQuestionById(previousQuestionId);
  }

  void setCurrentQuestionId(int questionId) {
    currentQuestionId = questionId;
  }


void setCurrentAnswer(Answer answer) {
    currentAnswer = answer;
    notifyListeners();
  }
  // Fetch answer by ID from the API

  void handleAnswer(Answer selectedAnswer) {
    // cek kapakah ID sudah pernah dipiplih
    bool idExists = selectedAnswers.any((answerData) => answerData['id'] == selectedAnswer.id);
    
    
    if (!idExists) {
      Map<String, dynamic> answerData = {
        'id': selectedAnswer.id,
        'isCorrect': selectedAnswer.isCorrect,
        'nilai': selectedAnswer.nilai,
      };

      selectedAnswers.add(answerData);
    }
  }

  int calculateTotalScore() {
    int totalScore = 0;
    for (var answerData in selectedAnswers) {
      if (answerData['isCorrect'] == true) {
        totalScore += (answerData['nilai'] as int);
      }
    }
    return totalScore;
  }


}
