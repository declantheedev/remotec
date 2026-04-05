import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  final double fontSize;
  final Color? color;

  const AppLogo({
    super.key,
    this.fontSize = 28,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'REMOTE',
      style: AppTextStyles.displayMedium.copyWith(
        fontFamily: 'Milker',
        fontSize: fontSize,
        letterSpacing: 6,
        color: color ?? AppColors.primary,
      ),
    );
  }
}