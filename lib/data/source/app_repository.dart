import 'package:cleantemplate/data/result.dart';
import 'package:cleantemplate/data/sample_item.dart';
import 'package:cleantemplate/data/source/data_repository.dart';
import 'package:cleantemplate/data/source/data_source.dart';
import 'package:flutter/material.dart';

class AppRepository extends DataRepository {
  final DataSource local;
  final DataSource remote;

  AppRepository({required this.local, required this.remote});

  @override
  ThemeMode themeMode() {
    return local.themeMode();
  }

  @override
  Future<void> updateThemeMode(ThemeMode theme) {
    return local.updateThemeMode(theme);
  }

  @override
  Future<Result<List<SampleItem>>> getSampleItems() {
    return remote.getSampleItems();
  }
}
