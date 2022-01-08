import 'dart:ui';
import 'package:doglovers/screen/questionnaire/9nine.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
class eight extends StatefulWidget {
  List<String> result;
  eight({Key? key,required this.result}) : super(key: key);

  @override
  _eightState createState() => _eightState();
}

class _eightState extends State<eight> {
  late List<String> result;

  @override
  void initState() {
    // TODO: implement initState
    result=widget.result;
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            result.removeLast();
            Navigator.pop(context,);
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffffa500),
      ),
      body: Container(
        decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
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
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 362,
                      child: Text(
                        "8) คุณอยากให้สุนัขของคุณเป็นมิตรกับเด็กระดับไหน",
                        style: GoogleFonts.kanit(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LinearPercentIndicator(
                    width: 360,
                    lineHeight: 10,
                    percent: 0.7272,
                    progressColor: Color(0xffffa500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                result.add("0");
                              });
                              print(result);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => nine(result: result)),
                              );
                            },
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  width: 170, height: 170),
                              child: Center(
                                child: Text(
                                  "น้อย",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFA500) ,
                              ),
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(12),
                            )),
                        InkWell(
                            onTap: () {
                                setState(() {
                                result.add("0.5");
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => nine(result: result)),
                              );
                            },
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  width: 170, height: 170),
                              child: Center(
                                child: Text(
                                  "กลาง",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFA500) ,
                              ),
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(12),
                            )),
                      ],
                    ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                result.add("0.75");
                              });
                              print(result);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => nine(result: result)),
                              );
                            },
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  width: 170, height: 170),
                              child: Center(
                                child: Text(
                                  "มาก",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFA500) ,
                              ),
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(12),
                            )),
                        InkWell(
                            onTap: () {
                                setState(() {
                                result.add("1");
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => nine(result: result)),
                              );
                            },
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  width: 170, height: 170),
                              child: Center(
                                child: Text(
                                  "มากที่สุด",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFA500) ,
                              ),
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(12),
                            )),
                      ],
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