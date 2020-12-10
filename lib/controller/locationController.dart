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
  var otherUserLocation = Position().obs;
  var distanceBetweenThem = 0.0.obs;
  var otherUserDistance = 0.0.obs;
  var locationAccuracy = 1.0.obs;

  @override
  void onInit() {
    sendLocationUpdates().then((position) {
      print(position);
    });
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

  Future<Position> sendLocationUpdates() async {
    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.best,
            intervalDuration: Duration(seconds: 5))
        .listen(
      (position) {
        userLocation.value = position;
        // distanceCalculator();
        // print(position);
        // print(Geolocator.distanceBetween(
        //     position.latitude, position.longitude, 28.7428265, 77.19888519));
        // distanceBetweenThem.value = Geolocator.distanceBetween(
        //     28.74271335, 77.19878682, position.latitude, position.longitude);
        // sendLatLngToFireBaseDB(lat: position.latitude, lng: position.longitude);
      },
    );
  }

  void distanceCalculator() {
    distanceBetweenThem.value = Geolocator.distanceBetween(
        userLocation.value.latitude,
        userLocation.value.longitude,
        otherUserLocation.value.latitude,
        otherUserLocation.value.longitude);
    print('hi');
    print(distanceBetweenThem.value);
  }

  Future<void> sendLatLngToFireBaseDB({double lat, double lng}) async {
    await http.patch(URLClass().userLatLng,
        body: json.encode({'Lat': lat, 'Long': lng}));
  }

  Future<Position> getPositionSubscription() async {
    final response = await http.get(URLClass().userLatLng);
    final responseBody = json.decode(response.body);
    Position tester = Position(
        latitude: responseBody['Lat'], longitude: responseBody['Long']);
    // print(tester);

    return tester;

    // print(response.body);
  }

  Stream<Position> productsStream() async* {
    // print('chal rhga hai ');
    while (true) {
      await Future.delayed(Duration(seconds: 5));

      Position userPosition = await getPositionSubscription();
      otherUserLocation.value = await getPositionSubscription();
      // print(userPosition);
      yield userPosition;
    }
  }
}

//sample : lat : 28.7428265 lat : 77.19888519
