import 'package:attendance/core.dart';
import 'package:crypt/crypt.dart';

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
