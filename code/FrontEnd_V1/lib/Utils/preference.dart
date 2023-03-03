import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  // static const String USER_ID = "USER_ID";
  // static const String IS_USER_FIRSTTIME = "IS_USER_FIRSTTIME";

  static final Preference _preference = Preference._internal();

  factory Preference() {
    return _preference;
  }

  Preference._internal();

  static Preference get shared => _preference;

  static SharedPreferences? _pref;

  Future<SharedPreferences?> instance() async {
    if (_pref != null) return _pref;
    await SharedPreferences.getInstance().then((onValue) {
      _pref = onValue;
    }).catchError((onError) {
      _pref = null;
    });

    return _pref;
  }

  String? getString(String key) {
    return _pref!.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _pref!.setString(key, value);
  }

  int? getInt(String key) {
    return _pref!.getInt(key);
  }

  Future<bool> setInt(String key, int value) {
    return _pref!.setInt(key, value);
  }

  bool? getBool(String key) {
    return _pref!.getBool(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _pref!.setBool(key, value);
  }

  double? getDouble(String key) {
    return _pref!.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) {
    return _pref!.setDouble(key, value);
  }

  Future<bool> remove(key, [multi = false]) async {
    SharedPreferences? pref = await instance();
    if (multi) {
      key.forEach((f) async {
        return await pref!.remove(f);
      });
    } else {
      return await pref!.remove(key);
    }
    return Future.value(true);
  }
}
