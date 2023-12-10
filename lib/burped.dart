import 'package:flutter/material.dart';

class Burped extends StatelessWidget {
  const Burped({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Here\'s a summary of what to do if your baby needs to be burped:',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Hold your baby upright against your\nshoulder or on your lap, supporting their\nhead and neck.\n\n\nGently pat or rub their back in a\nrhythmic motion to encourage burping.\n\n\nTry different burping positions if your\nbaby doesn\'t burp in one position.\n\n\nBe patient and allow enough time for\nyour baby to release gas.\n\n\nBurp your baby after each feeding and\nmore frequently if they are gassy or\ncolicky.\n\n\nIf bottle-feeding, use bottles with\nventing systems to reduce the amount\nof air your baby ingests.\n\n\nPay attention to your baby\'s comfort\ncues and burp them as needed.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
