import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';
import '../../logger/logger_service.dart';

class ErrorInterceptor extends Interceptor {

  ErrorInterceptor({required LoggerService logger}) : _logger = logger;
  final LoggerService _logger;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = _handleDioException(err);
    handler.reject(error);
  }

  DioException _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(message: 'Connection timed out. Please try again.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractErrorMessage(error.response?.data);

        switch (statusCode) {
          case 400:
            final data = error.response?.data;
            final errors = data is Map ? data['errors'] : null;
            throw ValidationException(
              message: message,
              errors: errors as Map<String, String>?,
            );
          case 401:
            throw AuthException(message: message);
          case 403:
            throw AuthException(message: 'Access denied');
          case 404:
            throw ServerException(message: 'Resource not found', statusCode: 404);
          case 429:
            throw ServerException(message: 'Too many requests', statusCode: 429);
          case 500:
          case 502:
          case 503:
            throw ServerException(
              message: 'Server error occurred',
              statusCode: statusCode,
            );
          default:
            throw ServerException(message: message, statusCode: statusCode);
        }

      case DioExceptionType.cancel:
        throw ServerException(message: 'Request cancelled');

      case DioExceptionType.connectionError:
        throw NetworkException(message: 'No internet connection');

      default:
        throw ServerException(message: error.message ?? 'An unexpected error occurred');
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is String) return data;
    if (data is Map) {
      return data['message'] as String? ??
          data['error'] as String? ??
          'An error occurred';
    }
    return 'An error occurred';
  }
}
