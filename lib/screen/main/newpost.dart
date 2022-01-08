import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/PostModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropping/image_cropping.dart';
import 'package:image_cropping/constant/enums.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:path/path.dart' as path;


//!---------------------urluser-----------------//

class NewpostScreen extends StatefulWidget {
  NewpostScreen({Key? key}) : super(key: key);
  
  @override
  _NewpostScreenState createState() => _NewpostScreenState();
}

class _NewpostScreenState extends State<NewpostScreen> {
  String DropDownBreedValues = "เลือกพันธุ์สุนัข";
  String DropDownTopicValues = "เลือกหัวข้อ";
  String LikePost = "0";
  String CommentPost = "0";

  late String UserID = "";
  late String Username ="";
  late String TokenUser ="";

  String? UserUrl;
  var now = DateTime.now();
  String? TitlePost, DataPost,  Images,PostID;
  String? ImageUrl;
  File? ImageFile= File('');
  bool havepic =false;
  Uint8List? imageBytes = Uint8List.fromList([0,0,0]);
  List<dynamic> ArrayLike=["0"];

  @override
  void initState() { 
    super.initState();
    setusername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Background.jpg'),
            fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Column(
                        children: [
                          Text("New Post",style: GoogleFonts.kanit(fontSize: 30,fontWeight: FontWeight.w900),),
                          (imageBytes==Uint8List.fromList([0,0,0]))?ShowImage2():ShowImage(),
                          ChooseCamera(),
                          DetailPost(),
                          RowDropdown(),
                          PostButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //?------------------Show รูปที่เลือก-----------------------//
  Widget ShowImage(){
    return Container(
      margin: EdgeInsets.all(20),
      width: 600,
      height: 250,
      padding:EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        image: DecorationImage(image: MemoryImage(imageBytes!,scale: 3,),fit: BoxFit.fill),
        //image: DecorationImage(image: FileImage(ImageFile!),fit: BoxFit.cover ),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  Widget ShowImage2(){
    return Container(
      margin: EdgeInsets.all(20),
      width: 600,
      height: 250,
      padding:EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        //image: DecorationImage(image: MemoryImage(imageBytes!,scale: 3,)),
        image: DecorationImage(image: FileImage(ImageFile!),fit: BoxFit.cover ),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  //?------------------เปิดกล้อง//คลัง-----------------------//
  Future<void> pickimage(ImageSource imageSource) async{
    try {
        // ignore: deprecated_member_use
        var ResultPicture = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      if(ResultPicture!=null){
        ImageCropping.cropImage(
        context,
        await ResultPicture.readAsBytes(),
        () {
          showLoader();
        },
        () {
          hideLoader();
        },
        (data) {
          if (imageBytes.toString() == data.toString()) {
          } else {
            setState(
              () {
                imageBytes = data;
              },
            );
          }
        },
        selectedImageRatio: ImageRatio.FREE,
        //selectedImageRatio: ImageRatio.RATIO_1_1,
        visibleOtherAspectRatios: true,
        squareBorderWidth: 2,
        squareCircleColor: Colors.black,
        defaultTextColor: Colors.orange,
        selectedTextColor: Colors.black,
        colorForWhiteSpace: Colors.black,
      );
      }

      setState(() {
        ImageFile = File(ResultPicture!.path);
        havepic =true;
      });
    } catch (e) {
    }
  }
  
  void showLoader() {
    if (EasyLoading.isShow) {
      return;
    }
    EasyLoading.show(status: 'Loading...');
  }

  void hideLoader() {
    EasyLoading.dismiss();
  }
  
  //?------------------เลือกประเภทกล้อง-----------------------//
  Widget ChooseCamera(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: () => pickimage(ImageSource.camera),
          icon: Icon(Icons.camera,color: Colors.black,),
          label: Text('กล้อง',style: GoogleFonts.kanit(color: Colors.black),),
          style: ElevatedButton.styleFrom(
            primary: Color(0xffffa500)
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => pickimage(ImageSource.gallery),
          icon: Icon(Icons.library_add,color: Colors.black),
          label: Text('แกลลอรี่',style: GoogleFonts.kanit(color: Colors.black),),
          style: ElevatedButton.styleFrom(
            primary: Color(0xffffa500)
          ),
        ),
      ],
    );
  }

  //?------------------รายละเอียดPost-----------------------//
  Container DetailPost() {return Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
    child: Column(
      children: [
        Container(
          child: Column(
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
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(hintText: " หัวเรื่อง"),
                    onChanged: (value) => TitlePost = value.trim(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(""),
        Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),  
                  color: Color(0xffFFA500),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" เนื้อหา",
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
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(hintText: "  เนื้อหา"),
                    onChanged: (value) => DataPost = value.trim(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  }
  
  //?------------------ดึงusername+userid+token-----------------------//
  Future<void> setusername() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String getusername;
    String getuserid;
    String getusertoken;
    
    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async{
      getusername=value.data()!["username"];
      getuserid=value.data()!["userid"];
      getusertoken=value.data()!["Token"];
       setState(() {
        TokenUser =getusertoken;
        UserID =getuserid;
        Username = getusername;
      });
    });
   
  }

  
  //top----------------DropDown-----------------------//
  //?------------------DropDown-----------------------//
  Widget DropDownDog() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffFFA500).withOpacity(0.5),
        border: Border.all(color: Colors.black)),
      margin: EdgeInsets.only(left: 20,right: 3),
      child: DropdownButton<String>(
        value: DropDownBreedValues,
        elevation: 16,
        icon: Icon(Icons.arrow_drop_down),
        style: GoogleFonts.kanit(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            DropDownBreedValues = newValue!;
          });
        },
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
          'ไทยหลังอาน',
          'อื่นๆ', 
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  //?------------------DropDown-----------------------//
  Widget DropDownTopic() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFA500).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black)),
      margin: EdgeInsets.only(left: 3,right: 20),
      child: DropdownButton<String>(
        value: DropDownTopicValues,
        elevation: 16,
        icon: Icon(Icons.arrow_drop_down),
        style: GoogleFonts.kanit(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            DropDownTopicValues = newValue!;
          });
        },
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
      ),
    );
  }

  //?------------------ปุ่มDropDown-----------------------//
  Widget RowDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [DropDownDog(), DropDownTopic()],
    );
  }

  //top--------------------ปุ่ม-----------------------//
  //?------------------ปุ่มบันทึกข้อมูล-----------------------//
  InkWell PostButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if(TitlePost==null){
          FailDialog();
          print("no title");
        }
        else if(DataPost==null){
          FailDialog();
          print("no data");
        }
        else if(havepic == false){
          FailDialog();
          print("no pic");
        }
        else if(DropDownBreedValues=="Select Breed"){
          FailDialog();
          print("select breed");
        }
        else if(DropDownTopicValues=="Select Topic"){
          FailDialog();
          print("select topic");
        }
        else{
          CheckDialog();
        }
      },
      child: Container(
      constraints: BoxConstraints.expand(width: 250, height: 50),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffFFA500),
        boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
      ),
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(12),
      )
    );
  }
  
  //?-------------------เพิ่มข้อมูลลงFirebase-----------------------//
  Future<Null> CreatePost() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    try{
    await Firebase.initializeApp().then((value) async {
      PostModel model = PostModel(
        TokenUserPost: TokenUser,
        PostID: "",
        PostImageUrl: "",
        PostTime: now.toString(), 
        PostBreed: DropDownBreedValues, 
        PostTopic: DropDownTopicValues, 
        PostLike: LikePost, 
        PostComment: CommentPost, 
        PostUserId: UserID,
        PostData: DataPost!, 
        PostTitle: TitlePost!
       );
      Map<String, dynamic> data = model.toMap();
      await FirebaseFirestore.instance.collection('Posts')
        .add(data)
        .then((value)  {
          PostID = value.id;
          print('Insert Value To Firestore Success');
        });

      await FirebaseStorage.instance
      .ref()
      .child('Posts/$uid/$PostID')
      //.putFile(ImageFile!,);
      .putData(imageBytes!);
      ImageUrl = await FirebaseStorage.instance.ref('Posts/$uid/$PostID').getDownloadURL();

      await FirebaseFirestore.instance.collection('Posts')
        .doc(PostID)
        .set({"PostImageUrl":ImageUrl,
              "PostID":PostID,
              "Array":ArrayLike,
        }
        ,SetOptions(merge: true))
        .then((value)  {
          print('Insert URL+Postid+array To Firestore Success');
        });


    },);
    SuccessDialog();
    
    }catch(e){
      print("dont know error ");
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
                  CreatePost();
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
                    MaterialPageRoute(builder: (context) => HomeScreen(page: 0,)),
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
