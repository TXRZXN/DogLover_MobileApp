import 'dart:async';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/component/FCM.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:doglovers/screen/sub/hisprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class Detailscreen extends StatefulWidget {
  final String PostId;
  final String PostUserId;
  Detailscreen({Key? key,required this.PostId,required this.PostUserId}) : super(key: key);

  @override
  _detailscreenState createState() => _detailscreenState();
}

  
class _detailscreenState extends State<Detailscreen> {
  late String PostId,PostUserId,Tokenuserpost,Postusername;
  String Userurl="",userpost="";
  late String newcomment,Myusername,Urlcomment,Mytoken;
  late var now ;
  late String numcommmet,Getment,numlike,numlikestring;
  final _controller = TextEditingController();
  SendNotification notificate = new SendNotification();

  late List<dynamic> MyLike ;
  late List<dynamic> MyLikeformpost ;

  bool? statelike =false;
  bool? statelikefrompost =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostId=widget.PostId;
    PostUserId = widget.PostUserId;
    setusernamepost();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
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
      ),
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/Background.jpg'), fit: BoxFit.fill),
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
                      buildPost(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text("Comment",style: GoogleFonts.kanit(fontWeight: FontWeight.bold,fontSize: 18),),)
                        ],
                      ),
                      buildComment(context)
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

  //?------------------ดึงข้อมูลโพสทั้งหมด-----------------//
  Container buildPost(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
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
              Map<String, dynamic> data =document.data()! as Map<String, dynamic>;
              return Container(
                child: Column(
                  children: [
                    const SizedBox(height: 3,),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top:10,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              if (uid!=PostUserId) {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => HisProfile(userid: document["PostUserId"],),
                                );
                                Navigator.push(context, route).then((value) => initState());
                              }
                              else{
                                Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => HomeScreen(page: 4,),),);
                              }
                            },
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
                                      image: NetworkImage(Userurl),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                userpost.length>15
                                ?
                                  Text(userpost.substring(0,15) ,style: GoogleFonts.kanit(fontSize: 20,fontWeight: FontWeight.w700),)
                                :
                                  Text(userpost,style: GoogleFonts.kanit(fontSize: 20,fontWeight: FontWeight.w700),),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(document["PostLike"],softWrap: true,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                  
                                    if(statelikefrompost!){
                                      statelikefrompost=false;
                                      MyLikeformpost.remove(uid);
                                      Addarraytofirebase();
                                      unlike();

                                    }else{
                                      statelikefrompost=true;
                                      MyLikeformpost.add(uid);
                                      Addarraytofirebase();
                                      notilike();
                                    }


                                  });
                                },
                                child: statelikefrompost! 
                                  ?
                                    Icon(Icons.favorite,size: 25,color: Colors.red,)
                                  :
                                    Icon(Icons.favorite_border,size: 25,)
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top:5,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(""),
                          Text(document["PostTime"].toString().substring(0,19),style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,),
                      width: 400,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        image: DecorationImage(image: NetworkImage(document["PostImageUrl"]),fit: BoxFit.fill ),
                        border: Border.all(color: Colors.black),
                         boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                      ),
                    ),
                   
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                        ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                          
                              
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(document['PostBreed'],style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                                Text(document['PostTopic'],style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                              ],
                            ),     
                          ),
                           document["PostTitle"].toString().length > 30 
                            ?  
                              Container(
                                margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text("Title : "),
                                    Text(document["PostTitle"],softWrap: true,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                                  ],
                                )
                              )
                            :
                              Container(
                                margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  
                                  children: [
                                    Text("Title :",style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                                    Text(document["PostTitle"],softWrap: true,style: GoogleFonts.kanit(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.grey.shade700,)),
                                  ],
                                )
                              ),
                              
                          Container(
                            width: 400,
                            margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom:10),
                            padding: EdgeInsets.all(10),
                         
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Detail",style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                                Text(document["PostData"],softWrap: true,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )

              );
            }).toList(),
          );
        },
      ),
    );
  }

  //?------------------ดึงรูปคนโพส-----------------//
  Future<void> setusernamepost() async {
    String getuserurl;
    String getusername;
    late List<dynamic> getmyarray;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String getpostlike;
    late List<dynamic> getarrayformpost;
    
    
    await FirebaseFirestore.instance
    .collection("users")
    .doc(PostUserId)
    .get()
    .then((value) async{
      getuserurl=value.data()!["Userurl"];
      getusername=value.data()!["username"]; 
       setState(() {
        Userurl = getuserurl;
        userpost = getusername;
      });
    });

    //edit-----------โพสไลค์---------------//
    await FirebaseFirestore.instance
    .collection("Posts")
    .doc(PostId)
    .get()
    .then((value) async{
      getarrayformpost=value.data()!["Array"];
      getpostlike=value.data()!["PostLike"];
      setState(() {
        MyLikeformpost=getarrayformpost;
        statelikefrompost=MyLikeformpost.contains(uid);
        print("-------------------------------");
        print('arrayformpost = $MyLikeformpost');
        print('statelikepost = $statelikefrompost');
      });
    });

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
        color: Color(0xffffc55b),
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
              controller: _controller,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "comment", ),
              onChanged: (value) {
                newcomment = value.trim();
              },

            ),
          ),
          Container(
            child: IconButton(
              onPressed: (){
                AddCommentToFirebase();
                _controller.clear();
                setState(() {
                  
                });
              }, 
              icon: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }
  
  //?------------------เพิ่ม comment ลง firebase-----------//
  Future<Null> AddCommentToFirebase() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String nummentt;
    int numment;
    int intment=0;
    String getmyusername,getmyurl,getcommentid="",getmytoken,getlasttoken,getpostusername;
    String commentid="";
    String? getactionid;

    setState(() {
      now=DateTime.now();
    });

    try{
    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async{
      getmytoken=value.data()!["Token"];
       setState(() {  
        Mytoken=getmytoken;
      });
    });

     await FirebaseFirestore.instance
    .collection("users")
    .doc(PostUserId)
    .get()
    .then((value) async{
      getlasttoken=value.data()!["Token"];
      getpostusername=value.data()!["username"];
       setState(() {
        Tokenuserpost=getlasttoken;
        Postusername=getpostusername;
      });
    });

    await FirebaseFirestore.instance
    .collection("Posts")
    .doc(PostId)
    .collection("comment")
    .add({
      "data":newcomment,
      "useridcomment":uid,
      "timecomment":now.toString(),
    })
    .then((value){
      getcommentid=value.id;
      setState(() {
        commentid=getcommentid;
      });
    });
    
    await FirebaseFirestore.instance
    .collection("Posts")
    .doc(PostId)
    .collection("comment")
    .doc(getcommentid)
    .set({"CommentId":getcommentid}
      ,SetOptions(merge: true))
      .then((value)  {
        print('Insert comment To Firestore Success');
      });

    await FirebaseFirestore.instance
    .collection("Posts").doc(PostId)
    .collection("comment").get()
    .then((value) => {
      value.docs.forEach((element) {
        intment++;
        numcommmet=intment.toString();
      })
    });

    await FirebaseFirestore.instance
    .collection("Posts")
    .doc(PostId)
    .update({"PostComment": numcommmet});

    if(uid==PostUserId){
      print("dont add noti to firebase");
    }else{
      print("add to firebase");
      notificate.actionpost(uid, Mytoken, PostId,now.toString(), "แสดงความคิดเห็น", Tokenuserpost, PostUserId);
      
      await FirebaseFirestore.instance
      .collection("Notification")
      .doc(PostUserId)
      .set({
        "UsernamePost":userpost,
        "now":now.toString()
      });

      await FirebaseFirestore.instance
        .collection("Notification")
        .doc(PostUserId)
        .collection("action")
        .add({
          "PostId":PostId,
          "useridaction":uid,
          "time":now.toString(),
          "action":"แสดงความคิดเห็น",
          "commentid":commentid
        }).then((value) => {
            getactionid=value.id,
        });

      await FirebaseFirestore.instance
        .collection("Notification")
        .doc(PostUserId)
        .collection("action").doc(getactionid)
        .set({
         "actionid":getactionid
        }
        ,SetOptions(merge: true)
        );

    }

    }
    catch(e){
      print(e);
    }
    setState(() {
      
    });
  }

  //?------------------ดึงข้อมูลโพสทั้งหมด-----------------//
  Container buildComment(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .doc(PostId)
            .collection("comment")
            .orderBy("timecomment")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Column(
            children: snapshot.data!.docs.map((document) {
              return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xffffc55b),
                  border: Border.all(color: Colors.black,width: 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(offset: Offset(5,5),blurRadius: 5)],
                ),
                child: Column(
                  children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                            .collection('users')
                            .where("userid",isEqualTo: document["useridcomment"])
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
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
                                        datadoc["username"].toString().length>15
                                          ?
                                            Text(datadoc["username"].toString().substring(0,15)  ,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),)
                                          :
                                            Text(datadoc["username"]  ,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),) 
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()
                            );
                          }
                        ),
                        document["useridcomment"]==uid
                        ?
                          Row(
                            children: [
                              Text(document['timecomment'].toString().substring(0,16)  ,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),
                              InkWell(
                                onTap: (){
                                  CheckDialog(document["CommentId"]);
                                },
                                child: Icon(Icons.delete),
                              ),
                            ],
                          )
                        :
                          Text(document['timecomment'].toString().substring(0,16)  ,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),),

                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  document["data"].toString().length>35
                    ?
                      Container(child: Text(document["data"],softWrap: true,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),))
                    :
                    Row(children:[
                      Text(document["data"],softWrap: true,style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w700),)
                    ])
                  ],
                ),
              );
            }
            ).toList(),
          );
        }
      )
      );
  }

  //?------------------ลบคอมเม้น-----------------//
  Future<Null>deletecomment(String commentid)async{
    String? getment;
    int intment=0;

    await FirebaseFirestore.instance
    .collection("Posts").doc(PostId)
    .collection("comment")
    .doc(commentid).delete().then((value) => print("delete success"));

    await FirebaseFirestore.instance.collection("Posts").doc(PostId)
      .get().then((value) => {
        getment=value.data()!["PostComment"],
      });

    if(getment!="1"){
    await FirebaseFirestore.instance
    .collection("Posts").doc(PostId)
    .collection("comment").get()
    .then((value) => {
      value.docs.forEach((element) {
        intment++;
        numcommmet=intment.toString();
      })
    });
    }else{
      numcommmet="0";
    }

    await FirebaseFirestore.instance
    .collection("Posts")
    .doc(PostId)
    .update({"PostComment": numcommmet});

    await FirebaseFirestore.instance
    .collection("Notification")
    .doc(PostUserId)
    .collection("action")
    .where("commentid",isEqualTo: commentid)
    .get().then((value) => {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("Notification")
          .doc(PostUserId)
          .collection("action")
          .doc(element.id).delete();
      })
    });


  }

  //?-------------------ตรวจสอบความถูกต้องDialog-----------------------//
  Future<Null> CheckDialog(String commentid) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("ต้องการลบCommentใช่หรือไม่"),
          subtitle: Text("หากถูกต้องกดยืนยัน",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deletecomment(commentid);
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

  //?------------------เพิ่ม array ลง firebase-----------//
  Future<Null> Addarraytofirebase()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    await FirebaseFirestore.instance
    .collection("Posts")
    .doc(PostId)
    .set({
      "Array":MyLikeformpost,
    },SetOptions(merge: true));

    setState(() {
      
    });
  }

  //?------------------แจ้งเตือนไลค-----------//
  Future<Null> notilike()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String getmytoken,getlasttoken;
    String? getactionid;
    late String likeid;
    int numlike=0;
    String? numlikestring;

    setState(() {
      now=DateTime.now();
    });

    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async{
      getmytoken=value.data()!["Token"];
       setState(() {
        Mytoken=getmytoken;
      });
    });

    await FirebaseFirestore.instance
    .collection("users")
    .doc(PostUserId)
    .get()
    .then((value) async{
      getlasttoken=value.data()!["Token"];
       setState(() {
        Tokenuserpost=getlasttoken;
      });
    });

    await FirebaseFirestore.instance
      .collection("Posts").doc(PostId)
      .collection("like")
      .add({
        "now":now.toString(),
        "uidlike":uid,
        "PostId":PostId,
      }).then((value) => {
        likeid=value.id
      });

    await FirebaseFirestore.instance
      .collection("Posts").doc(PostId)
      .collection("like").doc(likeid)
      .set({
        "likeid":likeid
      }
      ,SetOptions(merge: true));

     await FirebaseFirestore.instance.collection("Posts").doc(PostId)
      .collection("like").get().then((value) => {
        value.docs.forEach((element) {
          numlike++;
          numlikestring=numlike.toString();
        })
      });

      await FirebaseFirestore.instance
      .collection("Posts")
      .doc(PostId)
      .update({"PostLike": numlikestring});
  
    if(uid==PostUserId){
      print("dont add noti to firebase");
    }else{
      print("add to firebase");
      notificate.likepost(uid, Mytoken, PostId,now.toString(), "ได้กดไลค์", Tokenuserpost, PostUserId);
      
      await FirebaseFirestore.instance
      .collection("Notification")
      .doc(PostUserId)
      .set({
        "UsernamePost":userpost,
        "now":now.toString()
      });

      await FirebaseFirestore.instance
        .collection("Notification")
        .doc(PostUserId)
        .collection("action")
        .add({
          "PostId":PostId,
          "useridaction":uid,
          "time":now.toString(),
          "action":"ได้กดไลค์",
          "commentid":""
        }).then((value) => {
            getactionid=value.id,
        });

      await FirebaseFirestore.instance
        .collection("Notification")
        .doc(PostUserId)
        .collection("action").doc(getactionid)
        .set({
         "actionid":getactionid
        }
        ,SetOptions(merge: true)
        );
        setState(() {
          
        });
    }
  }

  Future<Null> unlike()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    int numlike=0;
    String? getlike;

    await FirebaseFirestore.instance
    .collection("Posts").doc(PostId)
    .collection("like").where("uidlike",isEqualTo: uid)
    .get().then((value) => {
      value.docs.forEach((element) {
         FirebaseFirestore.instance.collection("Posts").doc(PostId)
          .collection("like").doc(element.id).delete();
      })
    });

    await FirebaseFirestore.instance.collection("Posts").doc(PostId)
      .get().then((value) => {
        getlike=value.data()!["PostLike"],
      });

    if(getlike!="1"){
    await FirebaseFirestore.instance
    .collection("Posts").doc(PostId)
    .collection("like").get()
    .then((value) => {
      value.docs.forEach((element) {
        numlike++;
        numlikestring=numlike.toString();
      })
    });
    }else{
      numlikestring="0";
    }

    await FirebaseFirestore.instance
      .collection("Posts")
      .doc(PostId)
      .update({"PostLike": numlikestring});

    await FirebaseFirestore.instance
    .collection("Notification")
    .doc(PostUserId)
    .collection("action")
    .where("useridaction",isEqualTo: uid)
    .where("action",isEqualTo: "ได้กดไลค์")
    .get().then((value) => {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("Notification")
          .doc(PostUserId)
          .collection("action")
          .doc(element.id).delete();
      })
    });

  }

}