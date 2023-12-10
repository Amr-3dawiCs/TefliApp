import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  GlobalKey<FormState> key = GlobalKey();
  var email = TextEditingController(), loading = false;

  sendEmail() async {
    if (!key.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(
            'Check your email inbox and follow the instructions to reset your password'),
        duration: const Duration(seconds: 5),
      ));

      Get.back();
    } catch (error) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(error.toString()),
        duration: const Duration(seconds: 5),
      ));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          children: [
            Positioned(
              top: 125,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Please enter your email address\nto reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        controller: email,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: Colors.black,
                            ),
                            hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                      SizedBox(
                        height: 75,
                      ),
                      loading
                          ? Lottie.asset('assets/lotties/loading.json',
                              height: 75)
                          : MaterialButton(
                              minWidth: 175,
                              height: 40,
                              onPressed: () {
                                sendEmail();
                              },
                              child: Text(
                                'Send email',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              color: Color(0xff5B1F4B),
                              shape: StadiumBorder(),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        minWidth: 100,
                        height: 40,
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        color: Color(0xff5B1F4B),
                        shape: StadiumBorder(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 75,
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
