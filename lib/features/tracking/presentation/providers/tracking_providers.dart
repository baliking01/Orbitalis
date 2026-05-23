import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/features/tracking/data/tracking_repository_impl.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite_position.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracking_providers.g.dart';

/// Progressive catalog stream — emits cached data immediately, then extends
/// the list as each TLE group finishes loading in the background.
@Riverpod(keepAlive: true)
Stream<List<Satellite>> satellites(SatellitesRef ref) {
  final repo = ref.watch(trackingRepositoryProvider);
  return repo.getSatellitesStream();
}

/// Live position stream for a single satellite.
/// Subscribe only for starred satellites and the detail screen —
/// not for every row in the tracking list.
@riverpod
Stream<SatellitePosition> satellitePosition(
  SatellitePositionRef ref,
  String noradId,
) {
  final repo = ref.watch(trackingRepositoryProvider);
  return repo.watchPosition(noradId);
}

/// Dedicated ISS position stream — always active on the home screen.
@Riverpod(keepAlive: true)
Stream<SatellitePosition> issPosition(IssPositionRef ref) {
  final repo = ref.watch(trackingRepositoryProvider);
  return repo.watchPosition(AppConstants.issNoradId);
}
