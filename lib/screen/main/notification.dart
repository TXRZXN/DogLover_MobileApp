import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/sub/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}



class _NotificationScreenState extends State<NotificationScreen> {

  FirebaseStorage storage = FirebaseStorage.instance;
  late double screenwidth, screenhigh;
  String?  action, time, postid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "การแจ้งเตือน",
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
                          ShowOwnNoti(context),
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

  //?------------------โชวการแจ้งเตือน-----------------------//
  Container ShowOwnNoti(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Notification")
            .doc(uid)
            .collection("action")
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Please Wating');
          }
          return Column(
            children: snapshot.data!.docs.map((document) {
              return InkWell(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Detailscreen(
                      PostId: document["PostId"],
                      PostUserId: uid,
                    ),
                  );
                  Navigator.push(context, route).then((value) => initState());
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xffffc55b)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(""),
                          Text(document["time"].toString().substring(0,19))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.post_add),
                          const SizedBox(width: 10,),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("userid",
                                      isEqualTo: document["useridaction"])
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot>
                                      testsnapshot) {
                                if (testsnapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (testsnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                                return Column(
                                    children: testsnapshot.data!.docs
                                        .map((datadoc) {
                                  return Container(
                                      child: datadoc["username"]
                                                  .toString()
                                                  .length <
                                              15
                                          ? Text('${datadoc["username"]}')
                                          : Text('${datadoc["username"]}'
                                              .toString()
                                              .substring(0, 8)));
                                }).toList());
                              }),

                          Text(' ได้${document["action"]}บนโพสคุณ',
                            style: GoogleFonts.kanit(
                              fontSize: 15,
                            )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

}
