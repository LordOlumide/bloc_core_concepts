import 'package:bloc_core_concepts/UI/screens/first_screen.dart';
import 'package:bloc_core_concepts/UI/screens/second_screen.dart';
import 'package:bloc_core_concepts/UI/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/'):
        return MaterialPageRoute(
            builder: (context) => const FirstScreen(title: 'First screen'));
      case ('/second'):
        return MaterialPageRoute(
            builder: (context) =>
                const SecondScreen(title: 'Second screen', color: Colors.red));
      case ('/third'):
        return MaterialPageRoute(
            builder: (context) =>
                const ThirdScreen(title: 'Third screen', color: Colors.grey));

      default:
        return MaterialPageRoute(
            builder: (context) => const FirstScreen(title: 'First screen'));
    }
  }
}
