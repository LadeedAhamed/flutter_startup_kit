enum AppEnvironment { dev, staging, prod }

enum RequestType { get, post, put, patch, delete }

enum AppThemeMode { light, dark, system }

enum LoadingState { idle, loading, loaded, error }

enum ButtonType { primary, secondary, outline, text }

enum DialogType { info, success, warning, error }

enum SnackBarType { success, error, warning, info }

enum StatusCode {
  success(200),
  created(201),
  noContent(204),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  tooManyRequests(429),
  internalServerError(500),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504);

  final int code;
  const StatusCode(this.code);

  bool get isSuccess => code >= 200 && code < 300;
  bool get isClientError => code >= 400 && code < 500;
  bool get isServerError => code >= 500;
}
