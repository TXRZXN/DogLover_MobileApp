import 'dart:math';
import 'dart:ui';

import 'package:doglovers/screen/sub/setting.dart';
import 'package:flutter/material.dart';
import 'package:doglovers/screen/breed/allbreed.dart';
import 'package:google_fonts/google_fonts.dart';
class Result2 extends StatefulWidget {
  List<String> Answer = [];
  Result2({Key? key, required this.Answer}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result2> {
  List<String> Result3 = [];
  // List<String> Result3 = [
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1",
  //   "1"
  // ];
  late String dogmin1, dogmin2;
  late Navigator urldog1, urldog2;

  List<String> AmricanBulldog = [
    "1",
    "0.5",
    "1",
    "1",
    "0",
    "0.5",
    "0",
    "0.75",
    "0.5",
    "0.25",
    "0.66",
  ];
  double intAmricanBulldog = 0;
  List<String> AmricanPitbull = [
    "0",
    "0.5",
    "0.5",
    "0.5",
    "0",
    "0.5",
    "0.66",
    "1",
    "0.5",
    "0.75",
    "1"
  ];
  double intAmricanPitbull = 0;
  List<String> Beagle2 = [
    "0",
    "0.5",
    "0.5",
    "0.5",
    "0",
    "0.5",
    "0.33",
    "1",
    "0.5",
    "0.75",
    "0.33"
  ];
  double intBeagle = 0;
  List<String> Bulldog = [
    "0.5",
    "0.5",
    "0.5",
    "0.5",
    "0",
    "0.5",
    "0.66",
    "0.5",
    "0.5",
    "0.25",
    "0.66"
  ];
  double intBulldog = 0;
  List<String> Chihuahua = [
    "0",
    "0",
    "0",
    "0.5",
    "0.25",
    "0.5",
    "0",
    "0",
    "0.5",
    "1",
    "0.33"
  ];
  double intChihuahua = 0;
  List<String> Chowchow = [
    "1",
    "0.5",
    "1",
    "0.5",
    "0.5",
    "1",
    "0",
    "0.5",
    "0",
    "0",
    "0.33"
  ];
  double intChowchow = 0;
  List<String> FrenchBulldog = [
    "0",
    "0.5",
    "0",
    "0.5",
    "0",
    "0.5",
    "1",
    "1",
    "1",
    "0",
    "0.66"
  ];
  double intFrenchBulldog = 0;
  List<String> German = [
    "1",
    "1",
    "1",
    "1",
    "0.5",
    "0",
    "0.33",
    "1",
    "0.5",
    "0.5",
    "1"
  ];
  double intGerman = 0;
  List<String> Golden = [
    "1",
    "1",
    "1",
    "1",
    "0.5",
    "0",
    "1",
    "1",
    "0",
    "0",
    "1"
  ];
  double intGolden = 0;
  List<String> Labrador = [
    "1",
    "1",
    "1",
    "1",
    "0",
    "0.5",
    "1",
    "1",
    "1",
    "0.5",
    "1"
  ];
  double intLabrador = 0;
  List<String> Corgi = [
    "0",
    "0.5",
    "0.5",
    "0.5",
    "0",
    "0",
    "0.66",
    "0.75",
    "0.5",
    "1",
    "0.66"
  ];
  double intCorgi = 0;
  List<String> Pom2 = [
    "0",
    "0",
    "0",
    "0.5",
    "0.5",
    "0",
    "0.33",
    "0.5",
    "0",
    "0.75",
    "0.33"
  ];
  double intPom = 0;
  List<String> Poodle = [
    "0",
    "0.5",
    "0",
    "0.5",
    "0.5",
    "1",
    "1",
    "1",
    "1",
    "0.75",
    "1"
  ];
  double intPoodle = 0;
  List<String> Pug2 = [
    "0",
    "0.5",
    "0",
    "0.5",
    "0",
    "0.5",
    "1",
    "1",
    "1",
    "0",
    "0.66"
  ];
  double intPug = 0;
  List<String> Rottweiler = [
    "1",
    "1",
    "1",
    "1",
    "0",
    "0.5",
    "0.33",
    "0.5",
    "0.5",
    "0",
    "1"
  ];
  double intRottweiler = 0;
  List<String> Shiba2 = [
    "0",
    "0.5",
    "0.5",
    "0.5",
    "0",
    "0",
    "0.33",
    "0.5",
    "0",
    "0.5",
    "0"
  ];
  double intShiba = 0;
  List<String> ShihTzu = [
    "0",
    "0.5",
    "0",
    "0.5",
    "1",
    "1",
    "0.33",
    "1",
    "0",
    "0.5",
    "0.66"
  ];
  double intShihTzu = 0;
  List<String> Siberian = [
    "0.5",
    "1",
    "1",
    "1",
    "0",
    "0",
    "1",
    "1",
    "1",
    "1",
    "0.33"
  ];
  double intSiberian = 0;
  List<String> Bankkeaw = [
    "0.5",
    "1",
    "1",
    "1",
    "0.5",
    "0.5",
    "0",
    "0.75",
    "0.5",
    "0.5",
    "0.66"
  ];
  double intBankkeaw = 0;
  List<String> Ridge = [
    "0.5",
    "0.5",
    "1",
    "1",
    "0",
    "0.5",
    "0.33",
    "0.5",
    "0.5",
    "0.5",
    "0.66"
  ];
  double intRidge = 0;
  
  List<String> allbreed = [
    'อเมริกันบลูด็อก',
    'อเมริกันพิทบูล',
    'บีเกิ้ล',
    'บลูด็อก',
    'ชิวาวา',
    'เชา เชา ',
    'เฟรนซ์บลูด็อก',
    'เยอรมันเชพเพิร์ด',
    'โกลเดินริทรีฟเวอร์',
    'แลบราดอร์ริทรีฟเวอร์',
    'พ็อมโบรค เวล์ช คอร์กี้',
    'พอเมอเรเนียน',
    'พุดเดิ้ล',
    'ปั๊ก',
    'ร็อตไวเลอร์',
    'ชิบะอินุ',
    'ชิสุ',
    'ไซบีเรียนฮัสกี',
    'ไทยบางแก้ว',
    'ไทยหลังอาน', 
  ];
  List<double> point = [];


  @override
  void initState() {
    super.initState();
    Result3 = widget.Answer;
    serch();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 362,
                        child: Text(
                          "คำตอบของคุณคือ",
                          style: GoogleFonts.kanit(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            dogmin1 == "อเมริกันบลูด็อก"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AmericanBulldog()),
                                  )
                                : dogmin1 == "อเมริกันพิทบูล"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Pit()),
                                      )
                                    : dogmin1 == "บีเกิ้ล"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Beagle()),
                                          )
                                        : dogmin1 == "บลูด็อก"
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Bull()),
                                              )
                                            : dogmin1 == "บลูด็อก"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Chih()),
                                                  )
                                                : dogmin1 == "เชา เชา"
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Chow()),
                                                      )
                                                    : dogmin1 == "เฟรนซ์บลูด็อก"
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Fbull()),
                                                          )
                                                        : dogmin1 == "เยอรมันเชพเพิร์ด"
                                                            ? Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Ger()),
                                                              )
                                                            : dogmin1 ==
                                                                    "โกลเดินริทรีฟเวอร์"
                                                                ? Navigator
                                                                    .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Gold()),
                                                                  )
                                                                : dogmin1 ==
                                                                        "แลบราดอร์ริทรีฟเวอร์"
                                                                    ? Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Lab()),
                                                                      )
                                                                    : dogmin1 ==
                                                                            "พ็อมโบรค เวล์ช คอร์กี้" //
                                                                        ? Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => Cor()),
                                                                          )
                                                                        : dogmin1 ==
                                                                                "พอเมอเรเนียน"
                                                                            ? Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(builder: (context) => Pom()),
                                                                              )
                                                                            : dogmin1 == "พุดเดิ้ล"
                                                                                ? Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (context) => Pood()),
                                                                                  )
                                                                                : dogmin1 == "ปั๊ก"
                                                                                    ? Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (context) => Pug()),
                                                                                      )
                                                                                    : dogmin1 == "ร็อตไวเลอร์"
                                                                                        ? Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(builder: (context) => Rot()),
                                                                                          )
                                                                                        : dogmin1 == "ชิบะอินุ"
                                                                                            ? Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(builder: (context) => Shiba()),
                                                                                              )
                                                                                            : dogmin1 == "ชิสุ"
                                                                                                ? Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(builder: (context) => Shzu()),
                                                                                                  )
                                                                                                : dogmin1 == "ไซบีเรียนฮัสกี"
                                                                                                    ? Navigator.push(
                                                                                                        context,
                                                                                                        MaterialPageRoute(builder: (context) => Sbh()),
                                                                                                      )
                                                                                                    : dogmin1 == "ไทยบางแก้ว"
                                                                                                        ? Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(builder: (context) => Bangg()),
                                                                                                          )
                                                                                                        : Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(builder: (context) => ThaiRid()),
                                                                                                          );
                          },
                          child: Container(
                            constraints:
                                BoxConstraints.expand(width: 220, height: 120),
                            child: Center(
                              child: Text(
                                dogmin1,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.kanit(
                                    fontSize: 25,
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
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dogmin2 == "อเมริกันบลูด็อก"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AmericanBulldog()),
                                  )
                                : dogmin2 == "อเมริกันพิทบูล"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Pit()),
                                      )
                                    : dogmin2 == "บีเกิ้ล"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Beagle()),
                                          )
                                        : dogmin2 == "บลูด็อก"
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Bull()),
                                              )
                                            : dogmin2 == "ชิวาวา"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Chih()),
                                                  )
                                                : dogmin2 == "เชา เชา"
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Chow()),
                                                      )
                                                    : dogmin2 == "เฟรนซ์บลูด็อก"
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Fbull()),
                                                          )
                                                        : dogmin2 == "เยอรมันเชพเพิร์ด"
                                                            ? Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Ger()),
                                                              )
                                                            : dogmin2 ==
                                                                    "โกลเดินริทรีฟเวอร์"
                                                                ? Navigator
                                                                    .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Gold()),
                                                                  )
                                                                : dogmin2 ==
                                                                        "แลบราดอร์ริทรีฟเวอร์"
                                                                    ? Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Lab()),
                                                                      )
                                                                    : dogmin2 ==
                                                                            "พ็อมโบรค เวล์ช คอร์กี้" //
                                                                        ? Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => Cor()),
                                                                          )
                                                                        : dogmin2 ==
                                                                                "พอเมอเรเนียน"
                                                                            ? Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(builder: (context) => Pom()),
                                                                              )
                                                                            : dogmin2 == "พุดเดิ้ล"
                                                                                ? Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (context) => Pood()),
                                                                                  )
                                                                                : dogmin2 == "ปั๊ก"
                                                                                    ? Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (context) => Pug()),
                                                                                      )
                                                                                    : dogmin2 == "ร็อตไวเลอร์"
                                                                                        ? Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(builder: (context) => Rot()),
                                                                                          )
                                                                                        : dogmin2 == "ชิบะอินุ"
                                                                                            ? Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(builder: (context) => Shiba()),
                                                                                              )
                                                                                            : dogmin2 == "ชิสุ"
                                                                                                ? Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(builder: (context) => Shzu()),
                                                                                                  )
                                                                                                : dogmin2 == "ไซบีเรียนฮัสกี"
                                                                                                    ? Navigator.push(
                                                                                                        context,
                                                                                                        MaterialPageRoute(builder: (context) => Sbh()),
                                                                                                      )
                                                                                                    : dogmin2 == "ไทยบางแก้ว"
                                                                                                        ? Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(builder: (context) => Bangg()),
                                                                                                          )
                                                                                                        : Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(builder: (context) => ThaiRid()),
                                                                                                          );
                          },
                          child: Container(
                            constraints:
                                BoxConstraints.expand(width: 220, height: 120),
                            child: Center(
                              child: Text(
                                dogmin2,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.kanit(
                                    fontSize: 25,
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
                          ),
                        ),
                        
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()),
                            );
                          },
                          child: Container(
                            constraints:
                                BoxConstraints.expand(width: 220, height: 120),
                            child: Center(
                              child: Text(
                                "จบบททดสอบ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.kanit(
                                    fontSize: 25,
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
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> serch() async {
    double min1 = 100, min2 = 100;
    String Smin1 = "", Smin2 = "";

    for(int i=0;i<11;i++){
      intAmricanBulldog += pow(double.parse(AmricanBulldog[i])-double.parse(Result3[i]), 2);
      intAmricanPitbull += pow(double.parse(AmricanPitbull[i])-double.parse(Result3[i]), 2);
      intBeagle += pow(double.parse(Beagle2[i])-double.parse(Result3[i]), 2);
      intBulldog += pow(double.parse(Bulldog[i])-double.parse(Result3[i]), 2);
      intChihuahua += pow(double.parse(Chihuahua[i])-double.parse(Result3[i]), 2);
      intChowchow += pow(double.parse(Chowchow[i])-double.parse(Result3[i]), 2);
      intFrenchBulldog += pow(double.parse(FrenchBulldog[i])-double.parse(Result3[i]), 2);
      intGerman += pow(double.parse(German[i])-double.parse(Result3[i]), 2);
      intGolden += pow(double.parse(Golden[i])-double.parse(Result3[i]), 2);
      intLabrador += pow(double.parse(Labrador[i])-double.parse(Result3[i]), 2);
      intCorgi += pow(double.parse(Corgi[i])-double.parse(Result3[i]), 2);
      intPom += pow(double.parse(Pom2[i])-double.parse(Result3[i]), 2);
      intPoodle += pow(double.parse(Poodle[i])-double.parse(Result3[i]), 2);
      intPug += pow(double.parse(Pug2[i])-double.parse(Result3[i]), 2);
      intRottweiler += pow(double.parse(Rottweiler[i])-double.parse(Result3[i]), 2);
      intShiba += pow(double.parse(Shiba2[i])-double.parse(Result3[i]), 2);
      intShihTzu += pow(double.parse(ShihTzu[i])-double.parse(Result3[i]), 2);
      intSiberian += pow(double.parse(Siberian[i])-double.parse(Result3[i]), 2);
      intBankkeaw += pow(double.parse(Bankkeaw[i])-double.parse(Result3[i]), 2);
      intRidge += pow(double.parse(Ridge[i])-double.parse(Result3[i]), 2);
    }

    intAmricanBulldog = sqrt(intAmricanBulldog);
    intAmricanPitbull = sqrt(intAmricanPitbull);
    intBeagle = sqrt(intBeagle);
    intBulldog = sqrt(intBulldog);
    intChihuahua = sqrt(intChihuahua); 
    intChowchow = sqrt(intChowchow);
    intFrenchBulldog = sqrt(intFrenchBulldog);
    intGerman = sqrt(intGerman);
    intGolden = sqrt(intGolden);
    intLabrador = sqrt(intLabrador);
    intCorgi = sqrt(intCorgi);
    intPom = sqrt(intPom);
    intPoodle = sqrt(intPoodle);
    intPug = sqrt(intPug);
    intRottweiler = sqrt(intRottweiler);
    intShiba = sqrt(intShiba);
    intShihTzu = sqrt(intShihTzu);
    intSiberian = sqrt(intSiberian);
    intBankkeaw = sqrt(intBankkeaw);
    intRidge = sqrt(intRidge);


    point.add(intAmricanBulldog);
    point.add(intAmricanPitbull);
    point.add(intBeagle);
    point.add(intBulldog);
    point.add(intChihuahua);
    point.add(intChowchow);
    point.add(intFrenchBulldog);
    point.add(intGerman);
    point.add(intGolden);
    point.add(intLabrador);
    point.add(intCorgi);
    point.add(intPom);
    point.add(intPoodle);
    point.add(intPug);
    point.add(intRottweiler);
    point.add(intShiba);
    point.add(intShihTzu);
    point.add(intSiberian);
    point.add(intBankkeaw);
    point.add(intRidge);

    for (int i = 0; i < 20; i=i+1) {
      if (point[i] < min1) {   
        setState(() {
          min1 = point[i];
          Smin1 = allbreed[i];
        });
      }
    }
    for (int i = 0; i < 20; i=i+1) {
      if (point[i] >= min1) {
        if (point[i] <= min2) {
          if(allbreed[i]!=Smin1){
             min2 = point[i];
            Smin2 = allbreed[i];
          }
          // min2 = point[i];
          // Smin2 = allbreed[i];
        }
      }
    }

    print('allbreed = $allbreed');
    print('Result = $Result3');
    print('point = $point');
    print('min1 = $min1');
    print('smin1 = $Smin1');
    print('min2 = $min2');
    print('smin2 = $Smin2');


    setState(() {
      dogmin1 = Smin1;
      dogmin2 = Smin2;
    });
  }
}
