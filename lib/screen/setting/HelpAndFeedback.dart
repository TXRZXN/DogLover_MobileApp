import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/sub/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:google_fonts/google_fonts.dart';
class Helpnfeed extends StatefulWidget {
  Helpnfeed({Key? key}) : super(key: key);

  @override
  _HelpnfeedState createState() => _HelpnfeedState();
}

class _HelpnfeedState extends State<Helpnfeed> {
  @override
  String DropDownTopic = "โปรดระบุหัวข้อที่ต้องการแจ้ง";
  String? Datasend;
  String myemail = "";

  @override
  void initState() {
    setusername();
    super.initState();
    print(myemail);
  }

  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xffffa500),
          title: Text(
            'Help And Feedback',
            style: GoogleFonts.kanit(color: Colors.black),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/Background.jpg'), fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Help And Feedback",
                            style: GoogleFonts.kanit(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropTopic(),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffFFA500),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "เนื้อหา",
                                  style: GoogleFonts.kanit(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffFFA500).withOpacity(0.3),
                            ),
                            child: Container(
                              child: TextFormField(
                                maxLines: 4,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกเนื้อหา';
                                  } else
                                    return null;
                                },
                                keyboardType: TextInputType.multiline,
                                decoration:
                                    InputDecoration(hintText: "เนื้อหา"),
                                onChanged: (value) => Datasend = value.trim(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PostButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget DropTopic() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFFA500).withOpacity(0.5),
          border: Border.all(color: Colors.black)),
      margin: EdgeInsets.only(left: 20, right: 3),
      child: DropdownButton<String>(
        value: DropDownTopic,
        elevation: 16,
        icon: Icon(Icons.arrow_drop_down),
        style: GoogleFonts.kanit(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            DropDownTopic = newValue!;
          });
        },
        items: <String>[
          'โปรดระบุหัวข้อที่ต้องการแจ้ง',
          'แนะนำสถานบริการสุนัข',
          'แนะนำร้านค้าขายสุนัข',
          'ปัญหาทั่วไป',
          'อื่นๆ',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  InkWell PostButton(BuildContext context) {
    return InkWell(
        onTap: () {
          if (Datasend == null) {
            FailDialog();
            print("no data");
          } else if (DropDownTopic == "Select โปรดระบุหัวข้อที่ต้องการแจ้ง") {
            FailDialog();
            print("select breed");
          } else {
            CheckDialog();
          }
        },
        child: Container(
          constraints: BoxConstraints.expand(width: 250, height: 50),
          child: Text(
            "Send mail",
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              fontSize: 18,
              color: Colors.black,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  offset: Offset(-0.0, 0.0),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffFFA500),
          ),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12),
        ));
  }

  Future<Null> CheckDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("กรุณาตรวจสอบความถูกต้อง"),
          subtitle: Text(
            "หากถูกต้องกดยืนยัน",
            style: GoogleFonts.kanit(color: Colors.grey.shade800),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  //!-------------------------------------------//
                  print(myemail);
                  Sendemal();
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.kanit(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //?-------------------ถูกต้องDialog-----------------------//
  Future<Null> SuccessDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Send Success"),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //?------------------ล้มเหลวDialog-----------------------//
  Future<Null> FailDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Upload Failed"),
          subtitle: Text(
            "กรุณากรอกข้อมูลให้ครบ",
            style: GoogleFonts.kanit(color: Colors.grey.shade800),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Sendemal() async {
    String username = "dogloversend@gmail.com";
    String password = 'doglover1234';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('dogloversgetter@gmail.com')
      ..subject = '$DropDownTopic ${DateTime.now()}'
      ..text = Datasend
      ..html = "<h1>$DropDownTopic</h1>\n<h2>$Datasend</h2>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      SuccessDialog();
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  //?------------------ดึงusername+userid-----------------------//
  Future<void> setusername() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String getemail;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) async {
      getemail = value.data()!["email"];
      setState(() {
        myemail = getemail;
      });
    });
  }
}
