import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/PostModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'detailpage.dart';


class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

//!-------------------Search--------------------//
//!-------------------แดงแวบนึง--------------------//


class _FeedScreenState extends State<FeedScreen> {
 
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  List<PostModel> Postmodels = [];
  String? userurl;

  @override
  void initState() {
      super.initState();
      ReadAllData();
  }

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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "Dog Lovers",
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 20),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {}, //edit--------Serch---------//
                        icon: Icon(
                          Icons.filter_alt,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  ForeachPost()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //top------------------POST------------------//
  //?-----------------ดึงข้อมูลจากFireStore-----------------//
  Future<Null> ReadAllData() async {
    await Firebase.initializeApp().then((value) => null);
    print("initializeApp Success");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Posts")
        .orderBy("PostTime" ,descending:true)
        .snapshots()
        .listen((event) {
      for (var snapshots in event.docs) {
        Map<String, dynamic> map = snapshots.data();
        PostModel model = PostModel.fromMap(map);
        setState(() {
          Postmodels.add(model);
        });
      }
    });
  }

  //?-----------------โชวทุกอย่าง-----------------//
  Widget ShowListView(int index) {
    Loaduser(index);
    return Column(
      children: <Widget>[
        UserPost(index),
        ShowImage(index),
        ShowText(index),
      ],
    );
  }

  //?-----------------โชวรูปจากFireStore-----------------//
  Widget ShowImage(int index) {
    return Container(
      width: 330,
      height: 230,
      margin: EdgeInsets.only( right: 20, left: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(Postmodels[index].PostImageUrl),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  //?-----------------โชวข้อมูลทั้งหมดจากFireStore-----------------//
  Widget ShowText(int index) {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => DetailPage(models: Postmodels[index],),
        );
        Navigator.push(context, route).then((value) => initState());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          border: Border.all(color: Colors.black),
        ),
        margin: EdgeInsets.only(left: 20, right: 20, top: 5),
        padding: EdgeInsets.only(left: 8, right: 8, top: 12),
        child: Column(
          children: [ShowTitle(index), ShowTitle2(index)],
        ),
      ),
    );
  }

  //?-----------------โชวข้อมูล1จากFireStore-----------------//
  Row ShowTitle(int index) {
    return Row(
      children: [
        Postmodels[index].PostTitle.length>=20 
          ? Row(
            children: [
              Text(
                  Postmodels[index].PostTitle.substring(0,20),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text("...",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            ],
          )
          :
            Text(
              Postmodels[index].PostTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
      ],
    );
  }

  //?-----------------โชวข้อมูล2จากFireStore-----------------//
  Row ShowTitle2(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              Postmodels[index].PostBreed,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              Postmodels[index].PostLike,
              style: TextStyle(
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
              Postmodels[index].PostComment,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500),
            ),
            Icon(Icons.message_outlined, color: Colors.grey.shade700),
          ],
        )
      ],
    );
  }

  //?-----------------ไล่โชวข้อมูลจนครบ-----------------//
  Expanded ForeachPost() {
    return Expanded(
      child: ListView.builder(
        itemCount: Postmodels.length,
        itemBuilder: (context, index) {

          return ShowListView(index);
        }
      )    
    );
  }

  //?-----------------username+รูป-----------------//
  Widget UserPost(int index){
    //setusername(index);
    return Container(
      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 3,right: 5),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(userurl!),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              //Text(Postmodels[index].Username,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
            ],
          ),
          Text(Postmodels[index].PostTime.substring(5, 10),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
        ],
      ),
    );
  }

  //?-----------------โหลดรูป-----------------//
  Future<Null> Loaduser(int index) async {
    String getuserurl;

    await FirebaseFirestore.instance
    .collection("users")
    .doc(Postmodels[index].PostUserId)
    .get()
    .then((value) async{
      getuserurl=value.data()!["Userurl"];
       setState(() {
        userurl = getuserurl;
      });
    });
   
  }

  








}
