import 'package:bloc_core_concepts/UI/screens/second_screen.dart';
import 'package:bloc_core_concepts/UI/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubits/counter_cubit.dart';
import 'UI/screens/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider.value(
          value: _counterCubit,
          child: const FirstScreen(title: 'First screen'),
        ),
        '/second': (context) => BlocProvider.value(
          value: _counterCubit,
          child: const SecondScreen(title: 'Second screen', color: Colors.red),
        ),
        '/third': (context) => BlocProvider.value(
          value: _counterCubit,
          child: const ThirdScreen(title: 'Third screen', color: Colors.grey),
        ),
      },
    );
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}
