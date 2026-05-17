class ServerException implements Exception {

  ServerException({required this.message, this.statusCode, this.response});
  final String message;
  final int? statusCode;
  final dynamic response;

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class CacheException implements Exception {

  CacheException({required this.message});
  final String message;

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {

  NetworkException({required this.message});
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {

  AuthException({required this.message});
  final String message;

  @override
  String toString() => 'AuthException: $message';
}

class ValidationException implements Exception {

  ValidationException({required this.message, this.errors});
  final String message;
  final Map<String, String>? errors;

  @override
  String toString() => 'ValidationException: $message';
}

class PermissionException implements Exception {

  PermissionException({required this.message});
  final String message;

  @override
  String toString() => 'PermissionException: $message';
}

class TimeoutException implements Exception {

  TimeoutException({required this.message});
  final String message;

  @override
  String toString() => 'TimeoutException: $message';
}
