import 'dart:ui';
import 'package:doglovers/screen/setting/Doginfo.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
//!--------------------เพิ่ม carousel_slider: ^4.0.0 ในpubspec-----------------------//

class Sbh extends StatelessWidget {
  final sbhpics = [
    'images/Dogdetail/sbh1.png',
    'images/Dogdetail/sbh2.png'
        'images/Dogdetail/sbh3.png'
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
                          "Siberian Husky",
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
      itemCount: sbhpics.length,
      itemBuilder: (context, index, realindex) {
        final sbhpic = sbhpics[index];

        return buildImage(sbhpic, index);
      },
    ));
  }

  Widget buildImage(String sbhpic, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.asset(
          sbhpic,
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
            'ช่วงอายุ: มากกว่า 10 ปี',
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
            'ความสูงเฉลี่ย: 51-60 cm.',
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
              'น้ำหนักเฉลี่ย: 16-27 kg.',
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
        'ภายใต้ภาพลักษณ์ที่ดูสง่างามและกระฉับกระเฉงนั้น สุนัขไซบีเรียน ฮัสกี ถือเป็นสุนัขที่ขับเคลื่อนด้วยสัญชาตญาณอีกสายพันธุ์หนึ่ง สุนัขไซบีเรียน ฮัสกี มีความฉลาด และสง่างาม แต่สาเหตุที่หลายคนมองว่าสุนัขพันธุ์นี้ฝึกได้ยาก ไม่ใช่เรื่องของไหวพริบแต่อย่างใด แต่เป็นเพราะสุนัขสายพันธุ์นี้ไม่ชอบทำตามคำสั่งเสียมากกว่า ซึ่งในทางกลับกันสุนัขไซบีเรียน ฮัสกี ชอบที่จะทำกิจกรรมที่พวกเขาสนใจเท่านั้น',
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
        'ด้วยการที่สุนัขสายพันธุ์นี้ไม่ชอบทำตามคำสั่ง เพราะฉะนั้นหากคุณต้องการฝึกสุนัขไซบีเรียน ฮัสกี คุณต้องมั่นใจว่าตัวคุณคือจ่าฝูง และต้องอาศัยความสม่ำเสมอและวินัยในการฝึก เพียงเท่านี้คุณก็สามารถฝึกให้สุนัขไซบีเรียน ฮัสกี ทำตามคำสั่งได้สำเร็จตามที่กล่าวไปข้างต้นว่าสุนัขไซบีเรียน ฮัสกี นั้นมักทำตามสัญชาตญาณของตนเอง การวิ่งไล่เหยื่อ และการหลบหนีออกจากคอกก็รวมเป็นหนึ่งในนั้น ดังนั้นหากคุณต้องการทำคอกให้สุนัขไซบีเรียน ฮัสกี คุณต้องมั่นใจก่อนว่าคอกนั้นแข็งแรงพอ โดยทั่วไปแนะนำให้ใช้รั้วไม้แข็งสูงประมาณ 6 – 8 ฟุต ฝังลงไปใต้ดินอย่างน้อย 2 ฟุต เพื่อป้องกันการขุดโพรงหนี และเมื่อสุนัขไซบีเรียน ฮัสกี ของคุณหนีออกไปได้ รับรองว่าความเสียหายที่ตามมาไม่ใช่เรื่องสนุกอย่างแน่นอน',
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
                  color: Colors.white,
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
                'ALL BEST KENNEL',
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
                const url = 'https://www.facebook.com/allbestkennel';
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
                'CS Kennel',
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
                const url = 'https://www.facebook.com/cssiberian';
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
