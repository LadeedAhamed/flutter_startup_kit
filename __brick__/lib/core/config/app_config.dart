import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../enums/app_enums.dart';

class AppConfig {
  final AppEnvironment environment;
  late final String baseUrl;
  late final String socketUrl;
  late final String appName;

  AppConfig(this.environment) {
    baseUrl = dotenv.get('BASE_URL', fallback: 'https://api.example.com');
    socketUrl = dotenv.get('SOCKET_URL', fallback: 'wss://socket.example.com');
    appName = dotenv.get('APP_NAME', fallback: 'StartupKit');
  }

  bool get isDev => environment == AppEnvironment.dev;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.prod;

  static Future<AppConfig> load(AppEnvironment env) async {
    final envFile = _getEnvFileName(env);
    await dotenv.load(fileName: envFile);
    return AppConfig(env);
  }

  static String _getEnvFileName(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.dev:
        return '.env.dev';
      case AppEnvironment.staging:
        return '.env.staging';
      case AppEnvironment.prod:
        return '.env.prod';
    }
  }
}
