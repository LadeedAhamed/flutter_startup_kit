import 'package:flutter/material.dart';
import 'package:flutter_startup_kit/app/theme/app_colors.dart';
import 'package:flutter_startup_kit/shared/loaders/app_image_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  const AppImage.svg({
    required this.assetPath,
    super.key,
    this.width,
    this.height,
    this.color,
  }) : url = null,
       fit = BoxFit.contain,
       borderRadius = null,
       placeholder = null,
       errorWidget = null,
       useSvg = true;

  const AppImage.network({
    required this.url,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.useSvg = false,
  }) : assetPath = null;

  const AppImage.asset({
    required this.assetPath,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.borderRadius,
    this.useSvg = false,
    this.placeholder,
    this.errorWidget,
  }) : url = null;
  final String? url;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useSvg;

  @override
  Widget build(BuildContext context) {
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: _buildImage());
    }
    return _buildImage();
  }

  Widget _buildImage() {
    if (useSvg && assetPath != null) {
      return SvgPicture.asset(
        assetPath!,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }

    if (url != null) {
      return _buildNetworkImage();
    }

    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        color: color,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildNetworkImage() {
    return Image.network(
      url!,
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? AppImageLoader(width: width, height: height);
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: AppColors.grey200,
              child: const Icon(
                Icons.broken_image_outlined,
                color: AppColors.grey500,
              ),
            );
      },
    );
  }
}
