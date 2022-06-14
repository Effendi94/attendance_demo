// Project imports:

import 'package:attendance/core.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? height;
  final double? width;
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      width: width ?? Get.width,
      // height: height ?? kTextFormFieldHeight,
      decoration: BoxDecoration(
        color: color ?? MyColors.white,
        border: Border.all(color: MyColors.appPrimaryColors),
        borderRadius: BorderRadius.circular(kBorderRadiusNormal),
      ),
      child: child,
    );
  }
}
