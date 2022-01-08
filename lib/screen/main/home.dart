import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglovers/screen/main/map.dart';
import 'package:doglovers/screen/main/newpost.dart';
import 'package:doglovers/screen/main/notification.dart';
import 'package:doglovers/screen/main/profile.dart';
import 'package:doglovers/screen/setting/DogBreedSelector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'Feed.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  int? page;
  //String? breed,topic;
  HomeScreen({Key? key, required this.page,}):super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool MentNoti=true,LikeNoti=true,havemeassage=false;
  @override
  void initState() { 
    super.initState();
    page=widget.page;
    if( page != null ) refreshUI2(page!);
   
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        Navigator.push(context,MaterialPageRoute(
              builder: (context) => HomeScreen(page: 3,),),);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {    //edit---------ในแอพ----------//
      
      // Navigator.push(context,MaterialPageRoute(
      //         builder: (context) => HomeScreen(page: 3,),),);
      // print("message recieved in app");
      setState(() {
        havemeassage=true;
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {       //edit---------นอกแอพ----------//
      Navigator.push(context,MaterialPageRoute(
              builder: (context) => HomeScreen(page: 3,),),);
      print('Message clicked! out app');
    });

    setfirst();

    setnoti();

  }
  
  int _currentBottomTab = 0;
  int? page;
  late bool Firsttime;

  List<Widget> pages = [
    FeedPage(),
    MapScreen(),
    NewpostScreen(),
    NotificationScreen(),
    ProfilePage(),
  ];

  void refreshUI(int currentTab) {
    setState(() {
       _currentBottomTab = currentTab ;
    });
  }

  void refreshUI2(int topage) {
    setState(() {
      _currentBottomTab = topage;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentBottomTab],
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //?------------------bottombar------------------------//
  Widget _buildBottomBar(BuildContext context) {

    Color getColor(int index) {
      return _currentBottomTab == index
          ? Colors.black
          : Colors.grey.shade700;
    }

    return Container(
      height: 56,
      child: BottomAppBar(
        color: Color(0xffFFA500),
        elevation: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: getColor(0),
              ),
              onPressed: () {
                refreshUI(0);
              }),
            IconButton(
              icon: Icon(Icons.location_on),
              color: getColor(1),
              onPressed: () {
                refreshUI(1);
              }),
            IconButton(
              icon: Icon(Icons.add_a_photo),
              color: getColor(2),
              onPressed: () {
                refreshUI(2);
              }),
            StreamBuilder(
              stream: null,
              builder: (context, snapshot) {
                return IconButton(
                  icon: havemeassage 
                        ?
                          Icon(Icons.favorite,color:Colors.red,)
                        :
                          Icon(Icons.favorite_border,color: getColor(3),),
                  onPressed: () {
                    refreshUI(3);
                    havemeassage=false;
                  });
              }
            ),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: getColor(4),
              ),
              onPressed: () {
                refreshUI(4);
              }),
          ],
        ),
      ),
    );
  }

  //?------------------ดึงfirsttime-----------------------//
  Future<void> setfirst() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    bool getfirst;
    
    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async{
      getfirst=value.data()!["first"];
       setState(() {
        Firsttime=getfirst;
        if(Firsttime){
          alert();
          Firsttime=false;
          FirebaseMessaging.instance.unsubscribeFromTopic(uid);
               FirebaseFirestore.instance.collection('users')
                .doc(uid)
                .set({"first":Firsttime}
                ,SetOptions(merge: true))
                .then((value)  {
                  print("change firsttime success");
                  setState(() {
                    initState();
                  });
                });
        }
      });
    });  
  }

  //?------------------คำถามการทำแบบทดสอบครั้งแรก-----------------------//
  Future<Null> alert() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('images/Logo.png'),
          title: Text("ต้องการทำแบบทดสอบหรือไม่"),
          subtitle: Text("หากต้องการกดยืนยัน",style: GoogleFonts.kanit(color: Colors.grey.shade800),),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DbsScreen()),
              );
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

  //?------------------การแจ้งเตือน-----------------------//
  Future<void> setnoti() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var getmentnoti,getlikenoti;

    await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .get()
    .then((value) async {
      getmentnoti = value.data()!["NotiMent"];
      getlikenoti = value.data()!["NotiLike"];
      setState(() {
        MentNoti = getmentnoti;
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

}
