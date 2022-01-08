import 'dart:ui';

import 'package:doglovers/component/mapPage/dgroom.dart';
import 'package:doglovers/component/mapPage/dpets.dart';
import 'package:doglovers/component/mapPage/dvet.dart';
import 'package:doglovers/screen/questionnaire/1one.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<String> Result = [];

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
                          "Map For Dog Service",
                          style: GoogleFonts.kanit(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: Text("เลือกประเภทสถานบริการสุนัขที่ต้องการค้นหา",
                          style: GoogleFonts.kanit(
                              fontSize: 20, color: Colors.grey.shade800))),
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dpets(
                                    radius: 20,
                                  )),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffffc55b),
                          boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                        child: Center(
                            child: Text(
                          "ร้านเพทช็อปสุนัข",
                          style: GoogleFonts.kanit(fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dgroom(
                                    radius: 20,
                                  )),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffffc55b),
                          boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                        child: Center(
                            child: Text(
                          "ร้านแต่งขนสุนัข",
                          style: GoogleFonts.kanit(fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dvet(
                                    radius: 20,
                                  )),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffffc55b),
                          boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                        child: Center(
                            child: Text(
                          "คลินิกสุนัข",
                          style: GoogleFonts.kanit(fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
