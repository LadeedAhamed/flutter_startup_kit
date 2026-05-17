import 'package:permission_handler/permission_handler.dart' as ph;
import '../logger/logger_service.dart';

class PermissionService {

  PermissionService({required LoggerService logger}) : _logger = logger;
  final LoggerService _logger;

  Future<bool> requestCameraPermission() async {
    return _requestPermission(ph.Permission.camera);
  }

  Future<bool> requestStoragePermission() async {
    return _requestPermission(ph.Permission.storage);
  }

  Future<bool> requestLocationPermission() async {
    return _requestPermission(ph.Permission.location);
  }

  Future<bool> requestNotificationPermission() async {
    return _requestPermission(ph.Permission.notification);
  }

  Future<bool> requestPhotoLibraryPermission() async {
    return _requestPermission(ph.Permission.photos);
  }

  Future<bool> requestMicrophonePermission() async {
    return _requestPermission(ph.Permission.microphone);
  }

  Future<bool> _requestPermission(ph.Permission permission) async {
    try {
      final status = await permission.request();
      _logger.debug('Permission ${permission.toString()}: $status');
      return status.isGranted;
    } catch (e) {
      _logger.error('Permission request failed', e);
      return false;
    }
  }

  Future<bool> isPermissionGranted(ph.Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  Future<bool> isPermissionPermanentlyDenied(ph.Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }

  Future<void> openAppSettings() async {
    await ph.openAppSettings();
  }
}
