import 'package:bloc_core_concepts/UI/screens/second_screen.dart';
import 'package:bloc_core_concepts/UI/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubits/counter_cubit.dart';
import 'UI/screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const FirstScreen(title: 'First screen'),
          '/second': (context) =>
              const SecondScreen(title: 'Second screen', color: Colors.red),
          '/third': (context) =>
              const ThirdScreen(title: 'Third screen', color: Colors.grey),
        },
      ),
    );
  }
}
