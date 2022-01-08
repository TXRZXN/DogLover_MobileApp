import 'dart:ui';
import 'package:doglovers/screen/setting/Doginfo.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

//!--------------------เพิ่ม carousel_slider: ^4.0.0 ในpubspec-----------------------//

class Beagle extends StatelessWidget {
  final beaglepics = [
    'images/Dogdetail/begle1.png',
    'images/Dogdetail/begle2.png',
    'images/Dogdetail/begle3.png'
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
          image: DecorationImage(
              image: AssetImage('images/Background.jpg'), fit: BoxFit.fill),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new_sharp),),
                          Text("")  
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Beagle",
                          style: GoogleFonts.kanit(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [slider(), Showbar(), Showtext, Showshop],
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

  Center slider() {
    return Center(
        child: CarouselSlider.builder(
      options: CarouselOptions(
        height: 425,
        viewportFraction: 1,
        reverse: true,
      ),
      itemCount: beaglepics.length,
      itemBuilder: (context, index, realindex) {
        final beaglepic = beaglepics[index];

        return buildImage(beaglepic, index);
      },
    ));
  }

  Widget buildImage(String beaglepic, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.asset(
          beaglepic,
          fit: BoxFit.fill,
        ),
      );

  Widget Showtext = Container(
     margin: EdgeInsets.only(left: 5, right: 5,bottom:5),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
      
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffffc55b) ,
        border: Border.all(color: Colors.black)),
    child: Column(children: [
      Row(children: [
        Container(
          margin: EdgeInsets.only(bottom: 6),
          child: Text(
            'ช่วงอายุ: 13 ปี',
            style: GoogleFonts.kanit(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ]),
      Row(children: [
        Container(
          margin: EdgeInsets.only(bottom: 6),
          child: Text(
            'ความสูงเฉลี่ย: 33-40 cm.',
            style: GoogleFonts.kanit(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ]),
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              'น้ำหนักเฉลี่ย: 9-11 kg.',
              style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(bottom: 6),
        child: Text(
          'บุคลิก',
          style: GoogleFonts.kanit(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        'ถ้าให้นึกถึงน้องหมาขนสั้น ขนาดลำตัวกะทัดรัด แสนฉลาด ที่พกความร่าเริงสนุกสนานมาด้วยแบบเต็มกระเป๋า มีจมูกที่ดมกลิ่นได้เก่งไม่เป็นรองใคร และมีความน่ารักแบบล้น ๆ จนหลาย ๆ คนเห็นแล้วก็อยากจะเข้าไปกอดบีเกิ้ลเป็นหนึ่งในสุนัขที่อยู่ในกลุ่มนี้แน่นอน บีเกิ้ลมีลักษณะนิสัยที่อ่อนโยน และมักสร้างเสียงหัวเราะให้กับเจ้าของด้วยความน่ารักและตลกขี้เล่น แต่ในความน่ารักนั้นก็มีความซนพลังล้นซ่อนอยู่ด้วยเหมือนกัน',
        style: GoogleFonts.kanit(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 6),
        child: Text(
          'คำแนะนำในการเลี้ยง',
          style: GoogleFonts.kanit(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        'แม้ว่าบีเกิ้ลจะมีขนาดตัวที่กำลังกะทัดรัด และเป็นเพื่อนกับเด็ก ๆ เป็นอย่างดีก็ตาม ต้องขอบอกว่าบีเกิ้ลมีมุมดื้อเล็ก ๆ รั้นหน่อย ๆ กับพลังแสนจะล้นเหลือ บีเกิ้ลก็ไม่ต่างจากสุนัขสายพันธุ์อื่น ๆ ที่ต้องการได้รับความเอาใจใส่ดูแลจากเจ้าของ ชอบการเข้าสังคมพบปะผู้คนหลากหลาย ชอบออกไปเที่ยว ได้มองเห็น ได้ยินเสียงใหม่ ๆ และตอบรับกับทุกประสบการณ์ที่เจ้าของมอบให้',
        style: GoogleFonts.kanit(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        width: 10,
      ),
    ]),
  );

  Container Showbar() {
    return Container(
       margin: EdgeInsets.only(left: 5, right: 5,bottom:5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
       
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffffc55b) ,
          border: Border.all(color: Colors.black)),
      child: Column(children: [
        Row(children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              "ความเป็นมิตร",
              style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            width: 22,
          ),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
        ]),
        Row(children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              "การฝึกฝน",
              style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
        ]),
        Row(children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              "การเฝ้ายาม",
              style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            width: 37,
          ),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
        ]),
        Row(children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              "ความถี่การเห่า",
              style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
          Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
              height: 25,
              width: 30),
        ]),
      ]),
    );
  }

  Widget Showshop = Container(
     margin: EdgeInsets.only(left: 5, right: 5,bottom:5),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration( boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
     
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffffc55b) ,
        border: Border.all(color: Colors.black)),
    child: Column(
      children: [
        Row(children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              'ฟาร์มขายสุนัข',
              style: GoogleFonts.kanit(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ]),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'พี่เสือฟาร์ม',
                style: GoogleFonts.kanit(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(
                Icons.public,
              ),
              onPressed: () async {
                const url = 'https://www.facebook.com/tigerbeaglefarmpage/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'ฟาร์มสุนัขบีเกิล พระราม2',
                style: GoogleFonts.kanit(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(
                Icons.public,
              ),
              onPressed: () async {
                const url =
                    'https://www.facebook.com/ฟาร์มสุนัขบีเกิล-พระราม2-686719668156532/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    ),
  );
}
