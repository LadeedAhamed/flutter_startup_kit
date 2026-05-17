import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final T? data;
  final ApiError? error;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null && fromJsonT != null ? fromJsonT(json['data']) : null,
      error: json['error'] != null ? ApiError.fromJson(json['error'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : null,
      'error': error?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, message, data, error];
}

class ApiError extends Equatable {
  final int? statusCode;
  final String message;
  final Map<String, dynamic>? errors;

  const ApiError({
    this.statusCode,
    required this.message,
    this.errors,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String? ?? 'Unknown error',
      errors: json['errors'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'errors': errors,
    };
  }

  @override
  List<Object?> get props => [statusCode, message, errors];
}

class PaginatedResponse<T> extends Equatable {
  final List<T> data;
  final int total;
  final int page;
  final int pageSize;
  final bool hasMore;

  const PaginatedResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return PaginatedResponse(
      data: json['data'] != null && fromJsonT != null
          ? (json['data'] as List).map((e) => fromJsonT(e)).toList()
          : [],
      total: json['total'] as int,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      hasMore: json['hasMore'] as bool,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value)? toJsonT) {
    return {
      'data': data.map((e) => toJsonT!(e)).toList(),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'hasMore': hasMore,
    };
  }

  @override
  List<Object?> get props => [data, total, page, pageSize, hasMore];
}
