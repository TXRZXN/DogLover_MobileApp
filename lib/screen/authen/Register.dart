import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:doglovers/screen/authen/Login.dart';
import 'package:doglovers/component/Mystyle.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String?  NormalUrl , NormalPic;
  late double screenWidgth, screenhight;
  late String username, email, password, repassword;
  final _formKey = GlobalKey<FormState>();
  FirebaseStorage storage = FirebaseStorage.instance;
  late String useridvalue;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    screenWidgth = MediaQuery.of(context).size.width;
    screenhight = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
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
                                  children: <Widget>[
                                    buildRegister(context),
                                    
                                  ],
                                ),
                              ),
                            ])))))))));
  }

  Container buildRegister(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
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
                    Text("Register ",
                        style: GoogleFonts.kanit(color: Colors.orange, fontSize: 28)),
                    buildTextFieldUsername(),
                    buildTextFieldEmail(),
                    buildTextFieldPassword(),
                    buildTextFieldRePassword(),
                    buildButtonSignUp(context),
                    Text("\n"),
                    buildAlreadyHaveButton(context),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //--------------กล่องใส่ userName----------------------//
  Container buildTextFieldUsername() {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 12),
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอก Username';
              } else if (value.length < 2) {
                return 'Usernameต้องมีมากกว่า 1 ตัวอักษร';
              } else if (value.length > 20) {
                return 'Usernameต้องมีน้อยกว่า 20 ตัวอักษร';
              }else
                return null;
            },
            keyboardType: TextInputType.text,
            onChanged: (value) => username = value.trim(),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  CupertinoIcons.doc_plaintext,
                  color: Colors.black,
                ),
                hintText: 'Username',
                hintStyle: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black38),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                )),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

  //---------------กล่องใส่ Mail--------------------------//
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 12),
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกอีเมล';
              } else if (value.isValidEmail() == false) {
                return 'กรุณากรอกอีเมลให้ถูกต้อง';
              } else
                return null;
            },
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
                )),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

  //---------------กล่องใส่ Password----------------------//
  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 12),
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกรหัสผ่าน';
              } else if (value.length < 6) {
                return 'กรุณากรอกรหัสผ่านให้ตรงตามเงื่อนไข';
              } else
                return null;
            },
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => password = value.trim(),
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: 'Password',
                hintStyle: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black38),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                )),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

  //---------------กล่องใส่ Re Password-------------------//
  Container buildTextFieldRePassword() {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 12),
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกรหัสผ่านซ้ำอีกครั้ง';
              } else if (value != password) {
                return 'กรุณากรอกรหัสผ่านให้ตรงกัน';
              } else
                return null;
            },
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => repassword = value.trim(),
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  CupertinoIcons.arrow_counterclockwise,
                  color: Colors.black,
                ),
                hintText: 'Re-Password',
                hintStyle: GoogleFonts.kanit(fontSize: 16.0, color: Colors.black38),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                )),
            style: GoogleFonts.kanit(fontSize: 16, color: Colors.black)));
  }

  //---------------ปุ่ม Register ------------------------//
  Container buildButtonSignUp(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(width: 250, height: 50),
        child: InkWell(
          child: Text(
            "Register",
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
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
                  createAccountAndInsertInformation();
            }
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFFA500),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Future<Null> createAccountAndInsertInformation() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) async {
        await value.user!.updateDisplayName(username).then((value2) async {
          String uid = value.user!.uid;
          print('Update Profile Success and uid = $uid');
          
          UserModel model = UserModel(
            username: username,
            email: email,
            userid: uid,
          );
          Map<String, dynamic> data = model.toMap();

          NormalUrl = await storage.ref('UserProfile/profile.png').getDownloadURL();
          setState(() {
            NormalPic = NormalUrl.toString();
          });

          await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(data)
          .then((value) {
            print('Insert Value To Firestore Success');
          },);

          await FirebaseFirestore.instance.collection('users')
          .doc(uid)
          .set({
            "Userurl":NormalPic,
            "first":true,
            "NotiMent":true,
            "NotiLike":true,
          }
          ,SetOptions(merge: true))
          .then((value)  {
            print('Insert pic To Firestore Success');
          });

        },);

        SuccessDialog();
      },).catchError(
        (onError) => ShowDialog(context, onError.code, onError.message));
    },);
  }

  //--------------go to login-------------------------//
  Container buildAlreadyHaveButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        ),
        child: Text(
          'Already Have an account?',
          style: GoogleFonts.kanit(color: Colors.red),
        ),
      ),
    );
  }

  Container BuildLogo() {
    return Container(
      width: screenWidgth * 0.3,
      child: MyStyle().showLogo(),
    );
  }

  Future<Null> SuccessDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Registered Success"),
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
                    MaterialPageRoute(builder: (context) => Login()),
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

}
