import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    surface: AppColors.darkSurface,
    error: AppColors.error,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: TextTheme(
    displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.white),
    displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.white),
    displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.white),
    headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.white),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.white),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.white),
    titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.white),
    titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.white),
    titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.white),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.white),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
    bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
    labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
    labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.white),
    labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.white),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 1,
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.white,
      minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      textStyle: AppTextStyles.button,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      side: const BorderSide(color: AppColors.primaryLight),
      minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCard,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      borderSide: const BorderSide(color: AppColors.grey700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      borderSide: const BorderSide(color: AppColors.grey700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey400),
    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey500),
    errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
  ),
  cardTheme: CardThemeData(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
    ),
    color: AppColors.darkCard,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.grey500,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.grey700,
    thickness: 1,
    space: 1,
  ),
);
