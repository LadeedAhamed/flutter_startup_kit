import 'package:flutter/material.dart';
import 'package:flutter_startup_kit/app/theme/app_colors.dart';
import 'package:flutter_startup_kit/app/theme/app_spacing.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    required this.message,
    super.key,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.action,
  });
  final String? title;
  final String message;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 80, color: AppColors.grey400),
            const SizedBox(height: AppSpacing.xl),
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
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey500),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
