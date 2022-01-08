import 'dart:ui';
import 'package:doglovers/screen/setting/Doginfo.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
//!--------------------เพิ่ม carousel_slider: ^4.0.0 ในpubspec-----------------------//

class Shzu extends StatelessWidget {
  final shzupics = ['images/Dogdetail/shzu1.png', 'images/Dogdetail/shzu2.png'];
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
                          "Shih Tzu",
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
      itemCount: shzupics.length,
      itemBuilder: (context, index, realindex) {
        final shzupic = shzupics[index];

        return buildImage(shzupic, index);
      },
    ));
  }

  Widget buildImage(String shzupic, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.asset(
          shzupic,
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
            'ความสูงเฉลี่ย: มากสุด 27 cm.',
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
              'น้ำหนักเฉลี่ย: 5-8 kg.',
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
        'สุนัขพันธุ์ชิสุ เป็นที่รู้กันว่ามีความสดใสร่าเริง มีชีวิตชีวา เป็นมิตร ชอบการผจญภัย และกระตือรือร้น เป็นสุนัขพันธุ์เล็กที่มีความใจเย็น มีความอดทน ยึดมั่น เป็นสุนัขเงียบ ไม่ชอบเห่า สามารถเข้าได้ดีกับทุกคนที่พบเจอ แต่อาจพบพฤติกรรมก้าวร้าว หรือเห่าได้บางครั้ง ถ้าพบคนแปลกหน้าบริเวณหน้าบ้าน หรือได้ยินเสียงที่สุนัขไม่ชอบ',
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
        'สุนัขพันธุ์ชิสุ ไม่มีนิสัยดุร้าย หรือก้าวร้าว ขนาดตัวของสุนัขเหมาะสมกับเด็กเล็ก ทำให้สามารถนำมาเล่นกับเด็กได้ ทำให้เด็กรู้สึกมีเพื่อน และมีความสุขได้สุนัขพันธุ์ชิสุ เป็นสุนัขชอบเดิน ชอบออกกำลังกาย แต่เนื่องจากเป็นสุนัขพันธุ์เล็กจึงไม่จำเป็นต้องออกกำลังกายมากทั้งวัน  เพียงแค่พาสุนัขให้เดินไว หรือให้วิ่งรอบสวนสาธารณะ ซึ่งการออกกำลังกายช่วยป้องกัน และคงพฤติกรรมของสุนัขไว้ หนึ่งในสิ่งที่ควรระวังมากที่สุดคือสุนัขพันธุ์ชิสุจะอุณหภูมิภายในตัวสัตว์สูงขึ้น เร็วมาก ควรสังเกตสุนัขขณะเล่นเป็นประจำ โดยเฉพาะอย่างยิ่งฤดูร้อน หากพบอาการที่ผิดปกติควรหยุดให้ได้พัก และนำเข้าที่ร่มทันที',
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
                'Baan Kibzaa Shihtzu',
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
                    'https://www.facebook.com/Baan.Kibzaa.Shihtzu.Petshop/';
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
                'ฟาร์มสุนัขประสานชิสุ',
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
                const url = 'https://www.facebook.com/prasarnshihtzu/';
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
