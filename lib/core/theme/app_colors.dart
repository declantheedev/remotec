import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFFFF6A00);
  static const Color primaryDark = Color(0xFFCC5500); // pressed state

  // Neutrals
  static const Color dark = Color(0xFF1E1E1E);
  static const Color stroke = Color(0xFFE0E0E0);
  static const Color white = Color(0xFFFFFFFF);

  // Light theme surfaces
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1E1E1E);
  static const Color lightTextSecondary = Color(0xFF6B6B6B);
  static const Color lightInputFill = Color(0xFFFFFFFF);

  // Dark theme surfaces
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2A2A2A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFAAAAAA);
  static const Color darkInputFill = Color(0xFF2A2A2A);

  // Semantic
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
}