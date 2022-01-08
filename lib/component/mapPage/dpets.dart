import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Mapreview.dart';

class Dpets extends StatefulWidget {
  final radius;
  Dpets({Key? key, required this.radius}) : super(key: key);
  @override
  _DpetsState createState() => _DpetsState();
}

class _DpetsState extends State<Dpets> {
  double? lat, lng;
  String? useridG;
  int? counter;
  String? case1 = "";

  var shlat = [],
      shlng = [],
      gauserid = [],
      snameing = [],
      sdetailing = [],
      shopdising = [];
  var name, detail, shopdis;
  var myMarkers = HashSet<Marker>();
  Query<Map<String, dynamic>> reference = FirebaseFirestore.instance
      .collection("Maps")
      .where("type", isEqualTo: "dpets");
  late BitmapDescriptor customerMarker;

  getCustomMarker() async {
    customerMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 123213), 'images/dpets.png');
  }

  var slocation;
  bool load = true;
  bool garageload = true;
  var useridtech;
  GoogleMapController? mapController;
  final Set<Marker> markers = new Set();
  //Completer<GoogleMapController> _controller = Completer();

  void initState() {
    getCustomMarker();
    super.initState();
    findLatLan();
    //setMarkers() ;
  }

  Future<Null> findLatLan() async {
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      load = false;
    });
    print('lat = $lat, lng = $lng, load = $load');
  }

  Future<Position?> findPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

/*   Set<Marker> setMarkers() {
    return [
      Marker(
        markerId: MarkerId('id'),
        position: LatLng(lat!, lng!),
        infoWindow: InfoWindow(
            title: 'คุณอยู่ที่นี่',
            snippet: 'ตำแหน่ง : Lat = $lat, lng = $lng'),
      ),
    ].toSet();
  } */

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.6;
    print(reference.toString());
    return Scaffold(
      backgroundColor: HexColor("#1e2025"),
      appBar: AppBar(
        title: Text(
          "ร้านเพทช้อปสุนัขใกล้เคียง",
          style: GoogleFonts.kanit(color: Colors.white),
        ),
        backgroundColor: HexColor("#16181c"),
      ),
      body: Container(
        child: Center(
          child: buildGoogleMaps(),
        ),
      ),
    );
  }

  Container buildGoogleMaps() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.25,
      //margin: EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat!, lng!),
          zoom: 16,
        ),
        markers: getmarkers(lat!, lng!),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }

  Set<Marker> getmarkers(double lat, double lng) {
    print("get marker user lat lng");
    print(lat);
    print(lng);
    print(widget.radius);
    //double distanceFromUser = double.parse(widget.radius);
    //distanceFromUser = distanceFromUser * 1000;
    print("distance");
    //print(distanceFromUser.toString());

    var query = reference;
    var shoplat = [];
    var shoplng = [];
    var useridG = [];
    var shopname = [];
    var shopdetail = [];
    var shdis = [];

    query.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          slocation = doc.data()["location"];
          useridtech = doc.data()["mapid"];
          name = doc.data()["name"];
          detail = doc.data()["detail"];

          //if (Geolocator.distanceBetween(
          //        lat, lng, slocation.latitude, slocation.longitude) <=
          //    distanceFromUser) {
          shoplat.add(slocation.latitude);
          shoplng.add(slocation.longitude);
          useridG.add(useridtech);
          shopname.add(name);
          shopdetail.add(detail);
          shdis.add(Geolocator.distanceBetween(
                  lat, lng, slocation.latitude, slocation.longitude) /
              1000);
          //}
        }
      });
      setState(() {
        shlat = shoplat;
        shlng = shoplng;
        gauserid = useridG;
        snameing = shopname;
        sdetailing = shopdetail;
        shopdising = shdis;

        counter = shoplat.length.toInt();
      });
    });

    setState(() {
      for (var i = 0; i < counter!; i++) {
        markers.add(Marker(
          markerId: MarkerId(gauserid[i].toString()),
          position: LatLng(shlat[i], shlng[i]), //position of marker
          infoWindow: InfoWindow(
              title: snameing[i], snippet: sdetailing[i], onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Review(mapid: gauserid[i].toString())),
                );
                print(gauserid[i].toString());
                print(
                    "1111111111111111111111111111111111111111111111111111111111");
              }),
          icon: customerMarker, //Icon for Marker
        ));
      }
    });

    return markers;
  }
}
