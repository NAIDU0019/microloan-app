import 'package:go_router/go_router.dart';
import 'package:microloan_app/screens/loan_apply_screen.dart';
import 'package:microloan_app/screens/loan_status_screen.dart';
import 'package:microloan_app/screens/payment_screen.dart';
import 'package:microloan_app/screens/shg_dashboard.dart';

class LoanStack {
  static final routes = [
    GoRoute(
      path: '/loans/apply',
      name: AppRoutes.loanApply,
      builder: (context, state) => const LoanApplyScreen(),
    ),
    GoRoute(
      path: '/loans/status/:loanId',
      name: AppRoutes.loanStatus,
      builder: (context, state) => LoanStatusScreen(
        loanId: state.pathParameters['loanId']!,
      ),
    ),
    GoRoute(
      path: '/loans/payment/:loanId',
      name: AppRoutes.payment,
      builder: (context, state) => PaymentScreen(
        loanId: state.pathParameters['loanId']!,
      ),
    ),
    GoRoute(
      path: '/shg/dashboard',
      name: AppRoutes.shgDashboard,
      builder: (context, state) => const SHGDashboard(),
    ),
  ];
}