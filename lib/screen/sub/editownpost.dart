import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class editownpost extends StatefulWidget {
  final String PostId;
  editownpost({Key? key,required this.PostId}) : super(key: key);

  @override
  _editownpostState createState() => _editownpostState();
}

class _editownpostState extends State<editownpost> {
  late String PostId,UpdateTitle,Updatedata;
  var now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostId=widget.PostId;
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
          "Edit Post ",
          style: GoogleFonts.kanit(fontSize: 22, color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildPost(context),
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

  Container buildPost(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .where("PostID", isEqualTo: PostId)
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
              UpdateTitle=document["PostTitle"];
              Updatedata=document["PostData"];
              Map<String, dynamic> data =document.data()! as Map<String, dynamic>;
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      width: 600,
                      height: 250,
                      padding:EdgeInsets.all(3) ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        image: DecorationImage(image: NetworkImage(document['PostImageUrl']),fit: BoxFit.fill),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Breed :",style: GoogleFonts.kanit(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(document['PostBreed'],style: GoogleFonts.kanit(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Topic :",style: GoogleFonts.kanit(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
                              Container(
                                padding: EdgeInsets.all(10),
                                
                                child: Text(document['PostTopic'],style: GoogleFonts.kanit(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(""),
                    Column(
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
                                style: GoogleFonts.kanit(
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
                              //controller: TextEditingController()..text=document['PostTitle'],
                              initialValue: document['PostTitle'],
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(hintText: " หัวเรื่อง"),
                              onChanged: (value) {UpdateTitle = value.toString().trim();}
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(""),
                    Column(
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
                              style: GoogleFonts.kanit(
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
                            //controller: TextEditingController()..text =document['PostData'],
                            initialValue: document['PostData'],
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(hintText: "เนื้อหา"),
                            onChanged: (value) {Updatedata = value.toString().trim();}
                          ),
                        ),
                      ),
                    ],
                  ),
                  ],
                )
              );
            }).toList(),
          );
        },
      ),
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
          style: GoogleFonts.kanit(fontSize: 18, color: Colors.black, shadows: [
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
      print(Updatedata);
      print('-------------------------------------------');

      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance.collection("Posts")
        .doc(PostId)
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
          subtitle: Text("หากถูกต้องกดยืนยัน",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
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

  //?-------------------ถูกต้องDialog-----------------------//
  Future<Null> SuccessDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Upload Success"),
          //subtitle: Text("หากถูกต้องกดยืนยัน",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
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
                  style: GoogleFonts.kanit(color: Colors.black),
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
          subtitle: Text("กรุณากรอกข้อมูลให้ครบ",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
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
                  style: GoogleFonts.kanit(color: Colors.red),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }





}