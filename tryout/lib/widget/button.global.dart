import 'package:flutter/material.dart';
import 'package:tryout/utils/global.color.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({super.key, required this.info, required Null Function() onPressed});
  final String info;//signin /signup

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('succes');
      },
      child: Container(
        alignment:  Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
            )
          ]
        ),
        child: Text(
          info,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            
          ),
        ),
      ),
    );
  }
}