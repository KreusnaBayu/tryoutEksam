import 'package:flutter/material.dart';
import 'package:tryout/utils/global.color.dart';

class ButtonGlobal extends StatelessWidget {
  ButtonGlobal({super.key, required this.info, required this.onPressed,});
  final String info;//signin /signup
  final VoidCallback onPressed;
  


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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