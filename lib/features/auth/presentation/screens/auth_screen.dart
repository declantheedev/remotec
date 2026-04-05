import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/text_link.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final String initialTab;
  const AuthScreen({super.key, required this.initialTab});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  late bool isLogin;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLogin = widget.initialTab == 'login';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleTab(bool login) {
    setState(() {
      isLogin = login;
      // Optionally clear fields on tab switch
      _emailController.clear();
      _passwordController.clear();
    });
  }

  bool _isEmailValid(String email) {
    if (email.isEmpty) return false;
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  String? _emailFeedback() {
    final email = _emailController.text;
    if (email.isEmpty) return null;
    if (!_isEmailValid(email)) return "Invalid email address";
    return null;
  }

  Color? _emailBorderColor(bool isDark) {
    final email = _emailController.text;
    if (email.isEmpty) return null; // use default
    if (!_isEmailValid(email)) return AppColors.error;
    return AppColors.success;
  }

  String? _passwordFeedback() {
    final pass = _passwordController.text;
    if (pass.isEmpty) return null;
    if (pass.length < 6) return "Password is too short";
    if (pass.length < 8) return "Password is too weak";
    return "Excellent";
  }

  Color? _passwordBorderColor(bool isDark) {
    final pass = _passwordController.text;
    if (pass.isEmpty) return null;
    if (pass.length < 8) return AppColors.error;
    return AppColors.success;
  }

  Color _passwordFeedbackColor() {
    final pass = _passwordController.text;
    if (pass.length < 8) return AppColors.error;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(AppAssets.authBg, fit: BoxFit.cover),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              color: isDark
                  ? AppColors.darkBackground.withOpacity(0.65)
                  : AppColors.lightBackground.withOpacity(0.65),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Theme Toggle at top
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: const EdgeInsets.all(16),
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                    onPressed: () {
                      ref.read(themeModeProvider.notifier).state = isDark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                    },
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),

                        // Tab Toggle
                        Center(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.lightBackground
                                  : AppColors.darkBackground,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildTabButton(
                                  title: 'Sign Up',
                                  isActive: !isLogin,
                                  isDark: isDark,
                                  onTap: () => _toggleTab(false),
                                ),
                                _buildTabButton(
                                  title: 'Log In',
                                  isActive: isLogin,
                                  isDark: isDark,
                                  onTap: () => _toggleTab(true),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Title
                        Text(
                          isLogin ? 'WELCOME BACK' : 'WELCOME TO REMOTE',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.displayMedium.copyWith(
                            color: isDark ? AppColors.white : AppColors.dark,
                            letterSpacing: 1.2,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Email Input
                        _buildGlassInput(
                          isDark: isDark,
                          hint: 'Enter Your Email',
                          controller: _emailController,
                          onChanged: (_) => setState(() {}),
                          borderColorOverride: _emailBorderColor(isDark),
                          feedbackText: _emailFeedback(),
                          feedbackColor: AppColors.error,
                        ),

                        const SizedBox(height: 20),

                        // Password Input
                        _buildGlassInput(
                          isDark: isDark,
                          hint: 'Password',
                          obscureText: true,
                          controller: _passwordController,
                          onChanged: (_) => setState(() {}),
                          borderColorOverride: _passwordBorderColor(isDark),
                          feedbackText: _passwordFeedback(),
                          feedbackColor: _passwordFeedbackColor(),
                        ),

                        const SizedBox(height: 12),

                        // Forgot Password Space / Link
                        if (isLogin)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: isDark
                                    ? AppColors.white
                                    : AppColors.dark,
                              ),
                            ),
                          )
                        else
                          const SizedBox(height: 14),

                        const SizedBox(height: 32),

                        // Submit Button
                        PrimaryButton(
                          label: isLogin ? 'Login' : 'Sign Up',
                          onPressed: () {},
                        ),

                        const SizedBox(height: 20),

                        // Google Button
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.black.withOpacity(0.05),
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.black.withOpacity(0.2),
                                ),
                              ),
                              icon: Image.asset(
                                AppAssets.googleLogo,
                                height: 20,
                                width: 20,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.g_mobiledata,
                                      color: AppColors.primary,
                                    ),
                              ),
                              label: Text(
                                isLogin
                                    ? 'Login With Google'
                                    : 'Signup With Google',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Bottom Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin
                                  ? "Don't have an account? "
                                  : "Already have an account? ",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isDark
                                    ? AppColors.white
                                    : AppColors.darkTextPrimary,
                              ),
                            ),
                            TextLink(
                              label: isLogin ? 'Sign Up' : 'Log In',
                              onTap: () => _toggleTab(!isLogin),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassInput({
    required bool isDark,
    required String hint,
    required TextEditingController controller,
    required void Function(String) onChanged,
    Color? borderColorOverride,
    String? feedbackText,
    Color? feedbackColor,
    bool obscureText = false,
  }) {
    final defaultBorderColor = isDark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.2);
    final borderColor = borderColorOverride ?? defaultBorderColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              obscureText: obscureText,
              style: AppTextStyles.bodyLarge.copyWith(
                color: isDark ? AppColors.white : AppColors.dark,
              ),
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),
              ),
            ),
          ),
        ),
        if (feedbackText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              feedbackText,
              style: AppTextStyles.bodySmall.copyWith(
                color: feedbackColor ?? AppColors.error,
              ),
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isActive,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: AppTextStyles.labelMedium.copyWith(
            color: isActive
                ? AppColors.white
                : (isDark ? AppColors.dark : AppColors.white),
          ),
        ),
      ),
    );
  }
}
