import 'package:cible_controller/views/welcome/welcome.screen.dart';
import 'package:cible_controller/views/code/code.screen.dart';
import 'package:flutter/material.dart';

import 'package:cible_controller/main.dart';

var routes = {
  '/': (context) => const WelcomeScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/code': (context) => const CodeScreen(),
};

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return const WelcomeScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
      case "/scan":
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return CodeScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
      case "/welcome":
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return WelcomeScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return new WelcomeScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
    }
  }
}
