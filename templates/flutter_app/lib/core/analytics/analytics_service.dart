import 'package:firebase_analytics/firebase_analytics.dart';
import '../logger/logger_service.dart';

class AnalyticsService {

  AnalyticsService({required LoggerService logger})
      : _analytics = FirebaseAnalytics.instance,
        _logger = logger;
  final FirebaseAnalytics _analytics;
  final LoggerService _logger;

  FirebaseAnalytics get analytics => _analytics;

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
      _logger.debug('Analytics event: $name');
    } catch (e) {
      _logger.error('Failed to log analytics event', e);
    }
  }

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
    } catch (e) {
      _logger.error('Failed to log screen view', e);
    }
  }

  Future<void> setUserId(String? userId) async {
    try {
      await _analytics.setUserId(id: userId ?? '');
    } catch (e) {
      _logger.error('Failed to set user ID', e);
    }
  }

  Future<void> logLogin({String? method}) async {
    await logEvent(name: 'login', parameters: {'method': method ?? 'unknown'});
  }

  Future<void> logSignUp({String? method}) async {
    await logEvent(name: 'sign_up', parameters: {'method': method ?? 'unknown'});
  }

  Future<void> logShare({required String contentType, required String itemId}) async {
    await logEvent(
      name: 'share',
      parameters: {
        'content_type': contentType,
        'item_id': itemId,
      },
    );
  }
}
