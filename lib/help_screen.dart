import 'dart:ui';

import 'package:baby_sense/all_data.dart';
import 'package:baby_sense/belly.dart';
import 'package:baby_sense/burped.dart';
import 'package:baby_sense/hungry.dart';
import 'package:baby_sense/tired.dart';
import 'package:baby_sense/un.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HelpScreen extends StatefulWidget {
  HelpScreen({super.key, this.type = ''});
  String type;

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  var data = Get.put(AllData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type.tr,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/images/wall.png'))),
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              BackdropFilter(
                filter: ImageFilter.blur(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 40),
                margin:
                    EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 50),
                width: MediaQuery.of(context).size.width / 1.15,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20)),
                child: widget.type == 'tired'
                    ? Tired()
                    : widget.type == 'hungry'
                        ? Hungry()
                        : widget.type == 'discomfort'
                            ? Un()
                            : widget.type == 'belly_pain'
                                ? Belly()
                                : Burped(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
