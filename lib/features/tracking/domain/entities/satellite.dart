import 'package:freezed_annotation/freezed_annotation.dart';

part 'satellite.freezed.dart';

@freezed
class Satellite with _$Satellite {
  const factory Satellite({
    required String noradId,
    required String name,
    required String line1,
    required String line2,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(0) double altitudeKm,
    @Default(0) double velocityKmS,
    @Default(0) double orbitalPeriodMin,
  }) = _Satellite;
}
