import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ColoredContainer extends StatelessWidget {
  ColoredContainer({super.key, required this.childWidgets});
  List<Widget> childWidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xffE6DBD0),
            Color(0xffE6DBD0),
            Color(0xffFCFCFC)
          ])),
      child: SafeArea(
          child: Stack(
        children: childWidgets,
      )),
    );
  }
}
