import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc_core_concepts/constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetState();
  }

  monitorInternetState() {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
          if (connectivityResult == ConnectivityResult.mobile) {
            emitInternetConnectedState(ConnectivityType.Mobile);
          } else if (connectivityResult == ConnectivityResult.wifi) {
            emitInternetConnectedState(ConnectivityType.Wifi);
          } else if (connectivityResult == ConnectivityResult.none) {
            emitInternetDisconnectedState();
          }
        });
  }

  void emitInternetConnectedState(ConnectivityType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnectedState() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
