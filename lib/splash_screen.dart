import 'package:attendance/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  String? appVersion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));

      _getAppInfo();
      _redirect();
    });
  }

  double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = Get.height;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

// Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = Get.width;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }

  Future<void> _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = packageInfo.version;
    });
  }

  Future<void> _redirect() async {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      return Get.offAll(() => MyHomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.appPrimaryColors,
              MyColors.white,
            ],
            begin: const FractionalOffset(0.5, 0.1),
            end: const FractionalOffset(1.0, 1.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        width: double.infinity,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              logoLight,
              height: getProportionateScreenHeight(125),
              width: getProportionateScreenWidth(200),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                appVersion != null ? "App Version " + appVersion! : "",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
