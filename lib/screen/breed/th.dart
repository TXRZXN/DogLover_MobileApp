import 'dart:ui';
import 'package:doglovers/screen/setting/Doginfo.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
//!--------------------เพิ่ม carousel_slider: ^4.0.0 ในpubspec-----------------------//

class ThaiRid extends StatelessWidget {
  final thpics = [
    'images/Dogdetail/th1.png',
    'images/Dogdetail/th2.png',
    'images/Dogdetail/th3.png'
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
                          "Thai Ridgeback",
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
      itemCount: thpics.length,
      itemBuilder: (context, index, realindex) {
        final thpic = thpics[index];

        return buildImage(thpic, index);
      },
    ));
  }

  Widget buildImage(String thpic, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.asset(
          thpic,
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
            'ช่วงอายุ: 10-12 ปี',
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
            'ความสูงเฉลี่ย: 20-24 cm.',
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
              'น้ำหนักเฉลี่ย: 23-34 kg.',
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
        'สุนัขธุ์ไทยหลังอานถูกนำมาเลี้ยงโดยมีจุดประสงค์ที่ต่างกัน ไม่ว่าจะเป็นสุนัขเฝ้าระวังและสุนัขแจ้งเตือนภัย, สุนัขคุ้มกัน, สุนัขสำหรับเกมส์ล่าสัตว์ หรือคอยกำจัดงูเห่าตามชายหาด ซึ่งโดยส่วนใหญ่สุนัขพันธุ์ไทยหลังอานมักจะอาศัยอยู่ทางตะวันออกของไทย โดยเฉพาะบนเกาะ เช่น เกาะดาวฟูก๊วก ซึ่งติดกับชายแทนประเทศกัมพูชาและเวียดนาม สุนัขพันธุ์ไทยหลังอาน เป็นที่รู้จักในด้านความฉลาด รักอิสระ ซื่อสัตย์ เชื่อมั่นในตัวเอง มีความกระตือรือร้น พร้อมผจญภัยได้ตลอดเวลานอกจากนี้ยังต้องการความเป็นผู้นำจากเจ้าของ เพื่อเขาจะได้เป็นผู้ตามที่ดีได้  ทำให้สุนัขสายพันธุ์นี้สามารถเป็นได้ทั้งเพื่อน และคู่หูผู้ซื่อสัตว์',
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
        'ข้อเสียของหลังอานคือ มักไม่ทนต่อการตำหนิอย่างรุนแรง เพราะจะเป็นการเพิ่มพฤติกรรมในด้านลบ จึงจำเป็นต้องได้รับการฝึกให้เข้าสังคมในตอนที่ยังเด็ก เพื่อป้องกันพฤติกรรมก้าวร้าวในในตอนโต และแม้ว่าหลังอาจมักจะไม่ค่อยเห่า แต่ก็อาจจะทำเสียงเพื่อเป็นการเรียกร้องความสนใจ หรือเรียกร้องความต้องการได้ สุนัขพันธุ์ไทยหลังอานสามารถเข้ากับผู้สูงอายุได้ดี แต่ด้วยความสุขุม เจ้าระเบียบ และตัวใหญ่ จึงอาจจะไม่เหมาะสำหรับบ้านที่มีเด็กสักเท่าไหร่ เพราะ เด็ก ๆ อาจได้รับอันตรายจากรอยขีดข่วน หรือการกระแทก ชน จากขนาดตัวของเขา',
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
                  color: Colors.white,
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
                  color: Colors.red,
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
                ' ไทยหลังอาน บ้านสุขสันต์',
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
                    'https://www.facebook.com/ไทยหลังอาน-บ้านสุขสันต์-1543823929241171/';
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
                'ไทยหลังอานเชียงราย ',
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
                const url = 'https://www.facebook.com/lovethairidgeback';
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
