import 'package:flutter/material.dart';

class Hungry extends StatelessWidget {
  const Hungry({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'The appropriate foods to feed a baby\n\ndepend on their age and developmental\n\nHere are some general guidelines for\n\nintroducing foods to a baby:',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Breast milk or formula (0-12 months):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Breast milk or formula is the primary source\nof  nutrition for babies up to 12 months old.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Iron-fortified infant cereal\n(around 6 months):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Around six months of age, you can start introducing iron-fortified infant cereal mixed with breast milk or formula, to your baby\'s diet.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Pureed meats and proteins\n(around 7-8 months):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Around 7 to 8 months, you can introduce pureed or finely mashed meats, such as cooked chicken or turkey.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Small lumps and textures\n(around 9-12 months):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Gradually increase the texture of your baby\'s food, offering soft foods with small lumps or chunks. This helps them learn to chew and prepare for transitioning to family foods.',
          style: TextStyle(fontSize: 14, height: 1.75),
        ),
      ],
    );
  }
}
