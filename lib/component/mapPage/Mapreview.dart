import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:doglovers/screen/sub/hisprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Review extends StatefulWidget {
  final String mapid;
  Review({Key? key, required this.mapid}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  late String mapidformmap,
      namemapp,
      detailmapp,
      Myurl,
      Myname,
      newcomment,
      commentid;
  final _controller = TextEditingController();
  late var now;

  @override
  void initState() {
    super.initState();
    mapidformmap = widget.mapid;
    setusernamepost();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFA500),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Background.jpg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildPost(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Review",
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        buildComment(context)
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Addreview(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildPost(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Maps')
            .where("mapid", isEqualTo: mapidformmap)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            document["name"].toString().length < 30
                            ?
                            Text(document["name"],
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.bold, fontSize: 18),)
                            :
                            Row(
                              children: [
                                Text(document["name"].toString().substring(0,30),
                                    style: GoogleFonts.kanit(
                                        fontWeight: FontWeight.bold, fontSize: 18),),
                                Text("..."
                                ,style: GoogleFonts.kanit(
                                        fontWeight: FontWeight.bold, fontSize: 18))
                              ],
                            )
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(document["detail"],
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ));
            }).toList(),
          );
        },
      ),
    );
  }

  //?------------------ดึงข้อมูลแผนที่-----------------//
  Future<void> setusernamepost() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    late String namemap, detailmap;

    await FirebaseFirestore.instance
        .collection("Maps")
        .doc(mapidformmap)
        .get()
        .then((value) async {
      namemap = value.data()!["name"];
      detailmap = value.data()!["detail"];

      setState(() {
        namemapp = namemap;
        detailmapp = detailmap;
      });
    });

    //-------------ข้อมูลuser---------------//
    await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .get()
        .then((value) async {
      Myname = value.data()!["username"];
      Myurl = value.data()!["Userurl"];
      setState(() {});
    });
  }

  //?------------------ช่องกรอก comment-----------------//
  Container Addreview() {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      padding: EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: Color(0xffffc55b),
          border: Border.all(color: Colors.black)),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกUserName';
                } else
                  return null;
              },
              controller: _controller,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "comment",
              ),
              onChanged: (value) {
                newcomment = value.trim();
              },
            ),
          ),
          Container(
            child: IconButton(
                onPressed: () {
                  //!-------------------ฟังชั่นเพิ่มลงfirebase-------------------//
                  AddCommentToFirebase();
                  _controller.clear();
                  setState(() {});
                },
                icon: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }

  //?------------------เพิ่ม comment ลง firebase-----------//
  Future<Null> AddCommentToFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String getcommentid;

    setState(() {
      now = DateTime.now();
    });

    try {
      //!-----------------เพิ่มลงfirebase-----------------//
      await FirebaseFirestore.instance
          .collection("Maps")
          .doc(mapidformmap)
          .collection("review")
          .add({
        "data": newcomment,
        "useridcomment": uid,
        "timecomment": now.toString(),
      }).then((value) {
        getcommentid = value.id;
        setState(() {
          commentid = getcommentid;
        });
      });
      await FirebaseFirestore.instance
    .collection("Maps")
    .doc(mapidformmap)
    .collection("review")
    .doc(commentid)
    .set({"CommentId":commentid}
      ,SetOptions(merge: true))
      .then((value)  {
        print('Insert comment To Firestore Success');
      });
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  //?------------------ดึงข้อมูลโพสทั้งหมด-----------------//
  Container buildComment(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                //!----------------เวลา------ตัวโชวคอมเม้น-----------------//
                .collection('Maps')
                .doc(mapidformmap)
                .collection("review")
                .orderBy("timecomment")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return Column(
                children: snapshot.data!.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffffa500).withOpacity(0.3),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where("userid",
                                          isEqualTo: document["useridcomment"])
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
                                        child: InkWell(
                                          onTap: () {
                                            //!--------------------------ไปโปรไฟลคนคอมมเม้น--------------------//
                                            if (uid != datadoc["userid"]) {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    HisProfile(
                                                  userid: datadoc["userid"],
                                                ),
                                              );
                                              Navigator.push(context, route)
                                                  .then((value) => initState());
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                    page: 4,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        datadoc["Userurl"]),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              datadoc["username"]
                                                          .toString()
                                                          .length >
                                                      15
                                                  ? Text(
                                                      datadoc["username"]
                                                          .toString()
                                                          .substring(0, 15),
                                                      style: GoogleFonts.kanit(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  : Text(
                                                      datadoc["username"],
                                                      style: GoogleFonts.kanit(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList());
                                  }),
                              document["useridcomment"] == uid
                                  ? Row(
                                      //!------------------ลบเม้น-------------------------//
                                      children: [
                                        Text(
                                          document['timecomment']
                                              .toString()
                                              .substring(0, 16),
                                          style: GoogleFonts.kanit(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            CheckDialog(document["CommentId"]);
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      document['timecomment']
                                          .toString()
                                          .substring(0, 16),
                                      style: GoogleFonts.kanit(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        document["data"].toString().length > 35
                            ? Container(
                                child: Text(
                                document["data"],
                                softWrap: true,
                                style: GoogleFonts.kanit(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ))
                            : Row(children: [
                                Text(
                                  document["data"],
                                  softWrap: true,
                                  style: GoogleFonts.kanit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )
                              ])
                      ],
                    ),
                  );
                }).toList(),
              );
            }));
  }

  Future<Null> CheckDialog(String commentid) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("ต้องการลบCommentใช่หรือไม่"),
          subtitle: Text(
            "หากถูกต้องกดยืนยัน",
            style: GoogleFonts.kanit(color: Colors.grey.shade800),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deletecomment(commentid);
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.kanit(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> deletecomment(String commentid) async {
    String? getment;
    int intment = 0;

    await FirebaseFirestore.instance
        .collection("Maps")
        .doc(mapidformmap)
        .collection("review")
        .doc(commentid)
        .delete()
        .then((value) => print("delete success"));
  }
}
