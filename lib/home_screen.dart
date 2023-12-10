import 'dart:convert';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'all_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebViewController? controller;

  var h = 0.0, loading = true, humi = 0.0, temp = 0.0;
  var _userData = Get.put(AllData());

  ss(c) async {
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });

    if (c) {
      try {
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAAYGtuYi8:APA91bGRwLPuE9co-YXsb1d15mh3iRogY6Rx3Pb8ujR2YE70Q72zLQY7yMvPH3OlaCj-5TVuCwJTx74yWDFB6Nu5XnX3jT4qX2vyLNKnZVIUzI4o2ihPVjgH4nEHVci1rsGVLYaEh0U0'
            },
            body: jsonEncode(<String, dynamic>{
              "notification": <String, dynamic>{
                "android_channel_id": "high_importance_channel",
                "title": 'Ahmad ',
                "body": ' feels discomfort',
                "type": 'type',
                "sound": "default",
                "priority": "high"
              },
              'data': <String, dynamic>{
                'type': 'type',
                'id1': 'id1',
                'id2': 'id2',
              },
              "to":
                  'cFvdcXWKSDWIC7m4ZRAA69:APA91bEXmwvfiT9mNQjJuxOakeZk3NmBA-1WDrG8k7N47TlT0kD-6wAlBl_89WFs1GkIVqt1nS1KbBhCapQOcgYA3BpY9HGhKvjfXyuQcHeMggNcoAuD2Ulcakz1mAVIBgtprF4IJtIw'
            }));
      } catch (e) {
        print(e);
      }
    }
  }

  load() async {
    getData();
  }

  getData() async {
    var url2 = Uri.parse(
        'https://baby-sense-4dc2d-default-rtdb.europe-west1.firebasedatabase.app/users/${_userData.userData['uid']}.json');
    var respone = await http.get(url2);

    setState(() {
      humi = double.parse(jsonDecode(respone.body)['humi'].toString());
      temp = double.parse(jsonDecode(respone.body)['temp'].toString());
    });
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getData();
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              color: Color(0xffE6DBD0),
              child: Mjpeg(
                loading: (context) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: double.infinity,
                      width: double.infinity,
                    )),
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
                isLive: true,
                error: (context, error, stack) {
                  return Center(
                      child: Lottie.asset('assets/lotties/empty.json',
                          height: 100));
                },
                stream: 'http://10.7.1.32',
              ),
            ),
            Get.locale.toString() == 'ar'
                ? AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    right: h,
                    bottom: 150,
                    child: Container(
                      height: 90,
                      width: 140,
                      padding: EdgeInsets.only(left: 1, right: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffF6F3F3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          getData();
                          if (details.delta.dx > 0) {
                            setState(() {
                              h = 0;
                            });
                          }

                          if (details.delta.dx < 0) {
                            setState(() {
                              h = -80;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: h == 0
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                    if (h == 0)
                                      SizedBox(
                                        width: 5,
                                      ),
                                    if (h == 0)
                                      Text(
                                        '${temp}°C',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.water_drop,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                  if (h == 0)
                                    SizedBox(
                                      width: 5,
                                    ),
                                  if (h == 0)
                                    Text(
                                      '${humi}%',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                ]),
                              ],
                            ),
                            if (h == 0)
                              SizedBox(
                                width: 5,
                              ),
                            InkWell(
                                onTap: () {
                                  getData();
                                  setState(() {
                                    h = h == 0 ? -80 : 0;
                                  });
                                },
                                child: Icon(h != 0
                                    ? Icons.arrow_back_ios_sharp
                                    : Icons.arrow_forward_ios_sharp)),
                          ],
                        ),
                      ),
                    ),
                  )
                : AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    left: h,
                    bottom: 150,
                    child: Container(
                      height: 90,
                      width: 140,
                      padding: EdgeInsets.only(left: 1, right: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffF6F3F3),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          getData();
                          if (details.delta.dx > 0) {
                            setState(() {
                              h = 0;
                            });
                          }

                          if (details.delta.dx < 0) {
                            setState(() {
                              h = -80;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: h == 0
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                    if (h == 0)
                                      SizedBox(
                                        width: 5,
                                      ),
                                    if (h == 0)
                                      Text(
                                        '${temp}°C',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.water_drop,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                  if (h == 0)
                                    SizedBox(
                                      width: 5,
                                    ),
                                  if (h == 0)
                                    Text(
                                      '${humi}%',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                ]),
                              ],
                            ),
                            if (h == 0)
                              SizedBox(
                                width: 5,
                              ),
                            InkWell(
                                onTap: () {
                                  getData();
                                  setState(() {
                                    h = h == 0 ? -80 : 0;
                                  });
                                },
                                child: Icon(h != 0
                                    ? Icons.arrow_back_ios_sharp
                                    : Icons.arrow_forward_ios_sharp)),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
