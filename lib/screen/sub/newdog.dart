import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropping/constant/enums.dart';
import 'package:image_cropping/image_cropping.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
class NewDog extends StatefulWidget {
  NewDog({Key? key}) : super(key: key);

  @override
  _NewDogState createState() => _NewDogState();
}

//!---------------=ชื่อหมาเกิน-----------//

class _NewDogState extends State<NewDog> {
  Uint8List? imageBytes = Uint8List.fromList([0,0,0]);
  File? ImageFile = File('');
  String? Dogname;
  String DropDownBreedValues = "เลือกพันธุ์สุนัข";
  late String UserID ;
  var now = DateTime.now();
  late String dogpicurl,commentid,picdogpath,dogid;

  bool havepic =false;

  @override
  void initState() {
    super.initState();
    setusername();
  }

  @override
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
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.keyboard_arrow_left_sharp,size:40,)),
                          Text(""),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Add Your Dogs",
                          style: GoogleFonts.kanit(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ShowImage(),
                          ChooseCamera(),
                          SetDogName(),
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
      ),
    );
  }

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
        //image: DecorationImage(image: FileImage(ImageFile!),fit: BoxFit.fill ),
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
        image: DecorationImage(image: FileImage(ImageFile!),fit: BoxFit.fill ),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  //?------------------ตั้งชื่อหมา-----------------------//
  Container SetDogName() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกชื่อหมา';
                } else
                  return null;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "ชื่อหมา"),
              onChanged: (value) => Dogname = value.trim(),
            ),
          ),
          DropDownDog(),
        ],
      ),
    );
  }

  //?------------------DropDown-----------------------//
  Widget DropDownDog() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFFA500).withOpacity(0.5),
          border: Border.all(color: Colors.black)),
      margin: EdgeInsets.all(20),
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

  //?------------------เลือกประเภทกล้อง-----------------------//
  Widget ChooseCamera() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: () => pickimage(ImageSource.camera),
          icon: Icon(
            Icons.camera,
            color: Colors.black,
          ),
          label: Text(
            'camera',
            style: GoogleFonts.kanit(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(primary: Color(0xffffa500)),
        ),
        ElevatedButton.icon(
          onPressed: () => pickimage(ImageSource.gallery),
          icon: Icon(Icons.library_add, color: Colors.black),
          label: Text(
            'Gallery',
            style: GoogleFonts.kanit(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(primary: Color(0xffffa500)),
        ),
      ],
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
  
  //?------------------ปุ่มบันทึกข้อมูล-----------------------//
  Container PostButton(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: 250, height: 50),
      child: InkWell(
        child: Text(
          "Add",
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            fontSize: 18,
            color: Colors.black,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 16.0,
                offset: Offset(-0.0, 0.0),
              ),
            ],
          ),
        ),
        onTap: () {
          if(Dogname==null){
            FailDialog();
          }
          else if(havepic==false){
            FailDialog();
          }
          else if(DropDownBreedValues=="Select Breed"){
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

  //?------------------อัพหมาไปStorage-----------------------//
  Future<Null> UpDogDetailToFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    try{
    print("Up pic dog to storage");
    await FirebaseStorage.instance
    .ref()
    .child('Dogs/$UserID/$Dogname')
    // .putFile(
    //   ImageFile!,
    //   SettableMetadata(
    //     customMetadata: {
    //       'Breed': DropDownBreedValues,
    //       'Dogname': Dogname!,
    //     },
    //   ),
    // );
    .putData(imageBytes!);
    print("get pic dog url");
    dogpicurl = await FirebaseStorage.instance
    .ref('Dogs/$UserID/$Dogname')
    .getDownloadURL();

    picdogpath=await FirebaseStorage.instance
    .ref('Dogs/$UserID/$Dogname').fullPath;

    print("insert value to firestore");
    await FirebaseFirestore.instance
    .collection("users")
    .doc(UserID)
    .collection("Mydog")
    .add({
      "Breed":DropDownBreedValues,
      "Dogname":Dogname,
      "Dogpic":dogpicurl,
      "path":picdogpath,
      "time":now.toString(),
    }).then((value) => {
      dogid=value.id
    });

    await FirebaseFirestore.instance
    .collection("users")
    .doc(UserID)
    .collection("Mydog")
    .doc(dogid)
    .set({"dogid":dogid,}
    ,SetOptions(merge: true))
    .then((value)  {
      print('Insert dogid To Firestore Success');
    });

    }catch(e){
      print(e);
    }    
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
        //Username = getusername;
      });
    });
   
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
                  UpDogDetailToFirebase();
                  SuccessDialog();
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
