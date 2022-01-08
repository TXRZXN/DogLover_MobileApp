import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/constant.dart';
import 'package:doglovers/screen/authen/Login.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:doglovers/screen/setting/DogBreedSelector.dart';
import 'package:doglovers/screen/setting/Doginfo.dart';
import 'package:doglovers/screen/setting/HelpAndFeedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

//!-------------ลบบัญชีตัวเอง----------------//
//!-------------ลบรูปโปรไฟลไม่ได้ถ้าไม่มีรูป----------------//
//!-------------Notifile----------------//

class _SettingsPageState extends State<SettingsPage> {
  final auth = FirebaseAuth.instance;
  bool MentNoti=true,LikeNoti=true;
  late String numcomment;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setnoti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  page: 4,
                ),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffffa500),
        title: Text(
          'ตั้งค่า',
          style: GoogleFonts.kanit(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Background.jpg'), fit: BoxFit.fill),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Column(
            children: <Widget>[
              BreedSelecter(context),
              BreedInfo(context),
              LikeNotify(),
              CommentNotify(),
              Help(context),
              Logout(),
              Delete()
            ],
          ),
        ),
      ),
    );
  }

  //?------------------ล้อกเอาท-----------------------//
  Container Logout() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          
          color: Color(0xffffa500).withOpacity(0.7),
          border: Border.all(color: Colors.black),
        ),
        child: ListTile(
          title: Center(
            child: Text(
              "Logout",
              style: GoogleFonts.kanit(color: Colors.red.shade800),
            ),
          ),
          onTap: () async {
            await auth.signOut().then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Login();
              }));
            });
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .set({"Token": ""}, SetOptions(merge: true)).then((value) {
              print('Logout Success');
            });
          },
        ));
  }

  //?------------------ติดต่อแอดมิน-----------------------//
  Container Help(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        
        color: Color(0xffffa500).withOpacity(0.7),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        title: Text(
          "Help & Feedback",
          style: GoogleFonts.kanit(),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Helpnfeed()),
          );
        },
      ),
    );
  }

  //?------------------การแจ้งเตือนคอมเม้น-----------------------//
  Container CommentNotify() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      decoration: BoxDecoration(
        
        color: Color(0xffffa500).withOpacity(0.7),
        border: Border.all(color: Colors.black),
      ),
      child: SwitchListTile(
        activeColor: Color(0xffffa500),
        inactiveThumbColor: Colors.black,
        title: Text(
          "แจ้งเตือนการคอมเมนท์",
          style: GoogleFonts.kanit()
        ),
        value: MentNoti,
        onChanged: (bool value) {
          setState(() {
            MentNoti = value;
            if (MentNoti) {
              FirebaseMessaging.instance.subscribeToTopic(uid);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .set({"NotiMent": MentNoti}, SetOptions(merge: true)).then((value) {
                print("change NotiMent success");
                setState(() {
                  initState();
                });
              });
            } else {
              FirebaseMessaging.instance.unsubscribeFromTopic(uid);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .set({"NotiMent": MentNoti}, SetOptions(merge: true)).then((value) {
                print("change NotiMent success");
                setState(() {
                  initState();
                });
              });
            }
          });
        },
      ),
    );
  }

  //?------------------การแจ้งเตือนไลค-----------------------//
  Container LikeNotify() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      decoration: BoxDecoration(
        
        color: Color(0xffffa500).withOpacity(0.7),
        border: Border.all(color: Colors.black),
      ),
      child: SwitchListTile(
        activeColor: Color(0xffffa500),
        inactiveThumbColor: Colors.black,
        title: Text(
          "แจ้งเตือนการกดไลก์",
          style: GoogleFonts.kanit()
        ),
        value: LikeNoti,
        onChanged: (bool value) {
          setState(() {
            LikeNoti = value;
            if (LikeNoti) {
              FirebaseMessaging.instance.subscribeToTopic(uid);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .set({"NotiLike": LikeNoti}, SetOptions(merge: true)).then((value) {
                print("change NotiLike success");
                setState(() {
                  initState();
                });
              });
            } else {
              FirebaseMessaging.instance.unsubscribeFromTopic(uid);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .set({"NotiLike": LikeNoti}, SetOptions(merge: true)).then((value) {
                print("change NotiLike success");
                setState(() {
                  initState();
                });
              });
            }
          });
        },
      ),
    );
  }

  //?------------------ดึงnoti-----------------------//
  Future<void> setnoti() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var getusernoti,getlikenoti;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) async {
      getusernoti = value.data()!["NotiMent"];
      getlikenoti = value.data()!["NotiLike"];
      setState(() {
        MentNoti = getusernoti;
        LikeNoti=getlikenoti;
        if(MentNoti){
          FirebaseMessaging.instance.subscribeToTopic('comment$uid');
        }else{
          FirebaseMessaging.instance.unsubscribeFromTopic('comment$uid');
        }
         if(LikeNoti){
          FirebaseMessaging.instance.subscribeToTopic('like$uid');
        }else{
          FirebaseMessaging.instance.unsubscribeFromTopic('like$uid');
        }
      });
    });
  }
  
  //?------------------หน้าข้อมูลหมา-----------------------//
  Container BreedInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
          border: Border.all(color: Colors.black),
          color: Color(0xffffa500).withOpacity(0.7)),
      child: ListTile(
        title: Text(
          "Dog info",
          style: GoogleFonts.kanit()
        ),
        subtitle: Text(
          "ข้อมูลสุนัขของแบบทดสอบ",
          style: GoogleFonts.kanit()
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dinfo()),
          );
        },
      ),
    );
  }
  
  //?------------------แบบทดสอบ-----------------------//
  Container BreedSelecter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
          border: Border.all(color: Colors.black),
          color: Color(0xffffa500).withOpacity(0.7)),
      margin: EdgeInsets.only(top: 25),
      child: ListTile(
        title: Text(
          "Dog Breed Selector",
          style: GoogleFonts.kanit()
        ),
        subtitle: Text(
          "หาสุนัขที่เหมาะสมกับคุณ",
          style: GoogleFonts.kanit()
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DbsScreen()),
          );
        },
      ),
    );
  }

  //?------------------ปุ่มลบบัญชี-----------------------//
  Container Delete() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          
          color: Color(0xffffa500).withOpacity(0.7),
          border: Border.all(color: Colors.black),
        ),
        child: ListTile(
          title: Center(
            child: Text(
              "Delete My accout",
              style: GoogleFonts.kanit(color: Colors.red.shade800),
            ),
          ),
          onTap: () async {
            CheckDialog();
          },
        ));
  }

  //?------------------ลบข้อมูล-----------------------//
  Future<Null> DeleteMydata() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final uid = user.uid;
    List<dynamic> getarray;
    bool ? checkmyidinpost;
    try {
      print("delete pic dogs");
      final ListResult resultdog = await FirebaseStorage.instance.ref("Dogs/uid").list();
      final List<Reference> allFilesdog = resultdog.items;
      Future.forEach<Reference>(allFilesdog, (filedog) async {
        filedog.delete();
      });
      print("delete pic dogs finish");
      /////////////////////////////////////////////////////////////
      print("delete  dogs");
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("Mydog")
          .get()
          .then((value) => {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .collection("Mydog")
                  .doc(element.id)
                  .delete();
            })
          });
      print("delete dog finish");
      ////////////////////////////////////////////////////////////
      print("set pic profile ");
      String defaultpic = await FirebaseStorage.instance
          .ref("UserProfile/profile.png")
          .getDownloadURL();
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({"Userurl": defaultpic}, SetOptions(merge: true));
      print("set pic profile finish ");
      ////////////////////////////////////////////////////////////
      try {
        print("try to delete pic profile ");
        FirebaseStorage.instance.ref('UserProfile/$uid').delete();
      } catch (er) {
        print(er);
        print("try to delete pic profile failed");
      }
      print("try to delete pic profile finish");
      ////////////////////////////////////////////////////////////
      print("delete pic Post");
      final ListResult resultpost = await FirebaseStorage.instance.ref('Posts/$uid').list();
      final List<Reference> allFilespost = resultpost.items;
       Future.forEach<Reference>(allFilespost, (filepost)  {
        filepost.delete();
      });
      print("delete pic Post finish ");
      ////////////////////////////////////////////////////////////
      print("delete comment Post");
      FirebaseFirestore.instance
        .collection("Posts")
        .where("PostUserId", isEqualTo: uid)
        .get().then((value) => {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                .collection("Posts")
                .doc(element.id)
                .collection("comment")
                .get().then((data) => {
                  data.docs.forEach((result) {
                    FirebaseFirestore.instance.collection("Posts").doc(element.id)
                    .collection("comment").doc(result.id).delete();
                  })
                });
            })
        });
      print("delete comment finish ");
      ////////////////////////////////////////////////////////////
      print("delete Post");
      FirebaseFirestore.instance
          .collection('Posts')
          .where("PostUserId", isEqualTo: uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("Posts")
              .doc(element.id)
              .delete();
        });
      });
      print("delete Post finish");
      ////////////////////////////////////////////////////////////
      print("delete comment");
      FirebaseFirestore.instance.collection('Posts').get().then((value) {
        value.docs.forEach((element) {
          print("---------------------------------------");
          print(element.id);
          FirebaseFirestore.instance
            .collection("Posts")
            .doc(element.id)
            .collection("comment")
            .where("useridcomment", isEqualTo: uid)
            .get()
            .then((data) {
              data.docs.forEach((result) {
                FirebaseFirestore.instance
                  .collection("Posts")
                  .doc(element.id)
                  .collection("comment")
                  .doc(result.id)
                  .delete();
              });
            });
        });
      });
      print("delete comment finish");
      ////////////////////////////////////////////////////////////
      print("delete like");
      FirebaseFirestore.instance.collection('Posts').get().then((value) {
        value.docs.forEach((element) {
          print("---------------------------------------");
          print(element.id);
          FirebaseFirestore.instance
            .collection("Posts")
            .doc(element.id)
            .collection("like")
            .where("uidlike", isEqualTo: uid)
            .get()
            .then((data) {
              data.docs.forEach((result) {
                print(result.id);
                FirebaseFirestore.instance
                  .collection("Posts")
                  .doc(element.id)
                  .collection("like")
                  .doc(result.id)
                  .delete();
              });
            });
        });
      });
      print("delete like finish");
      ////////////////////////////////////////////////////////////
      print("delete array like");
      FirebaseFirestore.instance.collection("Posts").get().then((value) => {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection("Posts").doc(element.id)
          .get().then((value) => {
            getarray=value.data()!["Array"],
            checkmyidinpost=getarray.contains(uid),
            if(checkmyidinpost!){
              getarray.remove(uid),
              FirebaseFirestore.instance.collection("Posts").doc(element.id)
              .update({"Array":getarray}),
              print("update array sucess")
            }

          });
        })
      });

      print("delete array like finish");
      ////////////////////////////////////////////////////////////
      print("delete own noti");
      FirebaseFirestore.instance
          .collection("Notification")
          .doc(uid)
          .collection("action")
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection("Notification")
                      .doc(uid)
                      .collection("action")
                      .doc(element.id)
                      .delete();
                })
              });
      FirebaseFirestore.instance
          .collection("Notification")
          .doc(uid)
          .delete();
      print("delete own noti finish ");
      ////////////////////////////////////////////////////////////
      print("---------------------------------------");
      print("delete noti another");
      FirebaseFirestore.instance
        .collection("Notification")
        .get()
        .then((docuid) => {
          print("notification"),
          docuid.docs.forEach((elementnoti) {
            print('notification + ${elementnoti.id}');
            FirebaseFirestore.instance
              .collection("Notification")
              .doc(elementnoti.id)
              .collection("action")
              .where("useridaction",isEqualTo: uid)
              .get()
              .then((myaction) => {
                print('myaction'),
                myaction.docs.forEach((datanoti) { 
                  FirebaseFirestore.instance
                    .collection("Notification")
                    .doc(elementnoti.id)
                    .collection("action")
                    .doc(datanoti.id).delete();
                    print('myaction + ${datanoti.id}');
                })
              });
          })
        });
      print("delete noti another finish ");
      print("---------------------------------------");
      ////////////////////////////////////////////////////////////
      print("delete user");
      FirebaseFirestore.instance.collection('users').doc(uid).delete().then((value) => print("delete usering "));
      print("delete user finish ");

      print("delete auth");
      await user.delete().then((value) => {
        print("delete authing"),
      });

      print("delete auth finish");

      Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Login();
        }));

    } catch (e) {
      print(e);
    }
  }

  //?-------------------Dialogยืนยันการลบบัญชี-----------------------//
  Future<Null> CheckDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("คุณต้องการลบ account"),
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
                  DeleteMydata();
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

  

}
