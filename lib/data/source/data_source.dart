import 'package:cleantemplate/data/result.dart';
import 'package:cleantemplate/data/sample_item.dart';
import 'package:flutter/material.dart';

abstract class DataSource {
  ThemeMode themeMode();

  Future<void> updateThemeMode(ThemeMode theme);

  Future<Result<List<SampleItem>>> getSampleItems();
}

