import 'dart:ui';

import 'package:flutter/material.dart';

class ShowDogScreen extends StatefulWidget {

  final Map<String,dynamic> dogimage;

  ShowDogScreen({Key? key, required this.dogimage}) : super(key: key);

  @override
  _ShowDogScreenState createState() => _ShowDogScreenState();
}

class _ShowDogScreenState extends State<ShowDogScreen> {

  late Map<String,dynamic> dogimage;

  @override
  void initState() { 
    super.initState();
    dogimage = widget.dogimage;
    print(dogimage);
    print(dogimage["Dogname"]);
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
        title: Text(  '${dogimage["Dogname"]}'  ,
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
              //margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DogPic(),
                          Rowdog()
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

  Container DogPic(){
    return Container(
      margin: EdgeInsets.all(20),
        width: 400,
        height: 400,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(dogimage["url"]),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
    );
  }

  Container Dogname(){
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Text(dogimage["Dogname"],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
    );
  }

  Container DogBreed(){
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Text(dogimage["Breed"],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
    );
  }

  Container Rowdog(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Dogname(),
          DogBreed(),
        ],
      ),
    );
  }

}