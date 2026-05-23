import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/errors/app_exception.dart';
import 'package:orbitalis/core/network/dio_provider.dart';
import 'package:orbitalis/features/tracking/data/sources/sgp4_service.dart';
import 'package:orbitalis/features/tracking/data/sources/tle_local_source.dart';
import 'package:orbitalis/features/tracking/data/sources/tle_remote_source.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite_position.dart';
import 'package:orbitalis/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:orbitalis/shared/models/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracking_repository_impl.g.dart';

@Riverpod(keepAlive: true)
TrackingRepository trackingRepository(TrackingRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return TrackingRepositoryImpl(
    remote: TleRemoteSource(dio),
    local: TleLocalSource(),
  );
}

class TrackingRepositoryImpl implements TrackingRepository {
  TrackingRepositoryImpl({required this.remote, required this.local});

  final TleRemoteSource remote;
  final TleLocalSource local;

  // ── Catalog stream ─────────────────────────────────────────────────────────

  @override
  Stream<List<Satellite>> getSatellitesStream() async* {
    // 1. Emit whatever is in cache immediately so the UI shows instantly.
    if (!local.isEmpty) {
      final cached = await local.getAllTles();
      if (cached.isNotEmpty) yield _buildList(cached);
    }

    // 2. Refresh stale groups one at a time, emitting after each.
    var needsEmit = false;
    for (final group in AppConstants.tleGroups) {
      if (local.isGroupStale(group)) {
        final result = await remote.fetchTlesForGroup(group);
        if (result.data != null) {
          await local.saveTlesForGroup(group, result.data!);
          needsEmit = true;
          final all = await local.getAllTles();
          yield _buildList(all);
        }
      }
    }

    // 3. If cache was empty and nothing loaded, emit empty list.
    if (local.isEmpty && !needsEmit) yield const [];
  }

  // ── Single satellite ────────────────────────────────────────────────────────

  @override
  Future<Result<Satellite>> getSatelliteById(String noradId) async {
    final tle = await local.getTleById(noradId);
    if (tle == null) {
      return failure(const CacheException('Satellite not found in cache'));
    }
    return success(_mapToSatellite(tle));
  }

  // ── Live position stream ────────────────────────────────────────────────────

  @override
  Stream<SatellitePosition> watchPosition(String noradId) async* {
    while (true) {
      final tle = noradId == AppConstants.issNoradId
          ? await _getOrFetchIssTle()
          : await local.getTleById(noradId);

      if (tle != null) {
        final pos = Sgp4Service.propagate(
          line1: tle['line1']!,
          line2: tle['line2']!,
        );
        if (pos != null) {
          yield SatellitePosition(
            noradId: noradId,
            latitude: pos['lat']!,
            longitude: pos['lon']!,
            altitudeKm: pos['altKm']!,
            velocityKmS: pos['velKms']!,
            timestamp: DateTime.now(),
          );
        }
      }

      await Future<void>.delayed(AppConstants.trackedPositionInterval);
    }
  }

  // ── ISS fast-fetch ──────────────────────────────────────────────────────────

  Future<Map<String, String>?> _getOrFetchIssTle() async {
    final cached = await local.getTleById(AppConstants.issNoradId);
    final age = local.issLastFetchAge();
    final isFresh =
        age != null && age < AppConstants.issTleCacheDuration;

    if (cached != null && isFresh) return cached;

    final result = await remote.fetchIssTle();
    if (result.data != null) {
      // saveSingleTle — does NOT clear other entries
      await local.saveSingleTle(result.data!);
      await local.markIssLastFetch();
      return result.data;
    }
    return cached; // fall back to stale cache rather than null
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  List<Satellite> _buildList(List<Map<String, String>> tles) =>
      tles.map(_mapToSatellite).toList()
        ..sort((a, b) => a.name.compareTo(b.name));

  Satellite _mapToSatellite(Map<String, String> tle) {
    final pos = Sgp4Service.propagate(
      line1: tle['line1']!,
      line2: tle['line2']!,
    );
    return Satellite(
      noradId: tle['noradId'] ?? '',
      name: tle['name'] ?? '',
      line1: tle['line1'] ?? '',
      line2: tle['line2'] ?? '',
      latitude: pos?['lat'] ?? 0,
      longitude: pos?['lon'] ?? 0,
      altitudeKm: pos?['altKm'] ?? 0,
      velocityKmS: pos?['velKms'] ?? 0,
      orbitalPeriodMin: pos?['periodMin'] ?? 0,
    );
  }
}
