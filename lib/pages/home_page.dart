import 'package:attendance/core.dart';

class MyHomePage extends StatelessWidget {
  final Controller controller = Get.put(Controller());

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
                'Master Location',
                style: TextStyles.textButton,
              ),
              onPressed: () {
                // controller.getCurrentLocation();
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
        ],
      ),
    );
  }
}
