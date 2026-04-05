import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class TextLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double fontSize;

  const TextLink({
    super.key,
    required this.label,
    required this.onTap,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyles.link.copyWith(fontSize: fontSize),
      ),
    );
  }
}