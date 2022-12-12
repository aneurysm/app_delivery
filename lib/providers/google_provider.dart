import 'package:app_delivery/models/google_geolocation.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/google_direction.dart';
import 'package:http/http.dart' as http;

class GoogleProvider with ChangeNotifier {
  // final String key = 'AIzaSyA1m1unk29tg_UeAdFZRLQcMR9fJjGPEb4';
  final String key = 'AIzaSyC6Aon6u4xxHRhnv-HrK9pRgJz4uKk4yXA';
  List<Prediction> nearDirections = [];
  Location locationLatLng = Location();
  String address = "";
  Position? LatLon;

  Future<void> getGoogleDirecctions(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key&components=country:pe';
    // final response = await http.get(url);
    final response = await http.get(Uri.parse(url));
    nearDirections = GoogleDirection.fromJson(response.body).predictions;
    notifyListeners();
  }

  Future<Location> getGoogleLatLon() async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$key';
    final response = await http.get(Uri.parse(url));
    locationLatLng =
        googleGeoLocationFromMap(response.body).results![0].geometry.location;
    return locationLatLng;
  }

  setDirection(String direction) async {
    address = direction;
  }

  limpiarAutoComplete() async {
    nearDirections = [];
    notifyListeners();
  }

  setLatLon() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    LatLon = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
