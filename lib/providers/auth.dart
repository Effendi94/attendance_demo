import 'dart:convert';

import 'package:attendance/core.dart';

abstract class BaseAuth {
  Future<String?> getAuthData();
  Future<String?> getLastLogin();
  Future<void> forceSignOut();
  Future<void> saveUserData(String userData);
  Future<void> saveAuthUser(String authUser);
  Future<TableUser> getUserData();
}

class Auth implements BaseAuth {
  @override
  Future<String?> getAuthData() async {
    var data = await getStorage(appAuthDataKey);
    return data;
  }

  @override
  Future<String?> getLastLogin() async {
    var data = await getStorage(appAuthDataKey);
    late String date;
    if (data != null) {
      var x = json.decode(data);
      date = x['last_login'];
    }
    return date;
  }

  @override
  Future<void> forceSignOut() async {
    try {
      await removeStorage(appAuthDataKey);
      await removeStorage(appUserDataKey);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(String userData) async {
    await putStorage(appUserDataKey, userData);
  }

  @override
  Future<void> saveAuthUser(String authUser) async {
    await putStorage(appAuthDataKey, authUser);
  }

  @override
  Future<TableUser> getUserData() async {
    final user = await getStorage(appUserDataKey);
    return TableUser.fromMap(json.decode(user!));
  }
}

final auth = Auth();
