import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../../app/observers/app_observer.dart';
import '../../app/routes/app_router.dart';
import '../config/app_config.dart';
import '../connectivity/connectivity_service.dart';
import '../device/device_info_service.dart';
import '../logger/logger_service.dart';
import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/network_info.dart';
import '../notifications/notification_service.dart';
import '../services/localization_service.dart';
import '../storage/preferences_service.dart';
import '../storage/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> configureDependencies(AppConfig appConfig) async {
  // Logger
  final logger = LoggerService(appConfig.environment);
  sl.registerLazySingleton<LoggerService>(() => logger);

  // App Observer
  sl.registerLazySingleton<AppObserver>(() => AppObserver(logger: logger));

  // FlutterSecureStorage
  final secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(storage: secureStorage),
  );

  // SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<PreferencesService>(
    () => PreferencesService(sharedPrefs),
  );

  // Connectivity
  final connectivity = Connectivity();
  sl.registerLazySingleton<Connectivity>(() => connectivity);
  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(connectivity: connectivity),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: connectivity),
  );

  // Device Info
  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());
  sl.registerLazySingleton<DeviceInfoService>(
    () => DeviceInfoService(deviceInfo: DeviceInfoPlugin()),
  );

  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(
      secureStorage: sl(),
      logger: sl(),
      dioFactory: () => sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      appConfig: appConfig,
      logger: sl(),
      authInterceptor: sl(),
    ),
  );

  // Services
  sl.registerLazySingleton<LocalizationService>(() => LocalizationService());
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(logger: sl()),
  );

  // App Config
  sl.registerLazySingleton<AppConfig>(() => appConfig);

  // Router
  sl.registerLazySingleton<AppRouter>(() => AppRouter());
}
