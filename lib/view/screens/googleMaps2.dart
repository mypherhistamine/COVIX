import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsFinal extends StatefulWidget {
  @override
  _GoogleMapsFinalState createState() => _GoogleMapsFinalState();
}

class _GoogleMapsFinalState extends State<GoogleMapsFinal> {
  static final CameraPosition initialPosition =
      CameraPosition(target: LatLng(28.7428289, 77.1988651), zoom: 25);
  GoogleMapController _controller;
  Position position = Position(latitude: 22, longitude: 23, accuracy: 1.0);
  Set<Marker> marker = {};
  Set<Circle> circle = {};
  List<LatLng> points = [
    // LatLng(22.254, 74.234),
  ];

  void getCurrentLocaiton() async {
    // Uint8List imageData = await getMarker();
    Geolocator.getPositionStream(
            intervalDuration: Duration(seconds: 1),
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .listen((event) {
      print(event);
      setState(() {
        position = event;
        points.add(LatLng(position.latitude, position.longitude));
      });
    });
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load('aseets/images/cor_location.png');
    return byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GoogleMap(
          markers: {
            Marker(
                markerId: MarkerId('rishabh'),
                position: LatLng(position.latitude, position.longitude))
          },
          initialCameraPosition: initialPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            _controller = controller;
          },
          polylines: {
            Polyline(
                polylineId: PolylineId('new'),
                points: points.isEmpty ? [] : [
                  ...points
                  
                ],
                color: Colors.red,
                zIndex: 3,
                width: 2)
          },
          // circles: {
          //   Circle(
          //     circleId: CircleId('accuracy'),
          //     center: LatLng(position.latitude, position.longitude),
          //     radius: position.accuracy / 5,
          //   )
          // },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocaiton();
        },
        child: Icon(Icons.location_city),
      ),
    );
  }
}
