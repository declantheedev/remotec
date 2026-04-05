import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';

// Theme toggle provider — lives here for global access
import 'package:flutter/material.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) {
          final tab = state.uri.queryParameters['tab'] ?? 'login';
          return AuthScreen(initialTab: tab);
        },
      ),
    ],
  );
});