import 'package:dio/dio.dart';
import '../../logger/logger_service.dart';

class LoggingInterceptor extends Interceptor {
  final LoggerService _logger;

  LoggingInterceptor({required LoggerService logger}) : _logger = logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.api(
      options.method,
      options.path,
      request: options.data,
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.api(
      response.requestOptions.method,
      response.requestOptions.path,
      statusCode: response.statusCode,
      response: response.data,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      '${err.requestOptions.method} ${err.requestOptions.path} failed: ${err.message}',
      err,
    );
    super.onError(err, handler);
  }
}
