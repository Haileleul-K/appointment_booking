import 'dart:async' show Future;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? prefsInstance;
  static Future<SharedPreferences> get _instance async =>
      prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefsInstance = await _instance;
    return prefsInstance!;
  }

  static Future<Map<String, dynamic>> readSaved(String key) async {
    //final prefs = await SharedPreferences.getInstance();

    return await json.decode(prefsInstance?.getString(key) ?? '') as Map<String, dynamic> ;
  }

  save(String key, dynamic value) async {
    // final prefs = await SharedPreferences.getInstance();
    await prefsInstance?.setString(key, json.encode(value));
  }

  static String? getString(
    String key,
  ) {
    return prefsInstance!.getString(key);
  }

  static removeString(String key) {
    prefsInstance!.remove(key);
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;

    return prefs.setString(key, value);
  }

  saveStringToDisk(String key, String content) {
    prefsInstance?.setString(key, content);
  }

  saveBooleanToDisk(String key, bool content) async {
    await  prefsInstance!.setBool(key, content);
  }

  Future<bool> isLogin(String key) async {
    var value = prefsInstance!.getBool(key);
    return value ?? false;
  }

  Future<String?> getStringFromDisk(String key) async {
    var value = prefsInstance!.getString(key);
    return value;
  }

}
