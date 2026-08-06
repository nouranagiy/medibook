import 'package:go_router/go_router.dart';
import 'package:medibook/features/auth/presentation/screens/login_screen.dart';
import 'package:medibook/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:medibook/features/splash/presentation/screens/splash_screen.dart';
import 'app_routes.dart';
class AppRouter {
  AppRouter._();
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
    ],
  );}