import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_radius.dart';

class AppButton extends StatelessWidget {

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.type = ButtonType.primary,
    this.width,
    this.height = AppSpacing.buttonHeight,
    this.icon,
    this.padding,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonType type;
  final double? width;
  final double? height;
  final IconData? icon;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final disabled = isDisabled || isLoading;
    final effectiveOnPressed = disabled ? null : onPressed;

    switch (type) {
      case ButtonType.primary:
        return _buildElevatedButton(effectiveOnPressed);
      case ButtonType.secondary:
        return _buildSecondaryButton(effectiveOnPressed);
      case ButtonType.outline:
        return _buildOutlinedButton(effectiveOnPressed);
      case ButtonType.text:
        return _buildTextButton(effectiveOnPressed);
    }
  }

  Widget _buildElevatedButton(VoidCallback? onPressed) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildSecondaryButton(VoidCallback? onPressed) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildOutlinedButton(VoidCallback? onPressed) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildTextButton(VoidCallback? onPressed) {
    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    }

    return Text(label);
  }
}

enum ButtonType { primary, secondary, outline, text }
