  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
  
  
  Container buildQueryComment(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('garage_location')
            .doc()
            .collection("comment")
            .where("userWhoComment", isNotEqualTo: "")
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
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(color: Color(0xff26292e)),
                  height: 120.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          color: Color(0xff6b46bf),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("คะแนน",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            Text(document["point"].toString(),
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Text(
                                        "date: " +
                                            document["date"]
                                                .toDate()
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Text(
                                        document["userWhoComment"] +
                                            "  " +
                                            document["lsuserWhoComment"] +
                                            ":",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Text(document["commentDetail"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }