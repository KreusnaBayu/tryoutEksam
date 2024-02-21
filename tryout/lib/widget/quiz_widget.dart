// quiz_widget.dart
import 'package:flutter/material.dart';
import 'package:tryout/utils/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  QuestionWidget({required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: TextStyle(fontSize: 16.0),
        ),
        // Menampilkan opsi dari question.options
        for (var option in question.options)
          ListTile(
            title: Text(option.jawaban),
            // Menggunakan properti isCorrect untuk menentukan tindakan atau penanganan yang sesuai
            // Misalnya, memberikan warna berbeda untuk opsi yang benar atau salah
            // Sesuaikan logika sesuai kebutuhan
            tileColor: option.isCorrect ? Colors.green : null,
            onTap: () {
              // Logika yang ingin Anda lakukan ketika pengguna memilih opsi ini
              // Contoh: menampilkan pesan bahwa jawaban benar atau salah
              if (option.isCorrect) {
                print('Jawaban benar!');
              } else {
                print('Jawaban salah.');
              }
            },
          ),
      ],
    );
  }
}
