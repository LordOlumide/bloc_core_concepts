import 'package:bloc_core_concepts/constants/enums.dart';
import 'package:bloc_core_concepts/logic/cubits/internet_cubit.dart';
import "package:flutter/material.dart";
import '../../logic/cubits/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Internet availability display
            BlocBuilder<InternetCubit, InternetState>(
              bloc: BlocProvider.of<InternetCubit>(context),
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectivityType.Mobile) {
                  return const Text(
                    'Internet - Mobile',
                    style: TextStyle(fontSize: 30),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectivityType.Wifi) {
                  return const Text(
                    'Internet - Wi-Fi',
                    style: TextStyle(fontSize: 30),
                  );
                } else if (state is InternetDisconnected) {
                  return const Text(
                    'No Internet',
                    style: TextStyle(fontSize: 30),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),

            // Counter Text display
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('incremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('decremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),

            // Counter and Internet multi display
            const SizedBox(height: 20),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>();
                final internetState = context.watch<InternetCubit>();

                return Text('Counter: ${counterState.state.counterValue}  '
                    'InternetState: ${internetState.state.runtimeType}'
                );
              },
            ),

            // Add and subtract buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  child: const Icon(Icons.exposure_minus_1),
                ),
                const SizedBox(width: 30),
                FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: const Icon(Icons.plus_one),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Push to second screen button
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Go to second screen'),
            ),
            const SizedBox(height: 30),

            // push to third screen button
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: const Text('Go to third screen'),
            ),
          ],
        ),
      ),
    );
  }
}
