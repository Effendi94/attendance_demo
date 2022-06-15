import 'dart:async';

import 'package:attendance/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapComponent extends StatelessWidget {
  final AttendanceGetxController controller = Get.find();
  final Completer<GoogleMapController> gMapController = Completer();

  GoogleMapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.isLoading.value
        ? Container()
        : SizedBox(
            height: Get.height * .35,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  controller.officePosition.value!.latitude,
                  controller.officePosition.value!.longitude,
                ),
                zoom: 14.4746,
              ),
              markers: controller.markers,
              circles: controller.circles,
              onMapCreated: (GoogleMapController gController) {
                controller.isLoading(true);
                gMapController.complete(gController);
                controller.isLoading(false);
              },
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          );
  }
}
