import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/sub/detail.dart';
import 'package:doglovers/screen/sub/showdog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HisProfile extends StatefulWidget {
  final String userid;
  HisProfile({Key? key,required this.userid}) : super(key: key);

  @override
  _HisProfileState createState() => _HisProfileState();
}

class _HisProfileState extends State<HisProfile> {

  late String userid;

  @override
  void initState() { 
    super.initState();
    userid=widget.userid;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Background.jpg'), fit: BoxFit.fill),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SafeArea(
            child: Container(
              //margin: EdgeInsets.only(left: 15, right: 15),
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
                          "Profile",
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
                        children: [
                          buildHerpic(context),
                          const SizedBox(height: 20,),
                          Mydog(),
                          const SizedBox(height: 10,),
                          buildOwndog(context),
                          const SizedBox(height: 20,),
                          hisActivity(),
                          const SizedBox(height: 10,),
                          buildhispost(context),
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

  //?------------------โชวรูปโปรไฟล-----------------------//
  Container buildHerpic(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("userid", isEqualTo: userid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Please Waiting');
          }
           return Row(
              children: snapshot.data!.docs.map((document) {
                return Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(document["Userurl"]),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(document["username"],style:GoogleFonts.kanit(color:Colors.black,fontSize: 20,)),
                  ],

                );
              }).toList(),
          );
        },
      ),
    );
  }

  //?------------------เพิ่มหมา-----------------------//
  Row Mydog() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "   หมา",
          style: GoogleFonts.kanit(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text("")
      ],
    );
  }

  //?------------------โชวหมา-----------------------//
  Container buildOwndog(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userid)
            .collection("Mydog")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
           return Column(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => ShowMyDog(dogId: document["dogid"],Userid: userid,),
                          );
                          Navigator.push(context, route).then((value) => initState());
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(document["Dogpic"]),
                              fit: BoxFit.fill,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      document['Dogname'].length>=10 
                      ? 
                        Row(
                          children: [
                            Text(
                              document['Dogname'].substring(0,10),
                              style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                             "...",
                              style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            
                          ],
                        )
                      :
                        Text(
                          document['Dogname'],
                          style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      Text(
                        document['Breed'],
                        style: GoogleFonts.kanit(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                      Text(""),
                    ],
                  ),
                );
              }).toList(),
          );
        },
      ),
    );
  }

  //?------------------ดูประวัติโพส-----------------------//
  Row hisActivity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "   ประวัติโพส",
          style: GoogleFonts.kanit(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text("")
      ],
    );
  }

  //?------------------โชวโพสเก่า-----------------------//
  Container buildhispost(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .where("PostUserId", isEqualTo: userid)
            //.orderBy("PostTime", descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Please Wating');
          }
           return Column(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Detailscreen(PostId: document['PostID'],PostUserId:document['PostUserId'] ,),
                          );
                          Navigator.push(context, route).then((value) => initState());
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(document['PostImageUrl']),
                                  fit: BoxFit.fill),
                              border: Border.all(color: Colors.white, width: 2)),
                        ),
                      ),
                      Column(
                        children: [
                          document['PostTitle'].length>=12
                            ? Row(
                              children: [
                                Text(
                                  document['PostTitle'].substring(0,12),
                                  style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                  Text("...",style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w500),),
                              ],
                            )
                            :
                              Text(
                                document['PostTitle'],
                                style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                          Text(""),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                document['PostLike'],
                                style: GoogleFonts.kanit(color: Colors.grey.shade800),
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.grey.shade800,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                document['PostComment'],
                                style: GoogleFonts.kanit(color: Colors.grey.shade800),
                              ),
                              Icon(
                                Icons.message_outlined,
                                color: Colors.grey.shade800,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                document['PostTopic'],
                                style: GoogleFonts.kanit(color: Colors.grey.shade800),
                              )
                            ],
                          )
                        ],
                      ),
                      Text("")
                    ],
                  ),
                );
              }).toList(),
          );
        },
      ),
    );
  }


}