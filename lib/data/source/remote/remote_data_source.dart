import 'package:cleantemplate/data/result.dart';
import 'package:cleantemplate/data/sample_item.dart';
import 'package:cleantemplate/data/source/data_source.dart';
import 'package:flutter/material.dart';

class RemoteDataSource extends DataSource {
  @override
  ThemeMode themeMode() {
    // TODO: implement themeMode
    throw UnimplementedError();
  }

  @override
  Future<void> updateThemeMode(ThemeMode theme) {
    // TODO: implement updateThemeMode
    throw UnimplementedError();
  }

  @override
  Future<Result<List<SampleItem>>> getSampleItems() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return Result.success(
          const [SampleItem(1), SampleItem(2), SampleItem(3)]);
    });
  }
}
