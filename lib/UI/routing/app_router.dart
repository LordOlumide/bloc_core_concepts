import 'package:bloc_core_concepts/UI/screens/first_screen.dart';
import 'package:bloc_core_concepts/UI/screens/second_screen.dart';
import 'package:bloc_core_concepts/UI/screens/third_screen.dart';
import 'package:bloc_core_concepts/logic/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/'):
        return MaterialPageRoute(builder: (context) => BlocProvider.value(
          value: _counterCubit,
          child: const FirstScreen(title: 'First screen'),
        ));
      case ('/second'):
        return MaterialPageRoute(builder: (context) => BlocProvider.value(
          value: _counterCubit,
          child: const SecondScreen(title: 'Second screen', color: Colors.red),
        ));
      case('/third'):
        return MaterialPageRoute(builder: (context) => BlocProvider.value(
          value: _counterCubit,
          child: const ThirdScreen(title: 'Third screen', color: Colors.grey),
        ));

      default:
        return MaterialPageRoute(builder: (context) => BlocProvider.value(
          value: _counterCubit,
          child: const FirstScreen(title: 'First screen'),
        ));
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}