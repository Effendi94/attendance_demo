import 'package:attendance/core.dart';
import 'package:crypt/crypt.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

DateTime now() => DateTime.now().toUtc().toLocal();

String encrypt(String text) {
  String hashedPassword = Crypt.sha256(text).toString();
  return hashedPassword;
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
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) await Geolocator.openLocationSettings();
  }
}

String dateTimeToStringDateTime(DateTime? dateTime) {
  String result = '';
  if (dateTime != null) {
    result = DateFormat("MMM d yyyy - H:mm").format(dateTime.toUtc().toLocal());
  }
  return result;
}

double convertToDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return 0.00 + value;
  } else if (value == null) {
    return 0.0;
  } else {
    return value;
  }
}

String ucWord(String text) {
  if (text.isNotEmpty) {
    var splitStr = text.toLowerCase().split(' ');
    for (var i = 0; i < splitStr.length; i++) {
      splitStr[i] = splitStr[i][0].toUpperCase() + splitStr[i].substring(1);
    }
    // Directly return the joined string
    return splitStr.join(' ');
  }
  return '';
}

void dismissTextFieldFocus(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
}
