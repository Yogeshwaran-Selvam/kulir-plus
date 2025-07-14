import '/features/menu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '/core/core.dart';
import '/features/features.dart';
import 'routes.dart';

class AppRouter {
  // Main route generator with transition support
  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    String transitionType = RouteTransitions.slideTransition,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    switch (settings.name) {
      case RouteNames.auth:
        return _buildRoute(LoginPage(), settings, transitionType, duration);
      case RouteNames.splash:
        return _buildRoute(LoadingScreen(), settings, transitionType, duration);
      case RouteNames.home:
        return _buildRoute(HomePage(), settings, transitionType, duration);
      case RouteNames.acDetails:
        return _buildRoute(
          AcDetails(ac: settings.arguments as ACModel),
          settings,
          transitionType,
          duration,
        );
      case RouteNames.addAc:
        return _buildRoute(AddACPage(), settings, transitionType, duration);
      case RouteNames.chat:
        return _buildRoute(ACChatPage(), settings, transitionType, duration);
      case RouteNames.addSchedule:
        return _buildRoute(
          AddSchedulePage(id: settings.arguments as int),
          settings,
          transitionType,
          duration,
        );
      case RouteNames.contactUs:
        return _buildRoute(ContactUsPage(), settings, transitionType, duration);
      case RouteNames.about:
        return _buildRoute(ACChatPage(), settings, transitionType, duration);
      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
          transitionType,
          duration,
        );
    }
  }

  // Route builder with transitions
  static PageRouteBuilder _buildRoute(
    Widget page,
    RouteSettings settings,
    String transitionType,
    Duration duration,
  ) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case RouteTransitions.fadeTransition:
            return RouteTransitions.fadeTransitionBuilder(animation, child);
          case RouteTransitions.scaleTransition:
            return RouteTransitions.scaleTransitionBuilder(animation, child);
          default:
            return RouteTransitions.slideTransitionBuilder(animation, child);
        }
      },
    );
  }

  // Navigation methods with transition support
  static void push(
    BuildContext context,
    String routeName, {
    Object? arguments,
    String transition = RouteTransitions.slideTransition,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    Navigator.push(
      context,
      generateRoute(
        RouteSettings(name: routeName, arguments: arguments),
        transitionType: transition,
        duration: duration,
      ),
    );
  }

  static void pushAndRemoveUntil(
    BuildContext context,
    String routeName, {
    Object? arguments,
    String transition = RouteTransitions.slideTransition,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(
        RouteSettings(name: routeName, arguments: arguments),
        transitionType: transition,
        duration: duration,
      ),
      (route) => false,
    );
  }

  static void replace(
    BuildContext context,
    String routeName, {
    Object? arguments,
    String transition = RouteTransitions.slideTransition,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Navigator.pushReplacement(
      context,
      generateRoute(
        RouteSettings(name: routeName, arguments: arguments),
        transitionType: transition,
        duration: duration,
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
