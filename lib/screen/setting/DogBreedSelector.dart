import 'dart:ui';

import 'package:doglovers/screen/questionnaire/1one.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DbsScreen extends StatefulWidget {
  DbsScreen({Key? key}) : super(key: key);

  @override
  _DbsScreenState createState() => _DbsScreenState();
}

class _DbsScreenState extends State<DbsScreen> {

  List<String> Result=[];


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Background.jpg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Dog Breed Selectors",
                          style: GoogleFonts.kanit(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  Center(child: Text("ทำแบบทดสอบเพื่อค้นหาสุนัขที่เหมาะกับสภาพแวดล้อมของคุณที่สุด",style: GoogleFonts.kanit(fontSize: 20,color:Colors.grey.shade800))),
                  const SizedBox(height: 230,),
                  Center(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => One()
                          ),
                        );
                      },
                      child: Container(
                        width: 160,height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffFFA500).withOpacity(0.6),
                        ),
                        child: Center(child: Text("เริ่มทำแบบทดสอบ",style: GoogleFonts.kanit(fontSize: 20),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
