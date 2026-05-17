import 'package:logger/logger.dart';
import '../enums/app_enums.dart';

class LoggerService {

  LoggerService(this._environment) {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      level: _environment == AppEnvironment.prod ? Level.warning : Level.debug,
    );
  }
  late final Logger _logger;
  final AppEnvironment _environment;

  void debug(String message) {
    _logger.d(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void error(String message, [dynamic error]) {
    _logger.e(message, error: error);
  }

  void api(String method, String path, {int? statusCode, dynamic request, dynamic response, Duration? duration}) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('🌐 API Request: $method $path');
    if (statusCode != null) buffer.writeln('📊 Status: $statusCode');
    if (duration != null) buffer.writeln('⏱️ Duration: ${duration.inMilliseconds}ms');
    if (request != null) buffer.writeln('📤 Request: $request');
    if (response != null) buffer.writeln('📥 Response: $response');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    _logger.i(buffer.toString());
  }
}
