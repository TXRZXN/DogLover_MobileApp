
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/PostModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {

  final PostModel models;

  DetailPage({Key? key, required this.models}):super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  late PostModel models;
  late String newcomment;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? userurl;

  @override
  void initState() { 
    super.initState();
    models = widget.models;
    setusername();
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
        title: Text(
          "${models.PostTitle}",
          style: TextStyle(fontSize: 22, color: Colors.black),
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
                      ShowUsername(),
                      ShowPic(),
                      ShowLike (),
                      Showtitle(),
                      Showtext(),
                    ],
                  ),
                ),
              ),
              Container(alignment: Alignment.bottomCenter,child:AddComment () ,)
            ],
          ),
        ),
      ),
    ),
  );
  }

  //top----------------รายละเอียดโพสทั้งหมด-------------//
  //?------------------โชวรูป-----------------//
  Container ShowPic (){
    return Container (
      margin: EdgeInsets.only(left: 20,right: 20,),
      width: 400,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        image: DecorationImage(image: NetworkImage(models.PostImageUrl),fit: BoxFit.cover ),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  //?------------------โชวไลค์-----------------//
  Container ShowLike (){
    return Container(
      margin: EdgeInsets.only(top: 5,left: 20,right: 20),
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFFA500).withOpacity(0.3),
        border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(models.PostTitle),
          Row(
            children: [
              Text(models.PostLike),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
            ],
          ),
        ],
      ),
    );
  }

  //?------------------โชวหัวข้อ-----------------//
  Container Showtitle(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5,left: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFFA500).withOpacity(0.3),
        border: Border.all(color: Colors.black)),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(models.PostBreed),
          Text(models.PostTopic),
        ],
      ),     
    );
  }

  //?------------------โชวรูปโปรไฟล-----------------//
  Container ShowUsername(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
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
          const SizedBox(width: 10,),
          //Text(models.Username  ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
      ],
      ),
    );
  }

  //?------------------โชวเนื้อหา-----------------//
  Container Showtext(){
    return Container(
      width: 400,
      margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFFA500).withOpacity(0.3),
        border: Border.all(color: Colors.black)),
      child: Text(models.PostData,softWrap: true,),
    );
  }

  //?------------------ช่องกรอก comment-----------------//
  Container AddComment (){
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
        color: Colors.transparent,
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
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "comment"),
              onChanged: (value) => newcomment = value.trim(),
            ),
          ),
          Container(
            child: IconButton(
              onPressed: (){
                AddCommentToFirebase();
              }, 
              icon: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }
  
  //?------------------เพิ่ม comment ลง firebase-----------//
  //!------------------ยังไม่ได้ทำ----------------//
  Future<Null> AddCommentToFirebase() async{
   
  }

  Future<void> setusername() async {
    String getuserurl;
    await FirebaseFirestore.instance
    .collection("users")
    .doc(models.PostUserId)
    .get()
    .then((value) async{
      getuserurl=value.data()!["Userurl"];
       setState(() {
        userurl = getuserurl;
      });
    });
   
  }

}