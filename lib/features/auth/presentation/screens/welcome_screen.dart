import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/text_link.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // ── Background image
          _BackgroundImage(isDark: isDark),

          // ── Gradient overlay (top fade for logo visibility)
          _TopGradientOverlay(isDark: isDark),

          // ── Logo pinned to top
          const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 24),
                child: AppLogo(fontSize: 28),
              ),
            ),
          ),

          // ── Bottom content card
          Align(
            alignment: Alignment.bottomCenter,
            child: _WelcomeBottomCard(isDark: isDark),
          ),
        ],
      ),
    );
  }
}

// ── Background image
class _BackgroundImage extends StatelessWidget {
  final bool isDark;

  const _BackgroundImage({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        AppAssets.welcomeBg,
        fit: BoxFit.cover,
        // Fallback if image not set yet
        errorBuilder: (_, __, ___) => Container(
          color: isDark ? AppColors.darkBackground : const Color(0xFF2C2C2C),
        ),
      ),
    );
  }
}

// ── Top gradient overlay so logo stays readable
class _TopGradientOverlay extends StatelessWidget {
  final bool isDark;

  const _TopGradientOverlay({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 160,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              (isDark ? AppColors.darkBackground : Colors.black)
                  .withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Bottom card with headline + buttons
class _WelcomeBottomCard extends StatelessWidget {
  final bool isDark;

  const _WelcomeBottomCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground.withOpacity(0.92)
            : AppColors.white.withOpacity(0.96),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isDark
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // Headline
          Text(
            AppStrings.welcomeTagline.toUpperCase(),
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: 36,
              height: 1.1,
              color: isDark ? AppColors.white : AppColors.dark,
            ),
          ),

          const SizedBox(height: 12),

          // Subtitle
          Text(
            AppStrings.welcomeSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              height: 1.5,
            ),
            textAlign: isDark ? TextAlign.center : TextAlign.left,
          ),

          const SizedBox(height: 36),

          // Get Started button
          PrimaryButton(
            label: AppStrings.getStarted,
            onPressed: () => context.go('/auth?tab=signup'),
          ),

          const SizedBox(height: 20),

          // Sign In link
          Center(
            child: TextLink(
              label: AppStrings.signIn,
              fontSize: 16,
              onTap: () => context.go('/auth?tab=login'),
            ),
          ),
        ],
      ),
    );
  }
}