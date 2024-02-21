// option.dart
class Option {
  final int id;
  final int tryoutQuestionId;
  final String inisial;
  final String jawaban;
  final bool isCorrect;
  final int nilai;

  Option({
    required this.id,
    required this.tryoutQuestionId,
    required this.inisial,
    required this.jawaban,
    required this.isCorrect,
    required this.nilai,
  });

  // Tambahkan operator '[]' untuk mengakses properti dengan indeks
  dynamic operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'tryoutQuestionId':
        return tryoutQuestionId;
      case 'inisial':
        return inisial;
      case 'jawaban':
        return jawaban;
      case 'isCorrect':
        return isCorrect;
      case 'nilai':
        return nilai;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}
