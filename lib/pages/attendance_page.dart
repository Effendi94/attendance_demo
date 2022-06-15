import 'package:attendance/core.dart';
import 'package:attendance/widgets/bottom_loader.dart';
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
    final String attendanceType =
        type == AttendanceType.start ? startAttendance : endAttendance;
    try {
      final time = controller.formattedTime.value;
      final date = controller.getCurrentDate;
      final dataAttendance = TableAttendance(
        usersId: controller.user.id,
        attendance_type: attendanceType,
        latitude: controller.position.value!.latitude,
        longitude: controller.position.value!.longitude,
        attendance_at: now().toUtc(),
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
      Get.snackbar(
        'Error',
        'Something wrong',
        backgroundColor: MyColors.danger,
      );
    }
  }

  void _submitAttendance(TableAttendance dataAttendance) async {
    try {
      Get.bottomSheet(
        const BottomLoader(),
        isDismissible: false,
      );
      await controller.saveAttendance(dataAttendance);
      await controller.getAttendance();
      Get.back();
      Get.back();
    } catch (e) {
      Get.back();
      Get.back();
      Get.snackbar(
        "Error",
        "Something Wrong",
        backgroundColor: MyColors.danger,
      );
    }
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
                    _buildButton(context),
                    const SizedBox(height: 20),
                    GoogleMapComponent(),
                    _attendanceHistoryTitle(),
                    _attendanceHistory(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Obx(
      () => controller.isStart.value
          ? ElevatedButton(
              onPressed: () => controller.allowAttendance.value
                  ? _onSubmitAttendance(AttendanceType.start)
                  : null,
              child: Text(
                startAttendance.toUpperCase(),
                style: const TextStyle(
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
              onPressed: () => controller.allowAttendance.value
                  ? _onSubmitAttendance(AttendanceType.end)
                  : null,
              child: Text(
                endAttendance.toUpperCase(),
                style: const TextStyle(
                  fontFamily: robotoBold,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(
                    50,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  controller.allowAttendance.value
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
              ),
            ),
    );
  }

  Widget _attendanceHistory() {
    return Obx(
      () => controller.listAttendance.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int idx) {
                final item = controller.listAttendance[idx];
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
                        item.attendance_type ?? '',
                        style: TextStyle(
                          fontFamily: robotoSemiBold,
                          color: MyColors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        dateTimeToStringDateTime(item.createdAt),
                        style: TextStyle(
                          fontFamily: robotoSemiBold,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: controller.listAttendance.length,
            )
          : Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'No record. . .',
                style: TextStyle(fontFamily: robotoLight),
              ),
            ),
    );
  }

  Widget _attendanceHistoryTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.centerLeft,
      child: const Text(
        'TODAY',
        style: TextStyle(
          fontFamily: robotoSemiBold,
        ),
      ),
    );
  }
}
