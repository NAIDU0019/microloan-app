import 'package:go_router/go_router.dart';
import 'package:microloan_app/screens/home_screen.dart';
import 'package:microloan_app/screens/insurance_screen.dart';
import 'package:microloan_app/screens/profile_screen.dart';
import 'package:microloan_app/screens/support_screen.dart';
import 'package:microloan_app/screens/wallet_screen.dart';

class MainStack {
  static final routes = [
    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/wallet',
      name: AppRoutes.wallet,
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/support',
      name: AppRoutes.support,
      builder: (context, state) => const SupportScreen(),
    ),
    GoRoute(
      path: '/insurance',
      name: AppRoutes.insurance,
      builder: (context, state) => const InsuranceScreen(),
    ),
  ];
}