import 'package:doglovers/screen/authen/Login.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doglovers/screen/questionnaire/result2.dart';



String initRoute = '/login';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        initRoute = '/home';
        runApp(Myapp());
      } else {
        runApp(Myapp());
      }
    });
  });
}

final Map<String, WidgetBuilder> map = {
  '/login': (BuildContext context) => Login(),
  '/home': (BuildContext context) => HomeScreen(page: 0,),
  '/test':(BuildContext context) => Result2(Answer: [])
};



class Myapp extends StatelessWidget {


  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dog Lovers",
      debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: initRoute,
    );
  }



}