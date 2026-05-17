import 'package:flutter/material.dart';
import 'package:flutter_startup_kit/app/theme/app_colors.dart';
import 'package:flutter_startup_kit/app/theme/app_spacing.dart';
import 'package:flutter_startup_kit/shared/widgets/app_button.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.message,
    super.key,
    this.title,
    this.onRetry,
    this.icon,
  });
  final String? title;
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: AppSpacing.lg),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey600),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              AppButton(
                label: 'Try Again',
                onPressed: onRetry,
                type: ButtonType.outline,
                width: 160,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
