import 'dart:async';

import 'package:attendance/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AttendancePage extends StatelessWidget {
  final Controller controller = Get.find();
  AttendancePage({
    Key? key,
  }) : super(key: key);

  final Completer<GoogleMapController> gMapController = Completer();

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  void _goToTheLake() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              controller.position!.latitude, controller.position!.longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          gMapController.complete(controller);
        },
        myLocationEnabled: true,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }
}
