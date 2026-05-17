import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mediaQuerySize => mediaQuery.size;
  double get height => mediaQuerySize.height;
  double get width => mediaQuerySize.width;

  double dynamicHeight(double value) => height * value;
  double dynamicWidth(double value) => width * value;

  NavigatorState get navigator => Navigator.of(this);

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments}) {
    return navigator.pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }

  void pop<T>([T? result]) => navigator.pop<T>(result);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  void showSnackBar(String message, {SnackBarType type = SnackBarType.info}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  double screenHeight({double dividedBy = 1}) => mediaQuerySize.height / dividedBy;
  double screenWidth({double dividedBy = 1}) => mediaQuerySize.width / dividedBy;
}

enum SnackBarType { info, success, warning, error }
