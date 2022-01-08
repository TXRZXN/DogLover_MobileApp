import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/PostModel.dart';
import 'package:doglovers/screen/sub/detail.dart';
import 'editownpost.dart';
import 'package:doglovers/screen/sub/newdog.dart';
import 'package:doglovers/screen/sub/setting.dart';
import 'showdog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

//!------------------Refresh รูปโปรไฟล-----------------------//
//!------------------Refresh ลบหมา-----------------------//
//!------------------Refresh ลบโพส-----------------------//
//!------------------เปลี่ยนรูปโปรไฟลไม่ได้--------------------//
//!------------------ห้ามเปลี่ยนชื่อ--------------------//


//TODO------------------ดึงusername-----------------------//
//TODO------------------เปลี่ยนusername-----------------------//
//TODO------------------กดกลับหน้าsetting-doginfo-----------------------//



class _ProfileScreenState extends State<ProfileScreen> {
  @override
  late String ImageUrl, NameDog;
  File? ImageFile;
  String? pic, fileUrl, NormalUrl, filePic, NormalPic;
  late String UserID ="" ;
  late String Username ="";
  late String upurltofirestore;

  late String ChangeUsername;
  FirebaseStorage storage = FirebaseStorage.instance;
  List<PostModel> Postmodels = [];


  @override
  void initState() {
    setusername();
    super.initState();
    PictureProfile();
    NormalPictureProfile();
    LoadDogImages();
    ReadOwnPost();
  }

  void Refresh(){
    LoadDogImages();
    build(context);
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
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Personal(),
                  ProfilePic(),
                  EditProfilePicture(),
                  Mydog(),
                  Showdog(),
                  MyActivity(),
                  const SizedBox(height: 10.0),
                  ForeachOwnPost()
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
          "Personal Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
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

  //?------------------ดึงรูป+ชื่อ+แก้ไข่้-----------------------//
  Row ProfilePic() {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: filePic == null
                      ? NetworkImage('$NormalPic')
                      : NetworkImage('$filePic'),
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
              Text(Username,style:TextStyle(color:Colors.black,fontSize: 20)),
              const SizedBox(width: 5.0),
              Icon(Icons.edit),
            ],
          ),
        ),
        //IconButton(onPressed: (){}, icon: Icon(Icons.edit))
      ],
    );
  }

  //?------------------เพิ่มหมา-----------------------//
  Row Mydog() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "My dog",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                "Change Profile Picture",
                style: TextStyle(fontSize: 10),
              ),
              //IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 5,))
              Icon(Icons.edit, size: 20)
            ],
          ),
        ),
        Text("")
      ],
    );
  }

  //?------------------ดูประวัติโพส-----------------------//
  Row MyActivity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "My Activity",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
    String getusername;
    String getuserid;
    
    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async{
      getusername=value.data()!["username"];
      getuserid=value.data()!["userid"];
       setState(() {
        UserID =getuserid;
        Username = getusername;
      });
    });
   
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
            style: TextStyle(fontSize: 12),
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  PickImage(ImageSource.gallery);
                },
                child: Text(
                  "Gallery",
                  style: TextStyle(color: Colors.black),
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
        print('Insert URL To Firestore Success');
        print(upurltofirestore);
      });

    setState(() {
      initState();
    });
  }

  //?------------------ดึง รูป โปรไฟล จาก firestore-----------------------//
  Future<void> PictureProfile() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    fileUrl = await storage.ref('UserProfile/$uid').getDownloadURL();
    setState(() {
      filePic = fileUrl.toString();
    });
  }

  //?------------------ดึง รูป ปกติ จาก firestore-----------------------//
  Future<void> NormalPictureProfile() async {
    NormalUrl = await storage.ref('UserProfile/profile.png').getDownloadURL();
    setState(() {
      NormalPic = NormalUrl.toString();
    });
  }


  //top---------------------หมา----------------------------//
  //?------------------โหลด ภาพ หมา-----------------------//
  Future<List<Map<String, dynamic>>> LoadDogImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref('Dogs/$UserID').list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "Breed": fileMeta.customMetadata?['Breed'] ?? 'Unknow',
        "Dogname": fileMeta.customMetadata?['Dogname'] ?? 'Unknow',
      });
    });
    print(files);
    
    return files;
  }

  //?------------------ลบ ภาพ หมา-----------------------//
  Future<void> Delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {
    });
  }

  //?------------------โชว หมา-----------------------//
  Expanded Showdog() {
    return Expanded(
      child: FutureBuilder(
        future: LoadDogImages(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final Map<String, dynamic> dataimage = snapshot.data![index];
                return Container(
                  padding: EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => ShowDogScreen(dogimage: dataimage),
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
                              image: NetworkImage(dataimage['url']),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      dataimage['Dogname'].length>=10 
                      ? 
                        Row(
                          children: [
                            Text(
                              dataimage['Dogname'].substring(0,10),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                             "...",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            
                          ],
                        )
                      :
                        Text(
                          dataimage['Dogname'],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      Text(
                        dataimage['Breed'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                      InkWell(
                        onTap: () {
                          DeleteDogButton(dataimage);
                        },
                        child: Icon(
                          Icons.delete,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  //?------------------ยืนยัน การลบ หมา-----------------------//
  Future<Null> DeleteDogButton(Map<String, dynamic> dataimage) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          subtitle: Text(
            "Do you want to delete? ",
            style: TextStyle(fontSize: 12),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Delete(dataimage['path']);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancle",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    Refresh();
  }


  //top---------------------อื่นๆ----------------------------//
  //?------------------Refresh-----------------------//
  Future<void> PullToRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      initState();
    });
  }

  //?------------------กรอกชื่อที่ต้องการเปลี่ยน-----------------------//
  Future<Null> ChangeUserName() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text(
            "เปลี่ยน Username",
            style: TextStyle(color: Colors.red),
          ),
          subtitle: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกUserName';
              } else
                return null;
            },
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(hintText: "UserName"),
            onChanged: (value) => ChangeUsername = value.trim(),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    UserID = ChangeUsername;
                  });
                  //edit--------------------ชื่อที่เปลี่ยน---------------------//
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancle",
                  style: TextStyle(color: Colors.black),
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
    await FirebaseFirestore.instance.collection('Users');
  }

  //top----------------OwnPost----------------------//
  //?-----------------อ่านข้อมูล โพสเก่า----------------//
  Future<Null> ReadOwnPost() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    print("initializeApp Success");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    print(Username);
    await firestore
        .collection("Posts")
        .orderBy("PostTime")
        .where("PostUserId", isEqualTo: uid)
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

  //?-----------------list โพสเก่า----------------//
  Widget ShowListViewOwnPost(int index) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ShowImageOwnPost(index),
          ShowTextOwnPost(index),
          ShowEditOwnPost(index),
        ],
      ),
    );
  }

  //?-----------------โชวรูป พสเก่า----------------//
  Widget ShowImageOwnPost(int index) {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Detailscreen(PostId: Postmodels[index].PostID,PostUserId:Postmodels[index].PostUserId ,),
        );
        Navigator.push(context, route).then((value) => initState());
      },
      child: Container(
        width: 100,
        height: 70,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(Postmodels[index].PostImageUrl),
                fit: BoxFit.cover),
            border: Border.all(color: Colors.white, width: 2)),
      ),
    );
  }

  //?-----------------โชวข้อมูล โพสเก่า----------------//
  Widget ShowTextOwnPost(int index) {
    return Column(
      children: [
        Postmodels[index].PostTitle.length>=12
          ? Row(
            children: [
              Text(
                  Postmodels[index].PostTitle.substring(0,12),
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
        Text(""),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Postmodels[index].PostLike,
              style: TextStyle(color: Colors.grey.shade800),
            ),
            Icon(
              Icons.favorite,
              color: Colors.grey.shade800,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              Postmodels[index].PostComment,
              style: TextStyle(color: Colors.grey.shade800),
            ),
            Icon(
              Icons.message_outlined,
              color: Colors.grey.shade800,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              Postmodels[index].PostTopic,
              style: TextStyle(color: Colors.grey.shade800),
            )
          ],
        )
      ],
    );
  }

  //?-----------------โชวปุ่ม โพสเก่า----------------//
  Widget ShowEditOwnPost(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => editPost(model: Postmodels[index],),
            );
            Navigator.push(context, route).then((value) => initState());
          },
          child: Icon(Icons.edit_outlined),
        ),
        Text(""),
        InkWell(
          onTap: () {
            DeleteOwnPostButton(Postmodels[index].PostID);
          },
          child: Icon(
            Icons.delete,
          ),
        ),
      ],
    );
  }

  //?-----------------โชวlist โพสเก่า----------------//
  Expanded ForeachOwnPost() {
    return Expanded(
      child: ListView.builder(
          itemCount: Postmodels.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: ShowListViewOwnPost(index),);
          }),
    );
  }



  //?------------------ยืนยัน การลบ โพสเก่า-----------------------//
  Future<Null> DeleteOwnPostButton(String DeletePostId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          subtitle: Text(
            "Do you want to delete? ",
            style: TextStyle(fontSize: 12),
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancle",
                  style: TextStyle(color: Colors.black),
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
    await FirebaseFirestore.instance.collection("Posts").doc(ref).delete();
    await FirebaseStorage.instance.ref('Posts/$ref').delete();
    setState(() {
    });
  }















}
