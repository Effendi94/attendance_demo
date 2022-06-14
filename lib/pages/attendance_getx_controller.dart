import 'dart:async';
import 'dart:developer';
import 'dart:math' show asin, cos, pi, sin, sqrt;

import 'package:attendance/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendanceGetxController extends GetxController {
  LocationSettings? locationSettings;
  var position = Rxn<LatLng>();
  var officePosition = Rxn<LatLng>();

  var countDownTimer = ''.obs;
  var formattedTime = ''.obs;
  var isStart = false.obs;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<CircleId, Circle> circles = <CircleId, Circle>{};

  var isLoading = true.obs;
  var user = TableUser();

  @override
  void onInit() {
    super.onInit();
    initFuture();
    // stream();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setCurrentTime());
  }

  Future<void> initFuture() async {
    final userData = await auth.getUserData();

    isLoading(true);
    await getOfficeLocation();
    await initLocation();
    // await getAttendance();
    isLoading(false);
    user = userData;
  }

  Future<Position> getCurrentLocation() async {
    final result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return result;
  }

  Future<void> checkPermission() async {
    var permission = await Permission.location.status;
    if (permission.isDenied) {
      permission = await Permission.location.request();
      if (permission.isDenied) {
        Get.defaultDialog(
          title: "Info",
          titleStyle: TextStyles.title,
          content: Text(
            "Location permission denied!",
            style: TextStyles.subTitle,
          ),
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK",
          confirmTextColor: MyColors.white,
        );
      }
    }
  }

  Future<void> initLocation() async {
    try {
      await checkPermission().whenComplete(() async {
        final pos = await getCurrentLocation();
        position.value = LatLng(pos.latitude, pos.longitude);
      });
    } catch (e) {
      // inspect(e);
    }
  }

  Future<void> getOfficeLocation() async {
    final data =
        await TableLocation().select().isActive.equals(true).toSingle();
    if (data != null) {
      final latitude = data.latitude!.toDouble();
      final longitude = data.longtitude!.toDouble();
      officePosition(
        LatLng(latitude, longitude),
      );
      final String markerIdVal = 'marker_id_${data.id}';
      final String circleIdVal = 'circle_id_${data.id}';
      final MarkerId markerId = MarkerId(markerIdVal);
      final CircleId circleId = CircleId(circleIdVal);

      final circle = Circle(
        circleId: CircleId(circleIdVal),
        center: LatLng(
          officePosition.value!.latitude,
          officePosition.value!.longitude,
        ),
        radius: 50,
        strokeColor: Colors.orange,
        strokeWidth: 2,
        fillColor: MyColors.appPrimaryColors,
      );

      final marker = Marker(
        markerId: markerId,
        position: LatLng(
          latitude + sin(data.id! * pi / 6.0) / 20.0,
          longitude + cos(data.id! * pi / 6.0) / 20.0,
        ),
        infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
        // onTap: () => _onMarkerTapped(markerId),
        // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
        // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
      );
      markers[markerId] = marker;
      circles[circleId] = circle;
    }
  }

  Future getAttendance() async {
    final date = now().toUtc();
    final dataList =
        await TableAttendance().select().createdAt.equals(date).toList();
    inspect(dataList);
  }

  Future<void> saveAttendance(TableAttendance tableAttendance) async {
    inspect(tableAttendance);
    // await tableAttendance.save();
  }

  String get getCurrentDate {
    String dateTime = DateFormat("EEEE, MMM d, yyyy").format(now());
    return dateTime;
  }

  void setCurrentTime() {
    DateTime time = now();
    String timeString = DateFormat("hh:mm:ss").format(time);
    countDownTimer(timeString);
    formattedTime(timeString);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double totalDistance(LatLng pos1, LatLng pos2) {
    double totalDistance = 0;
    totalDistance = calculateDistance(
        pos1.latitude, pos1.longitude, pos2.latitude, pos2.longitude);
    return totalDistance;
  }
}
