import 'package:bloc_core_concepts/logic/cubits/counter_cubit.dart';
import 'package:bloc_core_concepts/logic/cubits/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Tests for the counter cubit', () {
    InternetCubit internetCubit = InternetCubit(connectivity: Connectivity());
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit(internetCubit: internetCubit);
    });

    tearDown(() {
      counterCubit.close();
    });

    test(
      'The initial state for the CounterCubit is CounterState(counterValue: 0)',
      () {
        expect(counterCubit.state, CounterState(counterValue: 0));
      },
    );

    blocTest<CounterCubit, CounterState>(
      'The cubit should emit a CounterState(counterValue: 1, '
      'wasIncremented: true) when cubit.increment function is called.',
      build: () => CounterCubit(internetCubit: internetCubit),
      act: (cubit) => cubit.increment(),
      expect: () =>
          <CounterState>[CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest<CounterCubit, CounterState>(
      'The cubit should emit a CounterState(counterValue: -1, '
      'wasIncremented: false) when cubit.decrement function is called.',
      build: () => CounterCubit(internetCubit: internetCubit),
      act: (cubit) => cubit.decrement(),
      expect: () =>
          <CounterState>[CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
