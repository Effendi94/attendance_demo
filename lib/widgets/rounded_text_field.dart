import 'package:attendance/core.dart';
import 'package:attendance/widgets/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function()? onClear;
  final String? initValue;
  final Color? backGroundColor;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool readOnly;
  final double? width;

  const RoundedTextField({
    Key? key,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    required this.validator,
    this.onTap,
    this.onClear,
    this.initValue,
    this.backGroundColor,
    this.keyboardType,
    this.readOnly = false,
    this.width,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      color: backGroundColor != null
          ? backGroundColor!
          : readOnly
              ? MyColors.grey200
              : MyColors.white,
      child: TextFormField(
        initialValue: initValue,
        validator: validator,
        readOnly: readOnly,
        keyboardType: keyboardType ?? TextInputType.text,
        onChanged: onChanged,
        onTap: onTap,
        onSaved: onSaved,
        controller: controller,
        cursorColor: MyColors.appPrimaryColors,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 11),
          icon: icon != null
              ? Icon(
                  icon,
                  color: MyColors.appPrimaryColors,
                )
              : null,
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: (suffixIcon != null && readOnly)
              ? Icon(suffixIcon, color: MyColors.appPrimaryColors)
              : controller.text.isNotEmpty && onClear != null
                  ? _getClearButton()
                  : null,
        ),
        style: TextStyle(
          fontFamily: robotoRegular,
          color: MyColors.kTextColor,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _getClearButton() {
    return IconButton(
      onPressed: onClear,
      icon: Icon(
        Icons.clear,
        color: MyColors.kTextColor,
        size: 15,
      ),
    );
  }
}
