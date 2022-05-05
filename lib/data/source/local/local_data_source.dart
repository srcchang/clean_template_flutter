import 'package:cleantemplate/data/result.dart';
import 'package:cleantemplate/data/sample_item.dart';
import 'package:cleantemplate/data/source/data_source.dart';
import 'package:cleantemplate/data/source/local/hive_database_helper.dart';
import 'package:flutter/material.dart';

class LocalDataSource extends DataSource {
  final HiveDatabaseHelper hive;

  LocalDataSource({required this.hive});

  @override
  ThemeMode themeMode() {
    return hive.getThemeMode();
  }

  @override
  Future<void> updateThemeMode(ThemeMode theme) async {
    await hive.setThemeMode(theme);
  }

  @override
  Future<Result<List<SampleItem>>> getSampleItems() {
    // TODO: implement getSampleItems
    throw UnimplementedError();
  }
}
