import 'package:orbitalis/features/tracking/domain/entities/satellite.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite_position.dart';
import 'package:orbitalis/shared/models/result.dart';

abstract class TrackingRepository {
  /// Emits the catalog as each TLE group loads.
  /// First emission uses cached data (instant); subsequent emissions add groups.
  Stream<List<Satellite>> getSatellitesStream();

  /// Live position stream. Only subscribe for starred satellites and the
  /// detail screen — do not subscribe for every row in a long list.
  Stream<SatellitePosition> watchPosition(String noradId);

  Future<Result<Satellite>> getSatelliteById(String noradId);
}
