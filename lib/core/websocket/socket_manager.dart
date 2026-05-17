import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../logger/logger_service.dart';

class SocketManager {

  SocketManager(this._logger);
  final LoggerService _logger;
  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _eventController;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  String? _url;
  Map<String, dynamic>? _headers;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _reconnectDelay = Duration(seconds: 5);
  static const Duration _heartbeatInterval = Duration(seconds: 30);

  Stream<Map<String, dynamic>>? get events => _eventController?.stream;
  bool get isConnected => _isConnected;

  Future<void> connect(String url, {Map<String, dynamic>? headers}) async {
    _url = url;
    _headers = headers;
    _shouldReconnect = true;

    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(url),
      );
      _isConnected = true;
      _reconnectAttempts = 0;
      _eventController = StreamController<Map<String, dynamic>>.broadcast();
      _logger.debug('WebSocket connected to $url');

      _startHeartbeat();
      _listenForMessages();
    } catch (e) {
      _logger.error('WebSocket connection failed', e);
      _scheduleReconnect();
    }
  }

  void _listenForMessages() {
    _channel?.stream.listen(
      (data) {
        try {
          final decoded = jsonDecode(data as String) as Map<String, dynamic>;
          _eventController?.add(decoded);
          _logger.debug('WebSocket received: $decoded');
        } catch (e) {
          _logger.error('Failed to parse WebSocket message', e);
        }
      },
      onError: (error) {
        _logger.error('WebSocket error', error);
        _handleDisconnect();
      },
      onDone: () {
        _logger.debug('WebSocket connection closed');
        _handleDisconnect();
      },
    );
  }

  void _handleDisconnect() {
    _isConnected = false;
    _stopHeartbeat();
    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logger.error('Max reconnect attempts reached');
      return;
    }

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, () {
      _reconnectAttempts++;
      _logger.debug('Reconnecting... attempt $_reconnectAttempts');
      if (_url != null) {
        connect(_url!, headers: _headers);
      }
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      send({'type': 'ping'});
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void send(Map<String, dynamic> data) {
    if (_channel != null && _isConnected) {
      _channel!.sink.add(jsonEncode(data));
      _logger.debug('WebSocket sent: $data');
    }
  }

  void sendRaw(String data) {
    if (_channel != null && _isConnected) {
      _channel!.sink.add(data);
    }
  }

  void disconnect() {
    _shouldReconnect = false;
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _eventController?.close();
    _logger.debug('WebSocket disconnected');
  }

  void dispose() {
    disconnect();
    _eventController = null;
  }
}
