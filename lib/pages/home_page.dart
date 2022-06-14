import 'package:attendance/core.dart';
import 'package:restart_app/restart_app.dart';

class MyHomePage extends StatelessWidget {
  final HomeGetxController controller = Get.put(HomeGetxController());
  final OfficeLocationGetxController controller2 =
      Get.put(OfficeLocationGetxController());

  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
          Center(
            child: ElevatedButton(
              child: Text(
                'Clear Cache',
                style: TextStyles.textButton,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: 'Info',
                  titleStyle: TextStyles.title,
                  content: Text(
                    "Are you want to clear cache ? \nThe app will restarted",
                    style: TextStyles.subTitle,
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      clearStorage();
                      Restart.restartApp();
                    },
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
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusNormal),
                        ),
                      ),
                    ),
                  ),
                  cancel: ElevatedButton(
                    onPressed: Get.back,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: robotoSemiBold,
                        color: MyColors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(MyColors.danger),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusNormal),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
