import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  const Failure({required this.message, this.statusCode});
  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode = 401});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, this.errors, super.statusCode});
  final Map<String, String>? errors;
}

class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.statusCode});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.statusCode = 404});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.statusCode});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message, super.statusCode});
}
