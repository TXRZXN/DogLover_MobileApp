import 'dart:ui';
import 'package:doglovers/screen/setting/Doginfo.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
//!--------------------เพิ่ม carousel_slider: ^4.0.0 ในpubspec-----------------------//

class Pug extends StatelessWidget {
  final pugpics = ['images/Dogdetail/pug1.png', 'images/Dogdetail/pug2.png'];
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
                          "Pug",
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
      itemCount: pugpics.length,
      itemBuilder: (context, index, realindex) {
        final pugpic = pugpics[index];

        return buildImage(pugpic, index);
      },
    ));
  }

  Widget buildImage(String pugpic, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.asset(
          pugpic,
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
            'ความสูงเฉลี่ย: 25-28 cm.',
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
              'น้ำหนักเฉลี่ย: 6-8 kg.',
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
        'สุนัขพันธุ์ปั๊ก หรือ หมาปั๊ก เป็นสุนัขพันธุ์ทอย (Toy) คืออยู่ในกลุ่มสุนัขพันธุ์เล็กมีลักษณะลำตัวย่น จมูกสั้น และหางขด สุนัขพันธุ์นี้มีความร่าเริง ขนมันเงาและมีหลากหลายสีและมีลำตัวเหลี่ยม ตันที่มีกล้ามเนื้อจำนวนมาก พวกมันถูกนิยามเหมือน multum in parvo หรือ น้อยแต่มาก โดยมีที่มาจากลักษณะนิสัยของสุนัขพันธุ์ปั๊กและขนาดตัวที่เล็กของมัน โดยบรรพบุรุษของมันมาจากประเทศจีนเมือง Lo-sze ซึ่งน่าจะมาจาก 2 สายพันธุ์นี้ คือ ปักกิ่ง (Pekiness) และ คิงส์ ชาวส์ สเปเนียล (King Charles spaniel) ทำให้พวกมันมีต้นกำเนิดมาจากประเทศจีน แต่ในปัจจุบันได้รับความนิยมในกลุ่มประเทศยุโรปตะวันตก โดยเฉพาะในประเทศเนเธอร์แลนด์ อังกฤษ ไอรีแลนด์ และสตอตแลนด์',
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
        'สุนัขพันธุ์ปั๊กมีความแข็งแรง ใจดี และไม่ค่อยพบว่าพวกมันมีนิสัยดุร้าย สุนัขพันธุ์นี้เหมาะกับครอบครัวที่มีเด็กอยู่ เนื่องจากลักษณะหลักๆของพันธุ์นี้ คือ รักเด็กและมีกำลังแรงพอที่จะเล่นกับเด็กอย่างเหมาะสม พวกมันมีความสงบและว่านอนสอนง่าย และพวกมันร่าเริงและเล่นกับเจ้าของตามตามอารมณ์ของเจ้าของ พวกมันสามารถเป็นสุนัขเฝ้าบ้านที่ดี พวกมันตื่นตัวอยู่ตลอดเวลาและบางครั้งก็มีความสุข ปั๊กและเด็กคือความเข้ากันได้ที่ลงตัว ลักษณะท่าทางการเล่นของเขานั้นทำให้เด็กๆยิ้มหัวเราะและสนุกไปด้วยกันได้ ปั๊กชอบเล่นกับเด็กๆ แต่มีลักษณะที่แตกต่างจากสุนัขทอยชนิดอื่นๆ คือไม่บอบบาง เด็กๆและปั้กสามารถเล่นด้วยกันได้เป็นอย่างดี แต่เพื่อความปลอดภัยก็จำเป็นสอนเด็กๆ ให้เข้าใจธรรมชาติของสัตว์เลี้ยง รวมถึงวิธีการตอบโต้ได้อย่างปลอดภัย',
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
                'กทม. เอ็นบีฟาร์ม',
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
                const url = 'https://www.facebook.com/PugNBFarm/';
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
                'Preference Pugs Kennel',
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
                const url = 'https://www.facebook.com/Preferencepugs/';
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
