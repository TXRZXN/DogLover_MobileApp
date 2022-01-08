
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/sub/detail.dart';
import 'package:doglovers/screen/sub/editownpost.dart';
import 'package:doglovers/screen/sub/newdog.dart';
import 'package:doglovers/screen/sub/setting.dart';
import 'package:doglovers/screen/sub/showdog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfilePage>{
  @override
  File? ImageFile;
  String pic="",filePic="",defaultpic="" ;
  String UserID ="" ;
  String Username ="";
  late String upurltofirestore;
  final _formKey = GlobalKey<FormState>();

  String? ChangeUsername;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    setusername();
    super.initState();

  }


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Background.jpg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 3.0),
                      Personal(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildOwnpic(context),
                          EditProfilePicture(),
                          Mydog(),
                          buildOwndog(context),
                          MyActivity(),
                          const SizedBox(height: 10.0),
                          buildOwnpost(context),
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

//top---------------------general----------------------------//
  //?------------------แถบPersonal+setting-----------------------//
  Row Personal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "โปรไฟล์ส่วนตัว",
          style: GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(
              Icons.settings_outlined,
              size: 30,
            ))
      ],
    );
  }

  //?------------------เพิ่มหมา-----------------------//
  Row Mydog() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "หมาของฉัน",
          style: GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewDog()),
              );
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ))
      ],
    );
  }

  //?------------------แก้ไขรูปโปรไฟล-----------------------//
  Row EditProfilePicture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            ChooseSourceImage();
          },
          child: Row(
            children: [
              const SizedBox(height: 10.0),
              Text(
                "เปลี่ยนรูปโปรไฟล์  ",
                style: GoogleFonts.kanit(fontSize: 12),
              ),
              //IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 5,))
              Icon(Icons.camera_alt_outlined, size: 20)
            ],
          ),
        ),
        InkWell(
          onTap: (){
            CheckDialog();
          },
          child: Row(
            children: [
              Text("ลบรูปโปรไฟล์",style: GoogleFonts.kanit(fontSize: 12),),
              Icon(Icons.delete, size: 20)
            ],
          )
          )
      ],
    );
  }

  //?------------------ดูประวัติโพส-----------------------//
  Row MyActivity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "โพสของฉัน",
          style: GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        Text("")
      ],
    );
  }

  //?------------------ดึงusername+userid-----------------------//
  Future<void> setusername() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String getusername,getuserid,getmypic;
    
    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async{
      getusername=value.data()!["username"];
      getuserid=value.data()!["userid"];
      getmypic=value.data()!["Userurl"];
       setState(() {
        UserID =getuserid;
        Username = getusername;
        filePic=getmypic;
      });
    });

    defaultpic= await FirebaseStorage.instance
    .ref("UserProfile/profile.png")
    .getDownloadURL();
  }


  //top---------------------โปรไฟล----------------------------//
  //?------------------เลือกกล้องของคน-----------------------//
  Future<Null> ChooseSourceImage() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("Please Choose Source Image"),
          subtitle: Text(
            "Please Tab on Camera or Gallery ",
            style: GoogleFonts.kanit(fontSize: 12),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  PickImage(ImageSource.camera);
                },
                child: Text(
                  "camera",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  PickImage(ImageSource.gallery);
                },
                child: Text(
                  "Gallery",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //?------------------up รูป profile ลง firebase ของ คน-----------------------//
  Future<void> PickImage(ImageSource imageSource) async {
    try {
      // ignore: deprecated_member_use
      var ResultPicture = await ImagePicker().getImage(
        source: imageSource,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      setState(() {
        ImageFile = File(ResultPicture!.path);
        pic = ResultPicture.path;
      });
    } catch (e) {}

    await FirebaseStorage.instance
        .ref()
        .child('UserProfile/$UserID')
        .putFile(ImageFile!);
    print("add to Storage success");

    upurltofirestore = await FirebaseStorage.instance.ref('UserProfile/$UserID').getDownloadURL();

    await FirebaseFirestore.instance.collection('users')
      .doc(UserID)
      .set({"Userurl":upurltofirestore}
      ,SetOptions(merge: true))
      .then((value)  {
        print('Insert UserURL To Firestore Success');
      });

    setState(() {
      initState();
    });
  }

  //?------------------รูปโปรไฟล-----------------------//
  Container buildOwnpic(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("userid", isEqualTo: uid)
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
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(filePic),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    InkWell(
                      onTap: () {
                        ChangeUserName();
                      },
                      child: Row(
                        children: [
                          Text(Username,style:GoogleFonts.kanit(color:Colors.black,fontSize: 20)),
                          const SizedBox(width: 5.0),
                          Icon(Icons.edit),
                        ],
                      ),
                    ),
                  ],

                );
              }).toList(),
          );
        },
      ),
    );
  }

  //?-------------------ตรวจสอบความถูกต้องDialog-----------------------//
  Future<Null> CheckDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("ต้องการลบรูปโปรไฟล์ใช่หรือไม่"),
          subtitle: Text("หากถูกต้องกดยืนยัน",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Deletepictureprofile();
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

  //?-------------------ลบรูปโปรไฟล์-----------------------//
  Future<void>Deletepictureprofile() async{
    await FirebaseFirestore.instance.collection('users')
      .doc(UserID)
      .set({"Userurl":defaultpic}
      ,SetOptions(merge: true))
      .then((value)  {
        print('delete UserURL To Firestore Success');
      });
    setState(() {
      initState();
    });
  }



  //top---------------------หมา----------------------------//
  //?------------------โชวหมา-----------------------//
  Container buildOwndog(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("Mydog")
            .orderBy("time")
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
                            builder: (context) => ShowMyDog(dogId: document["dogid"],Userid:uid,),
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
                              fit: BoxFit.cover,
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
                              document['Dogname'].substring(0,8),
                              style: GoogleFonts.kanit(fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                             "...",
                              style: GoogleFonts.kanit(fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            
                          ],
                        )
                      :
                        Text(
                          document['Dogname'],
                          style: GoogleFonts.kanit(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      Text(
                        document['Breed'],
                        style: GoogleFonts.kanit(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      InkWell(
                        onTap: () {
                          DeleteownDogButton(document["dogid"].toString(),document["path"].toString());
                        },
                        child: Icon(
                          Icons.delete,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
          );
        },
      ),
    );
  }
  
  //?------------------ยืนยัน การลบ หมา-----------------------//
  Future<Null> DeleteownDogButton(String dogid,String path) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text(
            "Delete",
            style: GoogleFonts.kanit(color: Colors.red),
          ),
          subtitle: Text(
            "Do you want to delete? ",
            style: GoogleFonts.kanit(fontSize: 12),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Deletedog(dogid,path);
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    setState(() {
      
    });
  }

  //?------------------ลบ ภาพ หมา-----------------------//
  Future<void> Deletedog(String ref,String path) async {

    await storage.ref(path).delete();
    // Rebuild the UI

    await FirebaseFirestore.instance
    .collection("users")
    .doc(UserID)
    .collection("Mydog")
    .doc(ref)
    .delete();

    setState(() {
    });
  }


  //top---------------------อื่นๆ----------------------------//
  //?------------------กรอกชื่อที่ต้องการเปลี่ยน-----------------------//
  Future<Null> ChangeUserName() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text(
            "เปลี่ยน Username",
            style: GoogleFonts.kanit(color: Colors.red),
          ),
          subtitle: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอก Username';
                } else if (value.length < 2) {
                  return 'Usernameต้องมีมากกว่า 1 ตัวอักษร';
                } else if (value.length > 15) {
                  return 'Usernameต้องมีน้อยกว่า 20 ตัวอักษร';
                }else
                  return null;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "UserName"),
              onChanged: (value) => ChangeUsername = value.trim(),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      UserID = ChangeUsername!;
                    });
                    UpNametofirebase();
                    Navigator.pop(context);
                  }
                  else{
                    FailDialog();
                  }
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //?------------------อัพชื่อลงfirebase-----------------------//
  Future<Null>UpNametofirebase() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance.collection('users')
    .doc(uid)
    .set({"username":UserID}
    ,SetOptions(merge: true))
    .then((value)  {
      print("change username success");
      setState(() {
        initState();
      });
    });

  }

  //?------------------ชื่อเกิน-----------------------//
  Future<Null> FailDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("กรุณากรอกชื่อให้ถูกต้อง"),
          subtitle: Text("Usernameต้องอยู่ระหว่าง2-20ตัวอักษร",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
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

  //top----------------OwnPost----------------------//
  //?------------------ยืนยัน การลบ โพสเก่า-----------------------//
  Future<Null> DeleteOwnPostButton(String DeletePostId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text(
            "Delete",
            style: GoogleFonts.kanit(color: Colors.red),
          ),
          subtitle: Text(
            "Do you want to delete? ",
            style: GoogleFonts.kanit(fontSize: 12),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  DeleteOwnPost(DeletePostId);
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancle",
                  style: GoogleFonts.kanit(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //?------------------ลบ โพสเก่า-----------------------//
  Future<void> DeleteOwnPost(String ref) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance.collection("Posts").doc(ref).delete();
    await FirebaseStorage.instance.ref('Posts/$uid/$ref').delete();
    await FirebaseFirestore.instance.collection("Notification").doc(uid)
      .collection("action")
      .where("PostId",isEqualTo:ref)
      .get()
      .then((value) => {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection("Notification").doc(uid)
            .collection("action")
            .doc(element.id).delete();
        })
      });

    await FirebaseFirestore.instance.collection("Posts").doc(ref).collection('comment')
    .get().then((value) => {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("Posts").doc(ref).collection('comment')
        .doc(element.id).delete();
      })
    });

    await FirebaseFirestore.instance.collection("Posts").doc(ref).collection('like')
    .get().then((value) => {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("Posts").doc(ref).collection('like')
        .doc(element.id).delete();
      })
    });

    setState(() {
    });
  }

  //?------------------โชวโพสเก่า-----------------------//
  Container buildOwnpost(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .where("PostUserId", isEqualTo: uid)
            .orderBy("PostTime", descending: true)
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
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
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
                                  fit: BoxFit.cover),
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
                                width: 5,
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
                                width: 5,
                              ),
                              Text(
                                document['PostTopic'],
                                style: GoogleFonts.kanit(color: Colors.grey.shade800),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) => editownpost(PostId:document['PostID'] ,),
                              );
                              Navigator.push(context, route).then((value) => initState());
                            },
                            child: Icon(Icons.edit_outlined),
                          ),
                          Text(""),
                          InkWell(
                            onTap: () {
                              DeleteOwnPostButton(document['PostID']);
                            },
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
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
