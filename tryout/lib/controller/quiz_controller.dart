// quiz_controller.dart
import 'package:tryout/services/service.soal.dart';
import 'package:tryout/utils/option.dart';
import 'package:tryout/utils/question.dart';

class QuizController {
  int _currentIndex = 1; // Ubah indeks awal menjadi 0
  List<Question> _questions = [];

  int get currentIndex => _currentIndex;

  Question getCurrentQuestion() {
    if (_currentIndex >= 0 && _currentIndex < _questions.length) {
      return _questions[_currentIndex];
    } else {
      return Question(id: 0, questionText: '', options: [], tryoutQuestionId: 0);
    }
  }

Future<void> fetchQuestions() async {
  try {
    final List<Map<String, dynamic>> questionsData = await ApiSoal.fetchQuestions();

    if (questionsData.isNotEmpty) {
      for (var data in questionsData) {
        if (data.containsKey('soal') && data.containsKey('tryout_question_option')) {
          final List<Map<String, dynamic>> options =
              List<Map<String, dynamic>>.from(data['tryout_question_option']);

          final int tryoutQuestionId = int.parse(data['tryout_question_id']);
          final int questionId = int.parse(data['id']); // Tambahkan baris ini

          _questions.add(Question(
            id: questionId, // Ubah ini
            questionText: data['soal'],
            options: options.map((option) {
              return Option(
                id: option['id'],
                tryoutQuestionId: option['tryout_question_id'],
                inisial: option['inisial'],
                jawaban: option['jawaban'],
                isCorrect: option['iscorrect'] == '1',
                nilai: int.parse(option['nilai']),
              );
            }).toList(),
            tryoutQuestionId: tryoutQuestionId,
          ));
        } else {
          print('Error: Invalid data format in API response');
          throw Exception('Failed to load question: Invalid data format');
        }
      }
    } else {
      print('Error: No questions available');
      throw Exception('Failed to load questions: No questions available');
    }
  } catch (error) {
    print('Error fetching questions: $error');
    throw Exception('Failed to load questions: $error');
  }
}

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
  }
}
