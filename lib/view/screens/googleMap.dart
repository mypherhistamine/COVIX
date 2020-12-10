import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsFlutter extends StatefulWidget {
  MapsFlutter({Key key}) : super(key: key);

  @override
  _MapsFlutterState createState() => _MapsFlutterState();
}

class _MapsFlutterState extends State<MapsFlutter> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(28.7428289, 77.1988651);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          onTap: (value) {
            print(value);
          },
          // rotateGesturesEnabled: false,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 20.0),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: FloatingActionButton(
          onPressed: () {
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(28.4219999, -122.0862462))));
          },
        ),
      ),
    );
  }
}
