import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:doglovers/screen/sub/setting.dart';
import 'package:doglovers/screen/breed/allbreed.dart';
import 'package:google_fonts/google_fonts.dart';


class Dinfo extends StatefulWidget {
  Dinfo({Key? key}) : super(key: key);

  @override
  _DinfoState createState() => _DinfoState();
}

class _DinfoState extends State<Dinfo> {
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
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => SettingsPage(),),);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_sharp)),
                      Column(
                        children: [
                          Text(""),
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Dog Info",
                              style: GoogleFonts.kanit(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Abulld(context),
                          Pitd(context),
                          Beagled(context),
                          Bulld(context),
                          Chihd(context),
                          Chowd(context),
                          Fbulld(context),
                          Gerd(context),
                          Goldd(context),
                          Labd(context),
                          Cord(context),
                          Pomd(context),
                          Poodd(context),
                          Pugd(context),
                          Rotd(context),
                          Shibad(context),
                          Shzud(context),
                          Sbhd(context),
                          Banggd(context),
                          Thd(context)
                        ],
                      ),
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

  Widget Abulld(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AmericanBulldog()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('อเมริกันบลูด็อก', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Banggd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bangg()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ไทยบางแก้ว', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Bulld(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bull()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('บลูด็อก', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Beagled(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Beagle()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('บีเกิ้ล', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Shibad(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Shiba()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ชิบะอินุ', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Chihd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chih()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ชิวาวา', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Cord(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cor()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('พ็อมโบรค เวล์ช คอร์กี้', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Chowd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chow()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('เชา เชา', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Fbulld(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Fbull()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('เฟรนซ์บลูด็อก', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Goldd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Gold()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('โกลเดินริทรีฟเวอร์', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Gerd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ger()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('เยอรมันเชพเพิร์ด', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Labd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Lab()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('แลบราดอร์ริทรีฟเวอร์', style: GoogleFonts.kanit(color:Colors.black),)
          ],
        ),
      ),
    );
  }

  Widget Pitd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pit()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('อเมริกันพิทบูล', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Pomd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pom()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('พอเมอเรเนียน', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Poodd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pood()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('พุดเดิ้ล', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Pugd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pug()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ปั๊ก', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Rotd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Rot()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ร็อตไวเลอร์', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Sbhd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Sbh()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ไซบีเรียนฮัสกี', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Shzud(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Shzu()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ชิสุ', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget Thd(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThaiRid()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffa500).withOpacity(0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ไทยหลังอาน', style: GoogleFonts.kanit(color:Colors.black)),
          ],
        ),
      ),
    );
  }

}
