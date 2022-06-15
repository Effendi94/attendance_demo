import 'package:attendance/core.dart';
import 'package:attendance/widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String?>? validator;
  final Color? backGroundColor;
  final VoidCallback obscureSet;
  final String? initValue;
  final TextEditingController controller;
  final IconData? icon;

  const RoundedPasswordField({
    Key? key,
    this.hintText,
    required this.obscureText,
    this.onChanged,
    this.onSaved,
    required this.validator,
    this.initValue,
    this.backGroundColor,
    required this.obscureSet,
    required this.controller,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: backGroundColor ?? MyColors.white,
      child: TextFormField(
        controller: controller,
        initialValue: initValue,
        validator: validator,
        obscureText: obscureText,
        onChanged: onChanged,
        onSaved: onSaved,
        cursorColor: MyColors.appPrimaryColors,
        decoration: InputDecoration(
          hintText: hintText ?? "Password",
          icon: icon != null
              ? Icon(
                  icon,
                  color: MyColors.appPrimaryColors,
                )
              : null,
          suffixIcon: IconButton(
            onPressed: obscureSet,
            icon: Icon(
              obscureText
                  ? CommunityMaterialIcons.eye
                  : CommunityMaterialIcons.eye_off,
              size: 20,
              color: MyColors.appPrimaryColors,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
