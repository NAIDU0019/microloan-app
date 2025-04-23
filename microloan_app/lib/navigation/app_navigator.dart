import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:microloan_app/routes.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = 
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      ...AuthStack.routes,
      ...MainStack.routes,
      ...LoanStack.routes,
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // Add your authentication redirect logic here
      final isLoggedIn = false; // Replace with actual auth state
      final isOnAuthPage = state.matchedLocation.startsWith('/auth');

      if (!isLoggedIn && !isOnAuthPage) {
        return AppRoutes.login;
      }

      if (isLoggedIn && isOnAuthPage) {
        return AppRoutes.home;
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );

  static void pushNamed(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }

  static void pushReplacementNamed(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
}