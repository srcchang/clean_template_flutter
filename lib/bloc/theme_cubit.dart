import 'package:cleantemplate/data/source/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final log = Logger('ThemeCubit');
  final DataRepository repo;
  ThemeCubit({required this.repo}) : super(ThemeMode.system);

  void loadSettings() {
    final result = repo.themeMode();
    emit(result);
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == state) return;

    await repo.updateThemeMode(newThemeMode);

    emit(newThemeMode);
  }
}
