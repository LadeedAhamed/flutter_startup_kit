import 'package:dio/dio.dart';
import '../../storage/secure_storage_service.dart';
import '../../constants/api_constants.dart';
import '../../constants/app_constants.dart';
import '../../logger/logger_service.dart';

class AuthInterceptor extends Interceptor {

  AuthInterceptor({
    required SecureStorageService secureStorage,
    required LoggerService logger,
    required Dio Function() dioFactory,
  })  : _secureStorage = secureStorage,
        _logger = logger,
        _dioFactory = dioFactory;
  final SecureStorageService _secureStorage;
  final LoggerService _logger;
  final Dio Function() _dioFactory;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(AppConstants.tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] = '${ApiConstants.bearer} $token';
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        await _refreshToken();
        final token = await _secureStorage.read(AppConstants.tokenKey);
        if (token != null) {
          final options = err.requestOptions;
          options.headers[ApiConstants.authorization] = '${ApiConstants.bearer} $token';
          final response = await _dioFactory().fetch(options);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        _logger.error('Token refresh failed', e);
        await _handleLogout();
      }
    }
    handler.next(err);
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _secureStorage.read(AppConstants.refreshTokenKey);
    if (refreshToken == null) throw Exception('No refresh token available');

    final dio = _dioFactory();
    final response = await dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    final data = response.data as Map<String, dynamic>;
    final newToken = data['accessToken'] as String;
    final newRefreshToken = data['refreshToken'] as String;

    await _secureStorage.write(AppConstants.tokenKey, newToken);
    await _secureStorage.write(AppConstants.refreshTokenKey, newRefreshToken);
  }

  Future<void> _handleLogout() async {
    await _secureStorage.delete(AppConstants.tokenKey);
    await _secureStorage.delete(AppConstants.refreshTokenKey);
  }
}
