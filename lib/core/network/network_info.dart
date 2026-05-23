import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

@Riverpod(keepAlive: true)
Stream<bool> networkConnected(NetworkConnectedRef ref) {
  return Connectivity().onConnectivityChanged.map(
    (results) =>
        results.any((r) => r != ConnectivityResult.none),
  );
}
