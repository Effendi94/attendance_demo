import 'package:attendance/core.dart';
import 'package:attendance/widgets/bottom_loader.dart';
import 'package:attendance/widgets/rounded_password_field.dart';
import 'package:attendance/widgets/rounded_text_field.dart';

class LoginPage extends StatelessWidget {
  final LoginGetxController controller = Get.put(LoginGetxController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  void _login() async {
    controller.isLogin(true);
    try {
      if (formKey.currentState!.validate()) {
        Get.bottomSheet(
          const BottomLoader(),
          isDismissible: false,
        );
        await Future.delayed(const Duration(seconds: 1), () async {});
        await controller.checkCredentials(
            usernameController.text, passController.text);
        Get.back();
        Get.offAll(() => MyHomePage());
      }
      controller.isLogin(false);
    } catch (e) {
      Get.back();
      controller.isLogin(false);
      if (e is String) {
        Get.snackbar(
          "Info",
          e,
          backgroundColor: MyColors.warning,
        );
      }
    }
  }

  void _viewHint() async {
    dismissTextFieldFocus(Get.overlayContext!);
    Get.defaultDialog(
      title: "Login Hint",
      content: Column(
        children: List<Widget>.generate(
          3,
          (int idx) => Row(
            children: [
              Text(
                '${idx + 1}.',
                style: const TextStyle(
                  fontFamily: robotoSemiBold,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'user${idx + 1}',
                style: const TextStyle(
                  fontFamily: robotoSemiBold,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'password${idx + 1}',
                style: const TextStyle(
                  fontFamily: robotoSemiBold,
                ),
              ),
            ],
          ),
        ).toList(),
        // children: [
        // children: const [
        //   Text(
        //     '1.',
        //     style: TextStyle(
        //       fontFamily: robotoSemiBold,
        //     ),
        //   ),
        //   SizedBox(width: 5),
        //   Text(
        //     'user1',
        //     style: TextStyle(
        //       fontFamily: robotoSemiBold,
        //     ),
        //   ),
        //   SizedBox(width: 15),
        //   Text(
        //     'password1',
        //     style: TextStyle(
        //       fontFamily: robotoSemiBold,
        //     ),
        //   ),
        // ],
        // ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Get.height,
        width: double.infinity,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Image.asset(
                logoLight,
                height: getProportionateScreenHeight(125),
                width: getProportionateScreenWidth(200),
              ),
            ),
            const Text(
              'TIME & ATTENDANCE',
              style: TextStyle(
                fontFamily: robotoBold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'APPLICATION',
              style: TextStyles.title,
            ),
            const SizedBox(height: 5),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    RoundedTextField(
                      hintText: 'Username',
                      icon: CommunityMaterialIcons.account,
                      onChanged: (value) {},
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      validator: Validator.validateEmpty,
                    ),
                    Obx(
                      () => RoundedPasswordField(
                        icon: CommunityMaterialIcons.lock,
                        controller: passController,
                        obscureText: controller.obSecurePassword.value,
                        obscureSet: controller.togglePassword,
                        onChanged: (value) {},
                        validator: Validator.validatePassword,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _login,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.isLogin.value
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      MyColors.warning,
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(width: 10),
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: robotoBold,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size.fromHeight(
                            50,
                          ),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusNormal),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _viewHint,
                      child: Text(
                        'Hint?',
                        style: TextStyles.textButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
