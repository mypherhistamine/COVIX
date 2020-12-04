import 'package:COVIX/controller/locationController.dart';
import 'package:COVIX/view/screens/secondTester.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TesterScreen extends StatelessWidget {
  final LocationUpdates locationController = Get.put(LocationUpdates());

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text('Location  ${locationController.userLocation}')),
              RaisedButton(
                onPressed: () {
                  // meraController.increment();
                  // chaltaHai.locationPressed();
                  locationController.getLocationUpdates();
                  // locationController.distanceCalculator();
                  locationController.sendLatLngToFireBaseDB();
                },
                child: Text('Press'),
              ),
              RaisedButton(
                onPressed: () {
                  Get.to(AnotherScreen());
                },
                child: Text('next screen'),
              ),
              Obx(() =>
                  locationController.distanceBetweenThem.value.floor() <= 30
                      ? Text(
                          'Distance ${locationController.distanceBetweenThem.floor()}',
                          style: TextStyle(fontSize: 30),
                        )
                      : Text('Too muech distance')),
            ],
          ),
        ),
      ),
    );
  }
}
