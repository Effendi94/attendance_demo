import 'dart:async';

import 'package:attendance/core.dart';
import 'package:attendance/widgets/loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatelessWidget {
  final AttendanceGetxController controller =
      Get.put(AttendanceGetxController());
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

  String _getCurrentDate() {
    String dateTime = DateFormat("EEEE, MMM d, yyyy ").format(now());
    return dateTime;
  }

  void _submitAttendance() {
    controller.isStart(!controller.isStart.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Obx(
          () => controller.position.value != null
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      _getCurrentDate(),
                      style: TextStyle(
                        fontFamily: robotoBold,
                        fontSize: 20,
                        color: MyColors.kTextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Text(
                        controller.countDownTimer.value,
                        style: TextStyle(
                          fontFamily: robotoBold,
                          fontSize: 18,
                          color: MyColors.kTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => controller.isStart.value
                          ? ElevatedButton(
                              onPressed: _submitAttendance,
                              child: const Text(
                                'END DAY',
                                style: TextStyle(
                                  fontFamily: robotoBold,
                                ),
                              ),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size.fromHeight(
                                    50,
                                  ),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: _submitAttendance,
                              child: const Text(
                                'START DAY',
                                style: TextStyle(
                                  fontFamily: robotoBold,
                                ),
                              ),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size.fromHeight(
                                    50,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: Get.height * .4,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.position.value!.latitude,
                              controller.position.value!.longitude),
                          zoom: 14.4746,
                        ),
                        circles: {
                          Circle(
                            circleId: CircleId(_getCircleId(1)),
                            center: LatLng(controller.position.value!.latitude,
                                controller.position.value!.longitude),
                            radius: 50,
                            strokeColor: Colors.orange,
                            strokeWidth: 2,
                            fillColor: MyColors.appPrimaryColors,
                          )
                        },
                        onMapCreated: (GoogleMapController controller) {
                          gMapController.complete(controller);
                        },
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'TODAY',
                        style: TextStyle(
                          fontFamily: robotoSemiBold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int idx) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'Start Day',
                                style: TextStyle(
                                  fontFamily: robotoSemiBold,
                                  color: MyColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '13 June 2022 - 07:19',
                              style: TextStyle(
                                fontFamily: robotoSemiBold,
                                color: MyColors.white,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: 2,
                    ),
                  ],
                )
              : const Loader(text: "Loading Map..."),
        ),
      ),
    );
  }

  String _getCircleId(circleIdCounter) {
    final String circleIdVal = 'circle_id_$circleIdCounter';
    return circleIdVal;
  }
}
