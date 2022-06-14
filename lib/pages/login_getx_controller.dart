import 'dart:convert';

import 'package:attendance/core.dart';
import 'package:crypt/crypt.dart';

class LoginGetxController extends GetxController {
  var obSecurePassword = true.obs;
  var isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLogin(false);
  }

  void togglePassword() {
    obSecurePassword(!obSecurePassword.value);
  }

  Future<void> checkCredentials(
    String username,
    String password,
  ) async {
    final data =
        await TableUser().select().username.equals(username).toSingle();
    if (data == null) {
      throw "Username not found";
    }
    final result = Crypt(data.password!).match(password);
    if (!result) {
      throw "Invalid password!";
    }
    final authData = AuthData(
      id: data.id,
      name: data.username,
      lastLogin: now().toIso8601String(),
    );

    auth.saveUserData(data.toJson());
    auth.saveAuthUser(json.encode(authData));
  }
}
