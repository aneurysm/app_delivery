import 'dart:async';
import 'package:app_delivery/models/google_geolocation.dart';
import 'package:app_delivery/providers/google_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class MapAndroid extends StatefulWidget {
  const MapAndroid({Key? key}) : super(key: key);

  @override
  State<MapAndroid> createState() => _MapAndroidState();
}

class _MapAndroidState extends State<MapAndroid> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? markerbit;
  @override
  Widget build(BuildContext context) {
    final googleProviderLatLong = Provider.of<GoogleProvider>(context);
    Set<Marker> markers = {};
    setMarkerIcon();
    return FutureBuilder(
      future: googleProviderLatLong.getGoogleLatLon(),
      builder: (_, AsyncSnapshot<Location> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
              height: 180, child: CupertinoActivityIndicator());
        }
        final Location loc = snapshot.data!;
        markers.add(Marker(
          markerId: const MarkerId('Marker'),
          position: LatLng(loc.lat!, loc.lng!),
          icon: markerbit!,
          draggable: true,
        ));

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(loc.lat!, loc.lng!),
                  zoom: 19,
                ),
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  // setState(() {
                  _controller.complete(controller);
                  // });
                },
                // markers: markers,
              ),
              Center(
                child: Image.asset("assets/myLocation.png", width: 50),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: actualPosition,
            child: const Icon(Icons.my_location_outlined),
          ),
        );
      },
    );
  }

  setMarkerIcon() async {
    markerbit = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)), 'assets/myLocation.png');
  }

  Future<void> actualPosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   await Geolocator.openLocationSettings();
    //   return Future.error('Location services are disabled');
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    final latlon = Provider.of<GoogleProvider>(context, listen: false).LatLon;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latlon!.latitude, latlon.longitude), zoom: 19)));
    // controller.animateCamera(CameraUpdate.newLatLngZoom(
    //     LatLng(latlon.latitude, latlon.longitude), 19));
  }
}
