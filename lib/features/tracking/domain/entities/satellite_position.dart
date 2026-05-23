import 'package:freezed_annotation/freezed_annotation.dart';

part 'satellite_position.freezed.dart';

@freezed
class SatellitePosition with _$SatellitePosition {
  const factory SatellitePosition({
    required String noradId,
    required double latitude,
    required double longitude,
    required double altitudeKm,
    required double velocityKmS,
    required DateTime timestamp,
  }) = _SatellitePosition;
}
