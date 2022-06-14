import 'dart:developer';

import 'package:attendance/core.dart';
import 'package:attendance/widgets/loader.dart';

enum AttendanceType { start, end }

class AttendancePage extends StatelessWidget {
  final AttendanceGetxController controller =
      Get.put(AttendanceGetxController());
  AttendancePage({
    Key? key,
  }) : super(key: key);

  double get distanceInMeters {
    final distance = controller.totalDistance(
      controller.position.value!,
      controller.officePosition.value!,
    );
    return distance * 1000;
  }

  void _onSubmitAttendance(AttendanceType type) {
    // controller.isStart(!controller.isStart.value);
    final String attendanceType =
        type == AttendanceType.start ? 'Start Day' : ' End Day';
    try {
      final time = controller.formattedTime.value;
      final date = controller.getCurrentDate;
      final dataAttendance = TableAttendance(
        usersId: controller.user.id,
        attendance_type: attendanceType,
        latitude: controller.position.value!.latitude,
        longitude: controller.position.value!.longitude,
        startedAt: type == AttendanceType.start ? now() : null,
        endedAt: type == AttendanceType.end ? now() : null,
      );
      if (distanceInMeters <= 50) {
        Get.defaultDialog(
          title: 'Info',
          titleStyle: TextStyles.title,
          content: Text(
            'Starting day on $date at $time',
            style: TextStyles.subTitle,
          ),
          confirm: ElevatedButton(
            onPressed: () => _submitAttendance(dataAttendance),
            child: Text(
              'Submit',
              style: TextStyle(
                fontFamily: robotoSemiBold,
                color: MyColors.white,
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadiusNormal),
                ),
              ),
            ),
          ),
        );
      } else {
        Get.snackbar(
          'Info',
          'Out of range, please come closer to the office',
          backgroundColor: MyColors.warning,
          colorText: MyColors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      inspect(e);
    }
  }

  void _submitAttendance(TableAttendance dataAttendance) async {
    try {
      await controller.saveAttendance(dataAttendance);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: TextStyles.title,
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Loader(text: "Loading Map...")
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      controller.getCurrentDate,
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
                              onPressed: () =>
                                  _onSubmitAttendance(AttendanceType.end),
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
                              onPressed: () =>
                                  _onSubmitAttendance(AttendanceType.start),
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
                    GoogleMapComponent(),
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
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Day',
                                style: TextStyle(
                                  fontFamily: robotoSemiBold,
                                  color: MyColors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '13 June 2022 - 07:19',
                                style: TextStyle(
                                  fontFamily: robotoSemiBold,
                                  color: MyColors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 2,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
