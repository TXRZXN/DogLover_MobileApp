import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/sub/detail.dart';
import 'package:doglovers/screen/sub/hisprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

//!-------------------Search--------------------//

class _FeedScreenState extends State<FeedPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userurl;
  String breed="0",topic="0";
  String DropDownBreedValues = "เลือกพันธุ์สุนัข";
  String DropDownTopicValues = "เลือกหัวข้อ";
  bool MentNoti=false,LikeNoti=false;

  @override
  void initState() {
    super.initState();
    CheckTokenForMeassage();
    
  }

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
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Home",
                            style: GoogleFonts.kanit(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "Dog Lovers",
                            style: GoogleFonts.kanit(
                                color: Colors.grey.shade800, fontSize: 20),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          ChooseBoth(context);
                        }, 
                        icon: Icon(
                          Icons.filter_alt,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  breed=="0"&&topic=="0" 
                    ? 
                      buildPost(context)
                    :
                      breed!="0"&&topic=="0" 
                      ?
                        buildSerchBreed(context)
                      :
                        breed=="0"&&topic!="0" 
                        ?
                          buildSerchTopic(context)
                        :
                          buildSerchBoth(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //top------------------POST------------------//
  Container buildPost(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .orderBy("PostTime", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return SizedBox(height: MediaQuery.of(context).size.height/1.35 ,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [

                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                            .collection('users')
                            .where("userid",isEqualTo: document["PostUserId"])
                            .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> testsnapshot) {
                            if (testsnapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (testsnapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return Column(
                              children: testsnapshot.data!.docs.map((datadoc) {
                                return Container( 
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  child: InkWell(
                                    onTap: (){
                                        if (uid!=datadoc["userid"]) {
                                        MaterialPageRoute route = MaterialPageRoute(
                                          builder: (context) => HisProfile(userid: datadoc["userid"],),
                                        );
                                        Navigator.push(context, route).then((value) => initState());
                                      }
                                      else{
                                        Navigator.push(context,MaterialPageRoute(
                                          builder: (context) => HomeScreen(page: 4,),),);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(datadoc["Userurl"]),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Text(datadoc["username"]  ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                          ],
                                        ),
                                        Container(
                                          child:Text(document["PostTime"].toString().substring(0,19) ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()
                            );
                          }
                        ),

                      Container(
                        width: 330,
                        height: 230,
                        margin: EdgeInsets.only(right: 20, left: 20,bottom: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(document["PostImageUrl"]),
                              fit: BoxFit.fill,
                              ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                           boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                      ),
                      
                      InkWell(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Detailscreen(PostId: document["PostID"],PostUserId: document["PostUserId"],),
                          );
                          Navigator.push(context, route).then((value) => initState());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfff3f3f3),
                            border: Border.all(color: Colors.black),
                            boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                          padding: EdgeInsets.only(left: 8, right: 8, top: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  document['PostTitle'].length >= 18
                                      ? Row(
                                          children: [
                                            Text(
                                              document['PostTitle']
                                                  .substring(0, 18),
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "...",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          document['PostTitle'],
                                          style: GoogleFonts.kanit(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        document['PostBreed'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        document['PostLike'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        //edit----------ปุ่มกดไลค์-----------//
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite),
                                        color: Colors.grey.shade700,
                                      ),
                                      Text(
                                        document['PostComment'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(Icons.message_outlined,
                                          color: Colors.grey.shade700),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Container buildSerchBreed(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .where("PostBreed",isEqualTo:breed )
            .orderBy("PostTime", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return SizedBox(height: MediaQuery.of(context).size.height/1.35 ,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [

                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                            .collection('users')
                            .where("userid",isEqualTo: document["PostUserId"])
                            .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> testsnapshot) {
                            if (testsnapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (testsnapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return Column(
                              children: testsnapshot.data!.docs.map((datadoc) {
                                return Container(
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  child: InkWell(
                                    onTap: (){
                                        if (uid!=datadoc["userid"]) {
                                        MaterialPageRoute route = MaterialPageRoute(
                                          builder: (context) => HisProfile(userid: datadoc["userid"],),
                                        );
                                        Navigator.push(context, route).then((value) => initState());
                                      }
                                      else{
                                        Navigator.push(context,MaterialPageRoute(
                                          builder: (context) => HomeScreen(page: 4,),),);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(datadoc["Userurl"]),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Text(datadoc["username"]  ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                          ],
                                        ),
                                        Container(
                                          child:Text(document["PostTime"].toString().substring(0,19) ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()
                            );
                          }
                        ),

                     Container(
                        width: 330,
                        height: 230,
                        margin: EdgeInsets.only(right: 20, left: 20,bottom: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(document["PostImageUrl"]),
                              fit: BoxFit.fill,
                              ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                           boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Detailscreen(PostId: document["PostID"],PostUserId: document["PostUserId"],),
                          );
                          Navigator.push(context, route).then((value) => initState());
                        },
                        child: Container(
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfff3f3f3),
                            border: Border.all(color: Colors.black),
                            boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                          padding: EdgeInsets.only(left: 8, right: 8, top: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  document['PostTitle'].length >= 20
                                      ? Row(
                                          children: [
                                            Text(
                                              document['PostTitle']
                                                  .substring(0, 20),
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "...",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          document['PostTitle'],
                                          style: GoogleFonts.kanit(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        document['PostBreed'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        document['PostLike'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        //edit----------ปุ่มกดไลค์-----------//
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite),
                                        color: Colors.grey.shade700,
                                      ),
                                      Text(
                                        document['PostComment'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(Icons.message_outlined,
                                          color: Colors.grey.shade700),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Container buildSerchTopic(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .where("PostTopic",isEqualTo:topic )
            .orderBy("PostTime",descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return SizedBox(height: MediaQuery.of(context).size.height/1.35 ,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                            .collection('users')
                            .where("userid",isEqualTo: document["PostUserId"])
                            .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> testsnapshot) {
                            if (testsnapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (testsnapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return Column(
                              children: testsnapshot.data!.docs.map((datadoc) {
                                return Container(
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  child: InkWell(
                                    onTap: (){
                                        if (uid!=datadoc["userid"]) {
                                        MaterialPageRoute route = MaterialPageRoute(
                                          builder: (context) => HisProfile(userid: datadoc["userid"],),
                                        );
                                        Navigator.push(context, route).then((value) => initState());
                                      }
                                      else{
                                        Navigator.push(context,MaterialPageRoute(
                                          builder: (context) => HomeScreen(page: 4,),),);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(datadoc["Userurl"]),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Text(datadoc["username"]  ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                          ],
                                        ),
                                        Container(
                                          child:Text(document["PostTime"].toString().substring(0,19) ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()
                            );
                          }
                        ),

                       Container(
                        width: 330,
                        height: 230,
                        margin: EdgeInsets.only(right: 20, left: 20,bottom: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(document["PostImageUrl"]),
                              fit: BoxFit.fill,
                              ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                           boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Detailscreen(PostId: document["PostID"],PostUserId: document["PostUserId"],),
                          );
                          Navigator.push(context, route).then((value) => initState());
                        },
                        child: Container(
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfff3f3f3),
                            border: Border.all(color: Colors.black),
                            boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                          
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                          padding: EdgeInsets.only(left: 8, right: 8, top: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  document['PostTitle'].length >= 20
                                      ? Row(
                                          children: [
                                            Text(
                                              document['PostTitle']
                                                  .substring(0, 20),
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "...",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          document['PostTitle'],
                                          style: GoogleFonts.kanit(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        document['PostBreed'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        document['PostLike'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        //edit----------ปุ่มกดไลค์-----------//
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite),
                                        color: Colors.grey.shade700,
                                      ),
                                      Text(
                                        document['PostComment'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(Icons.message_outlined,
                                          color: Colors.grey.shade700),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Container buildSerchBoth(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .orderBy("PostTime",descending: true)
            .where("PostTopic",isEqualTo:topic )
            .where("PostBreed",isEqualTo: breed)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return SizedBox(height: MediaQuery.of(context).size.height/1.35 ,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                            .collection('users')
                            .where("userid",isEqualTo: document["PostUserId"])
                            .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> testsnapshot) {
                            if (testsnapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (testsnapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return Column(
                              children: testsnapshot.data!.docs.map((datadoc) {
                                return Container(
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  child: InkWell(
                                    onTap: (){
                                        if (uid!=datadoc["userid"]) {
                                        MaterialPageRoute route = MaterialPageRoute(
                                          builder: (context) => HisProfile(userid: datadoc["userid"],),
                                        );
                                        Navigator.push(context, route).then((value) => initState());
                                      }
                                      else{
                                        Navigator.push(context,MaterialPageRoute(
                                          builder: (context) => HomeScreen(page: 4,),),);
                                      }
                                    },
                                   child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(datadoc["Userurl"]),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Text(datadoc["username"]  ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                          ],
                                        ),
                                        Container(
                                          child:Text(document["PostTime"].toString().substring(0,19) ,style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w700),),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()
                            );
                          }
                        ),

                       Container(
                        width: 330,
                        height: 230,
                        margin: EdgeInsets.only(right: 20, left: 20,bottom: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(document["PostImageUrl"]),
                              fit: BoxFit.fill,
                              ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                           boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Detailscreen(PostId: document["PostID"],PostUserId: document["PostUserId"],),
                          );
                          Navigator.push(context, route).then((value) => initState());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfff3f3f3),
                            border: Border.all(color: Colors.black),
                            boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                          padding: EdgeInsets.only(left: 8, right: 8, top: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  document['PostTitle'].length >= 20
                                      ? Row(
                                          children: [
                                            Text(
                                              document['PostTitle']
                                                  .substring(0, 20),
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "...",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          document['PostTitle'],
                                          style: GoogleFonts.kanit(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        document['PostBreed'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        document['PostLike'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        //edit----------ปุ่มกดไลค์-----------//
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite),
                                        color: Colors.grey.shade700,
                                      ),
                                      Text(
                                        document['PostComment'],
                                        style: GoogleFonts.kanit(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(Icons.message_outlined,
                                          color: Colors.grey.shade700),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  //?------------------add Token-----------------------//
  Future<Null> CheckTokenForMeassage() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    try{
      String? token = await FirebaseMessaging.instance.getToken();
      print('mytoken---------------->$token');
    
      if(uid!=null){
        await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({"Token":token}
        ,SetOptions(merge: true))
        .then((value)  {
          print('Insert Token To Firestore Success');
        });
      }
    }catch(e){
      print(e);
    }
  }

  //top-------------------Dialog---------------------//
  Future ChooseBoth(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffffa500).withOpacity(0.2),
          title:  ListTile(
            leading: Image.asset('images/Logo.png'),
            title: Text("Filter"),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  
                  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffFFA500).withOpacity(0.7),
                    border: Border.all(color: Colors.black)),
                  child: new DropdownButton<String>(
                    value: DropDownBreedValues,
                      icon: Icon(Icons.arrow_drop_down),
                    style: GoogleFonts.kanit(color: Colors.black),
                    items: <String>[
                      'เลือกพันธุ์สุนัข',
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
                      'ไทยหลังอาน'
                      'อื่นๆ', 
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                     onChanged: (String? newValue) {
                      setState(() {
                        DropDownBreedValues = newValue!;
                      });
                    },
                    
                  ),
                ),
                  const SizedBox(height: 10,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffFFA500).withOpacity(0.7),
                      border: Border.all(color: Colors.black)),
                    child: new DropdownButton<String>(
                      value: DropDownTopicValues,
                        icon: Icon(Icons.arrow_drop_down),
                      style: GoogleFonts.kanit(color: Colors.black),
                      items: <String>[
                        'เลือกหัวข้อ',
                        'หาบ้าน',
                        'ปัญหาสุขภาพสุนัข',
                        'ปัญหาการเลี้ยงดู',
                        'อื่นๆ',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          DropDownTopicValues = newValue!;
                        });
                      },
                      
                    ),
                  ),
                
                ]   
              );
            },
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              setState(() {
                topic=DropDownTopicValues;
                breed=DropDownBreedValues;
                if(topic=="เลือกหัวข้อ"){
                  topic='0';
                }
                if(breed=="เลือกพันธุ์สุนัข"){
                  breed='0';
                }
                print('topic==$topic');
                print('breed==$breed');
                
              });
            }, child: Text("ok",style: GoogleFonts.kanit(fontSize: 16,color: Colors.black),)),
            
            TextButton(onPressed: (){
              Navigator.pop(context);
              setState(() {
                topic="0";
                breed="0";
                DropDownBreedValues = "เลือกพันธุ์สุนัข";
                DropDownTopicValues = "เลือกหัวข้อ";
              });
            }, child: Text("Clear",style: GoogleFonts.kanit(fontSize: 16,color: Colors.red),)),
          ],
        );
      },
    );
  }


}

