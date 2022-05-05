// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

class HiveDatabaseHelper {
  final log = Logger('HiveDatabaseHelper');
  static const String THEME_MODE = 'theme_mode';  
  late final Box _box;

  Future init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('hiveBox');
    return this;
  }

  ThemeMode getThemeMode() {
    return ThemeMode.values[_box.get(THEME_MODE, defaultValue: ThemeMode.system.index)];
  }

  Future<void> setThemeMode(ThemeMode mode) {
    return _box.put(THEME_MODE, mode.index);
  }
}
