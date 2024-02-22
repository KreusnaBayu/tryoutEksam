


class Answer {
  final int id;
  final String inisial;
  final String jawaban;
  final bool isCorrect;
  final int nilai;

  Answer({
    required this.id,
    required this.inisial,
    required this.jawaban,
    required this.isCorrect,
    required this.nilai,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    
    return Answer(
      id: int.parse(json['id'].toString()),
      inisial: json['inisial'],
      jawaban: json['jawaban'],
      isCorrect: json['iscorrect'] == '1',
      nilai: int.parse(json['nilai'].toString()),
    );
  }

  get tryQuestionId => null;

}


class Question {
  final int id;
  final String noSoal;
  final String soal;
  final List<Answer> options;

  Question({required this.id, required this.noSoal, required this.soal, required this.options});

factory Question.fromJson(Map<String, dynamic> json) {
  var optionsList = json['tryout_question_option'] as List;
  List<Answer> options = optionsList.map((option) => Answer.fromJson(option)).toList();

  return Question(
    id: int.parse(json['id'].toString()), // Ensure 'id' is treated as an int
    noSoal: json['no_soal'],
    soal: json['soal'],
    options: options,
  );
}



}
