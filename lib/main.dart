import 'package:cleantemplate/bloc/items_bloc.dart';
import 'package:cleantemplate/bloc/theme_cubit.dart';
import 'package:cleantemplate/data/source/app_repository.dart';
import 'package:cleantemplate/data/source/local/hive_database_helper.dart';
import 'package:cleantemplate/data/source/local/local_data_source.dart';
import 'package:cleantemplate/data/source/remote/remote_data_source.dart';
import 'package:cleantemplate/ui/sample_feature/sample_item_details_view.dart';
import 'package:cleantemplate/ui/sample_feature/sample_item_list_view.dart';
import 'package:cleantemplate/ui/settings/settings_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool isDebug() {
  if (kDebugMode || kProfileMode) {
    return true;
  } else {
    return false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = isDebug() ? Level.ALL : Level.OFF;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(
        '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message}');
  });

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  var log = Logger('main');
  log.fine('packageName: ${packageInfo.packageName}');

  final hive = HiveDatabaseHelper();
  await hive.init();

  runApp(App(hive: hive));
}

class App extends StatelessWidget {
  final HiveDatabaseHelper hive;
  const App({Key? key, required this.hive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = LocalDataSource(hive: hive);
    final remote = RemoteDataSource();
    final repo = AppRepository(local: local, remote: remote);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => repo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(repo: repo)..loadSettings(),
          ),
          BlocProvider(
            create: (_) => ItemsBloc(repo: repo)..add(const GetItems()),
          ),
        ],
        child: const MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: themeCubit.state,

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SettingsView.routeName:
                return const SettingsView();
              case SampleItemDetailsView.routeName:
                return const SampleItemDetailsView();
              case SampleItemListView.routeName:
              default:
                return const SampleItemListView();
            }
          },
        );
      },
    );
  }
}
