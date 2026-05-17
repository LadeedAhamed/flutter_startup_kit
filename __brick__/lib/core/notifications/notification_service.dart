import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import '../logger/logger_service.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final LoggerService _logger;
  
  NotificationService({required LoggerService logger})
      : _firebaseMessaging = FirebaseMessaging.instance,
        _localNotifications = FlutterLocalNotificationsPlugin(),
        _logger = logger;

  Future<void> initialize() async {
    await _requestPermission();
    await _setupLocalNotifications();
    await _getFCMToken();
    _setupForegroundHandler();
    _setupBackgroundHandler();
    _setupNotificationTapHandler();
  }

  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    _logger.debug('Notification permission: ${settings.authorizationStatus}');
  }

  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  Future<void> _getFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      _logger.debug('FCM Token: $token');
    } catch (e) {
      _logger.error('Failed to get FCM token', e);
    }
  }

  void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _logger.debug('Foreground notification: ${message.notification?.title}');
      _showLocalNotification(message);
    });
  }

  void _setupBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  void _setupNotificationTapHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _logger.debug('Notification tapped: ${message.notification?.title}');
      _handleNotificationTap(message);
    });

    _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        _logger.debug('App opened from notification: ${message.notification?.title}');
        _handleNotificationTap(message);
      }
    });
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Override in app layer for deep linking
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle local notification tap
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  debugPrint('Background notification: ${message.notification?.title}');
}
