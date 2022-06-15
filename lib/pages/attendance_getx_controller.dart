import 'dart:async';
import 'dart:developer';

import 'dart:math' show asin, cos, sqrt;

import 'package:attendance/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AttendanceGetxController extends GetxController {
  LocationSettings? locationSettings;
  var listAttendance = <TableAttendance>[].obs;
  var position = Rxn<LatLng>();
  var officePosition = Rxn<LatLng>();

  var countDownTimer = ''.obs;
  var formattedTime = ''.obs;
  var isStart = true.obs;
  Set<Marker> markers = <Marker>{};
  Set<Circle> circles = <Circle>{};

  var isLoading = true.obs;
  var allowAttendance = true.obs;
  var user = TableUser();

  @override
  void onInit() {
    super.onInit();
    initFuture();
    // stream();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setCurrentTime());
  }

  void initVariable() {
    listAttendance.clear();
    position(null);
    officePosition(null);
    markers.clear();
    circles.clear();
  }

  Future<void> initFuture() async {
    isLoading(true);
    user = await auth.getUserData();
    await getOfficeLocation();
    await initLocation();
    await getAttendance();
    isLoading(false);
  }

  Future<Position> getCurrentLocation() async {
    final result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return result;
  }

  Future<void> initLocation() async {
    await checkPermission().whenComplete(() async {
      final pos = await getCurrentLocation();
      position.value = LatLng(pos.latitude, pos.longitude);
    });
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
        circleId: circleId,
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
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
        // onTap: () => _onMarkerTapped(markerId),
        // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
        // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
      );
      markers.add(marker);
      circles.add(circle);
    }
  }

  Future getAttendance() async {
    listAttendance.clear();
    allowAttendance(true);
    final date = now().toUtc();
    final start = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    log('user id : ${user.id}');
    final dataList = await TableAttendance()
        .select()
        .usersId
        .equals(user.id)
        .and
        .attendance_at
        .between(start, end)
        .top(2)
        .orderBy('attendance_at')
        .toList();
    inspect(dataList);
    if (dataList.isNotEmpty) {
      listAttendance(dataList);
      if (listAttendance.isEmpty) {
        isStart(true);
      } else if (listAttendance.length == 1) {
        isStart(false);
      } else {
        isStart(false);
        allowAttendance(false);
      }
    }
  }

  Future<void> saveAttendance(TableAttendance tableAttendance) async {
    final result = await tableAttendance.save();
    if (result == null) throw "Failed save data";
  }

  String get getCurrentDate {
    String dateTime = DateFormat("EEEE, MMM d, yyyy").format(now());
    return dateTime;
  }

  void setCurrentTime() {
    DateTime time = now().toUtc().toLocal();
    String timeString = DateFormat("H:mm:ss").format(time);
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
