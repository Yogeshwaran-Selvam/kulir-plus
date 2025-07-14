import 'package:flutter/material.dart';

class RouteTransitions {
  // Transition types
  static const String fadeTransition = 'fade';
  static const String slideTransition = 'slide';
  static const String scaleTransition = 'scale';


  // Transition builders
  static Widget fadeTransitionBuilder(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  static Widget slideTransitionBuilder(Animation<double> animation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOutQuart;
    
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget scaleTransitionBuilder(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      )),
      child: child,
    );
  }
}