import 'package:flutter/material.dart';
import 'dart:ui';

String ptEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String ptPhone = r'(^(?:[+0]9)?[0-9]{9,12}$)';


class MyStyle{
  Color darkColor = Color(0xff2F80ED);
  Color primaryColor = Color(0xff1e88e5);
  Color lightColor = Color(0xff7ab4ff);

  Widget showLogo()=>  Image(
    image: AssetImage('images/Logo.png'),
  );
  
}

  Future<Null> ShowDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
    backgroundColor: Colors.grey.shade200,
      title: ListTile(
        leading: MyStyle().showLogo(),
        title: Column(
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xffFFA500),
                  fontWeight: FontWeight.w400,
                )),
            Divider(
              color: Colors.black,
              height: 40,
            )
          ],
        ),
        subtitle: Text(message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            )),
      ),
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffFFA500),
                  fontWeight: FontWeight.w400,
                ))),
      ],
    ),
  );
}

  extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(ptEmail).hasMatch(this);
  }

  bool isValidPhoneNumber() {
    return RegExp(ptPhone).hasMatch(this);
  }
}