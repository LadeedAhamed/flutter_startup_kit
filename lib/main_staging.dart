import 'package:flutter/material.dart';
import 'app/bootstrap.dart';
import 'core/enums/app_enums.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(AppEnvironment.staging);
}
