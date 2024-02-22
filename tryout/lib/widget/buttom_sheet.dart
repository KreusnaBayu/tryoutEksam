import 'package:flutter/material.dart';
import 'package:tryout/services/report.services.dart';
import 'package:tryout/widget/popop_gagalLapor.dart';
import 'package:tryout/widget/popop_succesLapor.dart';

class ReportBottomSheet extends StatelessWidget {
  final TextEditingController _noSoalController = TextEditingController();
  final TextEditingController _laporanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _noSoalController,
                decoration: InputDecoration(
                  hintText: 'Nomor Soal',
                  fillColor: Colors.blue[50],
                  filled: true,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _laporanController,
                decoration: InputDecoration(
                  hintText: 'Laporan',
                  fillColor: Colors.blue[50],
                  filled: true,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String tryoutQuestionId = _noSoalController.text;
                    String laporan = _laporanController.text;

                    await ApiReport.kirimLaporan(tryoutQuestionId, laporan);
                    SuccessDialog.show(context);
                  } catch (error) {
                    ErrorDialog.show(context, error.toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
