import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:doglovers/screen/authen/Login.dart';
import 'package:doglovers/component/Mystyle.dart';
import 'package:google_fonts/google_fonts.dart';

class Recovery extends StatefulWidget {
  Recovery({Key? key}) : super(key: key);
  @override
  _RecoveryState createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  late String email;
  late double screenWidgth, screenhight;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    screenWidgth = MediaQuery.of(context).size.width;
    screenhight = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,color: Colors.black,
                  ),
                ),
                elevation: 0.0,
                backgroundColor: Color(0xffFFA500)),
            body: Center(
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/dog.jpg'),
                            fit: BoxFit.cover)),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey.shade400.withOpacity(0.4),
                            child: SingleChildScrollView(
                                child: Center(
                                  child: Column(children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BuildLogo(),
                                    Text("Dog ",
                                        style: GoogleFonts.kanit(
                                            color: Colors.black, fontSize: 28)),
                                    Text("Lovers",
                                        style: GoogleFonts.kanit(
                                            color: Colors.black, fontSize: 28)),
                                    ],
                                ),
                              ),

                              Container(
                                child: Column(
                                  children: <Widget>[buildRecovery(context)],
                                ),
                              ),
                            ])))))))));
  }

  Container buildRecovery(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              children: [
                //  Text('\n'),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(children: <Widget>[
                     Text("Recovery ",
                        style: GoogleFonts.kanit(color: Colors.orange, fontSize: 28)),
                    buildTextFieldEmail(),
                    buildButtonRecovery(context)
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//----------------ใส่ Mail----------------//
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.transparent, border: Border.all(color: Colors.black)),
        child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value.trim(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Email',
              hintStyle: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black),
            ),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

//---------------ปุ่ม ส่ง-------------------//
  Container buildButtonRecovery(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(width: 250, height: 50),
        child: InkWell(
          child: Text(
            "Recovery",
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(fontSize: 18, color: Colors.black, shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 16.0,
                offset: Offset(-0.0, 0.0),
              ),
            ]),
          ),
          onTap: () {
            sendEmail(context);
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFFA500),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  //!---------------------firebase-------------------//
  // TODO-------------- อธิบาย----------------------//
  Future<Null> sendEmail(BuildContext context) async {
    await Firebase.initializeApp().then((value) async {
      final auth = FirebaseAuth.instance;
      auth
          .sendPasswordResetEmail(email: email)
          .then((value) => ShowDialog(
              context, "send email success", "please check your inbox."))
          .catchError((value) => ShowDialog(context, "Recovery Failed.",
              "Don't found this email, please try again."));
    }).catchError((value) => ShowDialog(context, "Recovery Failed.",
        "Don't found this email, please try again."));
  }

  Container BuildLogo() {
    return Container(
      width: screenWidgth * 0.3,
      child: MyStyle().showLogo(),
    );
  }
}
