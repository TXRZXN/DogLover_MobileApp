import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/PostModel.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class editPost extends StatefulWidget {
  PostModel model;

  editPost({Key? key, required this.model}):super(key: key);

  @override
  _editPostState createState() => _editPostState();
}



class _editPostState extends State<editPost> {
  
  late PostModel model;
  late String UpdateTitle=model.PostTitle,Updatedata=model.PostData;
  var now = DateTime.now();


  @override
  void initState() { 
    super.initState();
    model = widget.model;
    
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
          "Edit Post ${model.PostTitle}",
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
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          EditPicture (),
                          RowPost(),
                          Text(""),
                          PostTitle(),
                          Text(""),
                          PostData(),
                          // Text(""),
                          // RowPost(),
                          PostButton(context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  //?----------------ดึงรูป เปลี่ยนรูป ------------------//
  Container  EditPicture (){
    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 20),
      width: 600,
      height: 250,
      padding:EdgeInsets.all(3) ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        image: DecorationImage(image: NetworkImage(model.PostImageUrl),fit: BoxFit.cover),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  //?----------------เปลี่ยนหัวข้อ ------------------//
  Column PostTitle(){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),  
            color: Color(0xffFFA500),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("  หัวเรื่อง",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),  
            color: Color(0xffFFA500).withOpacity(0.3),
          ),
          child: Container(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกหัวเรื่อง';
                }else
                  return null;
              },
              initialValue: model.PostTitle,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: " หัวเรื่อง"),
              onChanged: (value) => UpdateTitle = value.toString().trim(),
            ),
          ),
        ),
      ],
    );
  }

  //?----------------เปลี่ยนเนื้อหา ------------------//
  Column PostData(){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),  
            color: Color(0xffFFA500),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("เนื้อหา",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),  
            color: Color(0xffFFA500).withOpacity(0.3),
          ),
          child: Container(
            child: TextFormField(
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกเนื้อหา';
                }else
                  return null;
              },
              initialValue: model.PostData,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "เนื้อหา"),
              onChanged: (value) => Updatedata = value.toString().trim(),
            ),
          ),
        ),
      ],
    );
  }

  //?----------------โชวพัน+ประเภท ------------------//
  Container RowPost(){
    return Container(
      //margin: EdgeInsets.only(left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostBreed(),
          PostTopic(),
        ],
      ),
    );
  }

  //?----------------โชวพัน ------------------//
  Row PostBreed(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Breed :",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(model.PostBreed,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }

  //?----------------โชวประเภท ------------------//
  Row PostTopic(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Breed :",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
        Container(
          padding: EdgeInsets.all(10),
          
          child: Text(model.PostTopic,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }



  //top--------------------ปุ่ม-----------------------//
  //?------------------ปุ่มบันทึกข้อมูล-----------------------//
  Container PostButton(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: 250, height: 50),
      child: InkWell(
        child: Text(
          "Post",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.black, shadows: [
            Shadow(
              color: Colors.black,
              blurRadius: 16.0,
              offset: Offset(-0.0, 0.0),
            ),
          ],),
        ),
        onTap: () {
          if(UpdateTitle==null){
            FailDialog();
          }
          else if(Updatedata==null){
            FailDialog();
          }
          else{
            CheckDialog();
          }
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffFFA500),
      ),
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(12),
    );
  }
  
   //?-------------------เพิ่มข้อมูลลงFirebase-----------------------//
  Future<Null> UpdatePost() async{
    try {
      print('-------------------------------------------');
      print(UpdateTitle);
      print('-------------------------------------------');
      print(Updatedata);

      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance.collection("Posts")
        .doc(model.PostID)
        .set({"PostTitle":UpdateTitle,"PostData":Updatedata,"PostTime":now.toString().substring(0,19)}
        ,SetOptions(merge: true))
        .then((value) {
          print("update success");
        });        
      });
      SuccessDialog();
    } catch (e) {
      FailDialog();
      print(e);
    }
  }
 


  //top-------------------Dialog---------------------//
  //?-------------------ตรวจสอบความถูกต้องDialog-----------------------//
  Future<Null> CheckDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("กรุณาตรวจสอบความถูกต้อง"),
          subtitle: Text("หากถูกต้องกดยืนยัน",style: TextStyle(color: Colors.grey.shade800),),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  UpdatePost();
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //?-------------------ถูกต้องDialog-----------------------//
  Future<Null> SuccessDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Upload Success"),
          //subtitle: Text("หากถูกต้องกดยืนยัน",style: TextStyle(color: Colors.grey.shade800),),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(page: 4,)),
                  );
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }

  //?------------------ล้มเหลวDialog-----------------------//
  Future<Null> FailDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Upload Failed"),
          subtitle: Text("กรุณากรอกข้อมูลให้ครบ",style: TextStyle(color: Colors.grey.shade800),),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }



}