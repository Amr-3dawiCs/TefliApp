import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:baby_sense/all_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var id = TextEditingController(),
      name = TextEditingController(),
      baby = TextEditingController(),
      email = TextEditingController(),
      provider = 'password',
      firebase = FirebaseAuth.instance,
      pic = '',
      loading = false,
      data = Get.put(AllData());

  updateData() async {
    setState(() {
      loading = true;
    });
    var url2 = Uri.parse(
        'https://baby-sense-4dc2d-default-rtdb.europe-west1.firebasedatabase.app/users/${data.userData['uid']}.json');

    if (email.text != data.userData['email']) {
      await firebase.currentUser!.updateEmail(email.text);
      data.userData.update('email', (value) => email.text);
    }

    data.userData.update('ID', (value) => id.text);
    data.userData.update('name', (value) => name.text);
    data.userData.update('babyName', (value) => baby.text);
    data.userData.update('pic', (value) => pic);

    setState(() {});

    try {
      final response = await http.patch(url2, body: json.encode(data.userData));

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', json.encode(data.userData));
        Get.back();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Text('Error'),
          duration: const Duration(seconds: 5),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text('Error'),
        duration: const Duration(seconds: 5),
      ));
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  getData() {
    provider = firebase.currentUser!.providerData.first.providerId;
    name.text = data.userData['name'];
    pic = data.userData['pic'];
    email.text = data.userData['email'];
    baby.text = data.userData['babyName'];
    id.text = data.userData['ID'];
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'edit'.tr,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              if (!loading) Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Color(0xffE6DBD0),
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/wall.png'))),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    child: Stack(children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.35,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 120, right: 20, left: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.35,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ])),
              ),
              Positioned(
                left: 25,
                right: 25,
                top: MediaQuery.of(context).size.height / 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'profile',
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();

                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image == null) return;

                          final ref = await FirebaseStorage.instance
                              .ref()
                              .child('profile')
                              .child(data.userData['uid']);
                          final result = await ref.putFile(File(image.path));
                          pic = await result.ref.getDownloadURL();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: pic.isEmpty
                              ? null
                              : CachedNetworkImageProvider(pic),
                          backgroundColor: Colors.grey.shade400,
                          child: pic.isNotEmpty
                              ? null
                              : Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 55,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pleaseID'.tr;
                        }
                        return null;
                      },
                      controller: id,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'cameraID'.tr,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pleaseName'.tr;
                        }
                        return null;
                      },
                      controller: name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'parent'.tr,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pleaseBaby'.tr;
                        }
                        return null;
                      },
                      controller: baby,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'baby'.tr,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (provider == 'password')
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'pleaseEmail'.tr;
                          }
                          return null;
                        },
                        controller: email,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'email'.tr,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: loading
                          ? Lottie.asset('assets/lotties/loading.json',
                              height: 75)
                          : MaterialButton(
                              minWidth: 175,
                              height: 50,
                              onPressed: () {
                                updateData();
                              },
                              child: Text(
                                'update'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              color: Color(0xff5B1F4B),
                              shape: StadiumBorder(),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
