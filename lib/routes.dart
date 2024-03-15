import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:skylightDemo/bottomNav.dart';
import 'package:skylightDemo/features/auth/login.dart';
import 'package:skylightDemo/features/home/pages/home.dart';
class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget page;
}

enum Routes { login, home, inntial }

class Paths {
  // static const String splash = '/';
  static const String navigation = '/navigaton';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const Map<Routes, String> _pathMap = {
    // Routes.splash: Paths.splash,
    Routes.login: Paths.login,
    Routes.home: Paths.login
  };

  // static String of(Routes route) => _pathMap[route] ?? splash;
  static String of(Routes route) => _pathMap[route] ?? login;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Paths.home:
        return FadeRoute(page: const HomePage());
      case Paths.navigation:
        return FadeRoute(page: const AppNavigationBar());

    }
    return FadeRoute(page: const LoginPage());
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
