import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = "isDarkMode";
  bool _isCheckValueForDark() => _box.read(_key) ?? false;
//if value in the [_key] return will true otherwise false will return
  _saveThemeBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  ThemeMode get theme =>
      _isCheckValueForDark() ? ThemeMode.dark : ThemeMode.light;
  switchTheme() {
    Get.changeThemeMode(
        _isCheckValueForDark() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeBox(!_isCheckValueForDark());
  }

  switchIcon() async {
    await switchTheme();
    Icon(Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined);
  }
}
