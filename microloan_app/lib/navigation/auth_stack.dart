import 'package:go_router/go_router.dart';
import 'package:microloan_app/screens/login_screen.dart';
import 'package:microloan_app/screens/otp_screen.dart';
import 'package:microloan_app/screens/register_screen.dart';
import 'package:microloan_app/screens/reset_password_screen.dart';

class AuthStack {
  static final routes = [
    GoRoute(
      path: '/auth/login',
      name: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      name: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/auth/otp',
      name: AppRoutes.otp,
      builder: (context, state) => OTPScreen(
        phoneNumber: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/auth/reset-password',
      name: AppRoutes.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),
  ];
}