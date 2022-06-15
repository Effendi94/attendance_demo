import 'package:attendance/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
      debugPrint('-------Save Common Data--------');
      await insertCommonData();
      _getAppInfo();
      _checkLogin();
    });
  }

  Future<void> _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = packageInfo.version;
    });
  }

  Future<void> insertCommonData() async {
    try {
      await TableUser().upsertAll(listCommonUser);
      await TableLocation().upsertAll(commonLocation);
      debugPrint('-------Common Data Saved--------');
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        titleStyle: TextStyles.title,
        content: Text(
          'Something Wrong, restarting app',
          style: TextStyles.subTitle,
        ),
        confirm: ElevatedButton(
          onPressed: () async {
            await clearStorage();
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
                borderRadius: BorderRadius.circular(kBorderRadiusNormal),
              ),
            ),
          ),
        ),
      );
    }
  }

  Future<void> _checkLogin() async {
    var authData = await auth.getAuthData();
    Future.delayed(const Duration(milliseconds: 1500), () async {
      if (authData != null) {
        var strDate = await auth.getLastLogin();
        if (strDate != null) {
          var dateLastLogin = DateTime.parse(strDate).toLocal();
          var dateUtc = DateTime.now().toUtc();
          var dateLocal = dateUtc.toLocal();
          if (dateLocal.difference(dateLastLogin).inDays > daysAutoLogOut) {
            await auth.forceSignOut();
            Get.snackbar(
              "Info",
              "Session expired",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
            );
            return Get.offAll(() => LoginPage());
          }
        }
        return Get.offAll(() => MyHomePage());
      } else {
        return Get.offAll(() => LoginPage());
      }
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
