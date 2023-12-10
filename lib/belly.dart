import 'package:flutter/material.dart';

class Belly extends StatelessWidget {
  const Belly({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'it\'s essential to handle the situation with\ncare and seek medical attention if needed.\nHere are some recommendations on what\nto do if your baby has a belly ache:',
            style: TextStyle(fontSize: 16, height: 2),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Check for Common Causes:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Look for signs of common causes of belly\npain in babies, such as gas.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Bicycle Legs:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Place your baby on their back and gently\nmove their legs in a bicycle motion.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Warm Bath:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'A warm bath can help relax your baby and\nmay provide some relief from belly discomfort.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
