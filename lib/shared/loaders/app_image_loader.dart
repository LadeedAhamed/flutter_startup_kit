import 'package:flutter/material.dart';
import 'package:flutter_startup_kit/app/theme/app_colors.dart';

class AppImageLoader extends StatelessWidget {
  const AppImageLoader({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.grey200,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
