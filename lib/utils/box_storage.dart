// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<bool> putStorage(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, value);
}

Future<bool> removeStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}

Future<bool> clearStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.clear();
}
