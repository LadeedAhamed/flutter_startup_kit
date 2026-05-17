import '../network/api_response.dart';
import 'exceptions.dart';
import 'failures.dart';

class ErrorMapper {
  static Failure mapToFailure(ApiError error) {
    final code = error.statusCode;
    final message = error.message;

    switch (code) {
      case 400:
        return ValidationFailure(message: message);
      case 401:
        return AuthFailure(message: message);
      case 403:
        return AuthFailure(message: 'Forbidden: $message');
      case 404:
        return NotFoundFailure(message: message);
      case 429:
        return ServerFailure(message: 'Too many requests. Please try again later.');
      case 500:
      case 502:
      case 503:
        return ServerFailure(message: 'Server error. Please try again later.', statusCode: code);
      default:
        if (code != null && code >= 400 && code < 500) {
          return ServerFailure(message: message, statusCode: code);
        }
        return ServerFailure(message: message, statusCode: code);
    }
  }

  static Failure mapExceptionToFailure(dynamic error) {
    if (error is Failure) return error;

    if (error is ServerException) {
      return ServerFailure(message: error.message, statusCode: error.statusCode);
    }
    if (error is NetworkException) {
      return NetworkFailure(message: error.message);
    }
    if (error is CacheException) {
      return CacheFailure(message: error.message);
    }
    if (error is AuthException) {
      return AuthFailure(message: error.message);
    }
    if (error is ValidationException) {
      return ValidationFailure(message: error.message, errors: error.errors);
    }

    return UnexpectedFailure(message: error.toString());
  }
}
