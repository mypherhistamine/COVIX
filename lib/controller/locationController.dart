import 'package:COVIX/model/globalUrls.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TesterController extends GetxController {
  var count = 0.obs;

  increment() => count.value = count.value + 1;
  reset() => count.value = 0;
}

class LocationUpdates extends GetxController {
  var userLocation = Position().obs;
  // var testerPosition = Position().altitude;
  var distanceBetweenThem = 0.0.obs;

  @override
  void onInit() {
    print('chal rha hai bc');
    // getLocation().then((poistion) {
    //   print(poistion);
    //   userLocation.value = poistion;
    // });

    // getLocationUpdates().then((position) {
    //   print(position);
    //   userLocation.value = position;
    // });

    super.onInit();
  }

  Future<Position> getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (err) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<Position> getLocationUpdates() async {
    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.best,
            intervalDuration: Duration(seconds: 5))
        .listen(
      (position) {
        userLocation.value = position;
        // print(position);
        // print(Geolocator.distanceBetween(
        //     position.latitude, position.longitude, 28.7428265, 77.19888519));
        distanceBetweenThem.value = Geolocator.distanceBetween(
            28.74271335, 77.19878682, position.latitude, position.longitude);
        sendLatLngToFireBaseDB(lat: position.latitude, lng: position.longitude);
      },
    );
  }



  void distanceCalculator() {
    print(Geolocator.distanceBetween(28.742, 77.198, 28.7427, 77.1985));
  }

  Future<void> sendLatLngToFireBaseDB({double lat, double lng}) async {
    await http.patch(URLClass().userLatLng,
        body: json.encode({'Lat': lat, 'Long': lng}));
  }
}

//sample : lat : 28.7428265 lat : 77.19888519
