import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  List<Placemark> placeMarks = <Placemark>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserLocationAddress();
  }

  Future<void> getUserLocationAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  getCurrentAddress() async {
    var coordinates = await Geolocator.getCurrentPosition();
    var location = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
    return location[0].name + ' ' + location[0].locality;
  }
}
