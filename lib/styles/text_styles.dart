import 'package:attendance/core.dart';

class TextStyles {
  static TextStyle elevatedButton = const TextStyle(
    fontFamily: robotoBold,
    fontSize: 16,
    color: Colors.white,
  );

  static TextStyle textButton = const TextStyle(
    fontFamily: robotoBold,
    fontSize: 14,
  );

  static TextStyle defaults = TextStyle(
    fontFamily: robotoRegular,
    fontSize: 14,
    color: MyColors.kTextColor,
  );

  static TextStyle danger = TextStyle(
    fontFamily: robotoRegular,
    fontSize: 14,
    color: MyColors.danger,
  );

  static TextStyle title = TextStyle(
    fontFamily: robotoBold,
    fontSize: 18,
    color: MyColors.kTextColor,
  );

  static TextStyle subTitle = TextStyle(
    fontFamily: robotoSemiBold,
    fontSize: 14,
    color: MyColors.kTextColor,
  );

  static TextStyle inputLabel = TextStyle(
    fontFamily: robotoMedium,
    fontSize: 12,
    color: MyColors.kTextColor,
  );

  static TextStyle inputHint = TextStyle(
    fontFamily: robotoLight,
    fontSize: 12,
    color: MyColors.kTextColor,
  );

  static TextStyle inputError = TextStyle(
    fontFamily: robotoSemiBold,
    fontSize: 12,
    color: MyColors.danger,
  );
}
