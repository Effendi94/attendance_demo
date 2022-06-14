import 'dart:async';

import 'package:attendance/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AttendanceGetxController extends GetxController {
  LocationSettings? locationSettings;
  LocationPermission? permission;
  bool? serviceEnabled;
  var position = Rxn<Position>();

  var countDownTimer = ''.obs;
  var isStart = false.obs;

  @override
  void onInit() {
    super.onInit();
    initLocation();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getCurrentTime());
    // stream();
  }

  Future<void> initLocation() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      position.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        // foregroundNotificationConfig: const ForegroundNotificationConfig(
        //   notificationText:
        //       "Example app will continue to receive your location even when you aren't using it",
        //   notificationTitle: "Running in Background",
        //   enableWakeLock: true,
        // ),
      );

      // update();
    } catch (e) {
      // inspect(e);
    }
  }

  Future stream() async {
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      debugPrint(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  void getCurrentTime() {
    String time = DateFormat("hh:mm:ss").format(now());
    countDownTimer(time);
  }
}
