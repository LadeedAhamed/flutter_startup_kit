import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoService {

  DeviceInfoService({DeviceInfoPlugin? deviceInfo})
      : _deviceInfo = deviceInfo ?? DeviceInfoPlugin();
  final DeviceInfoPlugin _deviceInfo;
  PackageInfo? _packageInfo;

  Future<PackageInfo> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  Future<String> get appVersion async {
    final info = await packageInfo;
    return '${info.version}+${info.buildNumber}';
  }

  Future<String> get appName async {
    final info = await packageInfo;
    return info.appName;
  }

  Future<String> get packageName async {
    final info = await packageInfo;
    return info.packageName;
  }

  Future<BaseDeviceInfo> get deviceInfo async {
    return await _deviceInfo.deviceInfo;
  }

  Future<String> get deviceModel async {
    final info = await deviceInfo;
    if (info is IosDeviceInfo) return info.model;
    if (info is AndroidDeviceInfo) return info.model;
    return 'Unknown';
  }

  Future<String> get osVersion async {
    final info = await deviceInfo;
    if (info is IosDeviceInfo) return info.systemVersion;
    if (info is AndroidDeviceInfo) return info.version.release;
    return 'Unknown';
  }
}
