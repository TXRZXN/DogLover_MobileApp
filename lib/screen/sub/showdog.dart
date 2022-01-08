
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/main/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ShowMyDog extends StatefulWidget {
  final String dogId,Userid;
  ShowMyDog({Key? key,required this.dogId,required this.Userid}) : super(key: key);

  @override
  _ShowMyDogState createState() => _ShowMyDogState();
}

class _ShowMyDogState extends State<ShowMyDog> {
  late String dogId,Userid;

  @override
  void initState() { 
    super.initState();
    dogId=widget.dogId;
    Userid=widget.Userid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffffa500),
        title: Text('Dogs',style: GoogleFonts.kanit(color: Colors.black),),
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

  Container buildPost(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(Userid)
            .collection("Mydog")
            .where("dogid",isEqualTo: dogId)
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
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,),
                        width: 400,
                        height: 400,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(document["Dogpic"]),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: Text(document["Dogname"],style: GoogleFonts.kanit(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),softWrap: true,),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: Text(document["Breed"],style: GoogleFonts.kanit(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
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



}