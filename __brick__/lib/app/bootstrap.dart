import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../core/config/app_config.dart';
import '../core/enums/app_enums.dart';
import '../core/di/injection.dart';
import 'app.dart';

final sl = GetIt.instance;

Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final appConfig = await AppConfig.load(environment);

  await configureDependencies(appConfig);

  runApp(
    StartupApp(
      appRouter: sl(),
      localizationService: sl(),
    ),
  );
}
