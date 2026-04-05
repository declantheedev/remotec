import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // -- Display / Headers (Milker font)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Milker',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: AppColors.dark,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Milker',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: AppColors.dark,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Milker',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    color: AppColors.dark,
  );

  // -- Body (Inter font)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
  );

  // -- Labels / Buttons
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.white,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  // -- Link
  static const TextStyle link = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}