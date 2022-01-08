import 'package:doglovers/component/Mystyle.dart';
import 'package:doglovers/screen/authen/Register.dart';
import 'package:doglovers/screen/authen/Recovery.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late double screenWidgth, screenhight;
  late String email, password;
  @override

  Widget build(BuildContext context) {
    screenWidgth = MediaQuery.of(context).size.width;
    screenhight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/dog.jpg'), fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade900.withOpacity(0.4),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Dog ",
                                  style: GoogleFonts.kanit(
                                      color: Colors.black, fontSize: 28)),
                              Text("Lovers",
                                  style: GoogleFonts.kanit(
                                      color: Colors.orange, fontSize: 28)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [BuildLogo()],
                          ),
                        ),
                        Container(
                          child: Column(children: <Widget>[
                            buildTextFieldEmail(),
                            buildTextFieldPassword(),
                            buildButtonLogIn(context),
                            buildForgetPasswordButton(context),
                            Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Text("Don't have an account?",
                                      style: GoogleFonts.kanit(
                                          color: Colors.white, fontSize: 16)),
                                  Text("   "),
                                  buildSignupButton(context),
                                ])),
                          ]),
                        ),
                        Text("\n"),
                        Text("Version 0.0",
                            style:
                                GoogleFonts.kanit(color: Colors.black, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildForgetPasswordButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Recovery()),
        ),
        child: Text(
          'Forgot Password?',
          style: GoogleFonts.kanit(color: Colors.red),
        ),
      ),
    );
  }

  Container buildSignupButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        ),
        child: Text(
          'Sign Up',
          style: GoogleFonts.kanit(color: Colors.yellow),
        ),
      ),
    );
  }

  Container buildButtonLogIn(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(width: 250, height: 50),
        child: InkWell(
          child: Text(
            "Login",
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
            checkAuthentication(context);
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFFA500),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

//!--------------home--------------//
  Future<Null> checkAuthentication(BuildContext context) async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
              print("signin with email password success");
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                    return HomeScreen(page: 0,);
                }),
            );
          });
    }).catchError((value) =>
        ShowDialog(context, "Wrong email or password.", 'Please Try Again.'));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
        margin: EdgeInsets.only(top: 12),
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
              hintStyle: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black38),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 50),
        margin: EdgeInsets.only(top: 12),
        child: TextField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => password = value.trim(),
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'password',
              hintStyle: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black38),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

  Container BuildLogo() {
    return Container(
      width: screenWidgth * 0.3,
      child: MyStyle().showLogo(),
    );
  }
}
