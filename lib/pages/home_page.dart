import 'package:attendance/core.dart';
import 'package:attendance/widgets/bottom_loader.dart';

class MyHomePage extends StatelessWidget {
  final HomeGetxController controller = Get.put(HomeGetxController());
  final OfficeLocationGetxController controller2 =
      Get.put(OfficeLocationGetxController());

  MyHomePage({Key? key}) : super(key: key);

  Future<void> _forceLogout() async {
    Get.bottomSheet(
      const BottomLoader(),
      isDismissible: false,
    );
    await auth.forceSignOut();
    Get.offAll(() => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Flutter Attendance Demo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: Text(
                'Office Location',
                style: TextStyles.textButton,
              ),
              onPressed: () {
                Get.to(
                  () => OfficeLocationPage(),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text(
                'Attendance',
                style: TextStyles.textButton,
              ),
              onPressed: () {
                Get.to(
                  () => AttendancePage(),
                );
              },
            ),
          ),
          // _buttonClearCache(),
          _buttonLogOut(),
        ],
      ),
    );
  }

  Widget _buttonLogOut() {
    return Center(
      child: ElevatedButton(
        child: Text(
          'Log Out',
          style: TextStyles.textButton,
        ),
        onPressed: () {
          Get.defaultDialog(
            title: 'Info',
            titleStyle: TextStyles.title,
            content: Text(
              'Are you sure you want to logout?',
              style: TextStyles.subTitle,
            ),
            confirm: ElevatedButton(
              onPressed: _forceLogout,
              child: Text(
                'OK',
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
        },
      ),
    );
  }

  // Widget _buttonClearCache() {
  //   return Center(
  //     child: ElevatedButton(
  //       child: Text(
  //         'Clear Cache',
  //         style: TextStyles.textButton,
  //       ),
  //       onPressed: () {
  //         Get.defaultDialog(
  //           title: 'Info',
  //           titleStyle: TextStyles.title,
  //           content: Text(
  //             "Are you want to clear cache ? \nThe app will restarted",
  //             style: TextStyles.subTitle,
  //           ),
  //           confirm: ElevatedButton(
  //             onPressed: () async {
  //               await clearStorage();
  //               await Restart.restartApp();
  //             },
  //             child: Text(
  //               'OK',
  //               style: TextStyle(
  //                 fontFamily: robotoSemiBold,
  //                 color: MyColors.white,
  //               ),
  //             ),
  //             style: ButtonStyle(
  //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(kBorderRadiusNormal),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           cancel: ElevatedButton(
  //             onPressed: Get.back,
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 fontFamily: robotoSemiBold,
  //                 color: MyColors.white,
  //               ),
  //             ),
  //             style: ButtonStyle(
  //               backgroundColor:
  //                   MaterialStateProperty.all<Color>(MyColors.danger),
  //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(kBorderRadiusNormal),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
