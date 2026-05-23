import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch.freezed.dart';
part 'launch.g.dart';

@freezed
class Launch with _$Launch {
  const factory Launch({
    required String id,
    required String name,
    required String providerName,
    required String rocketName,
    required String padName,
    required String padLocation,
    required String statusAbbrev,
    required DateTime net,
    String? providerLogoUrl,
    String? missionDescription,
    String? missionType,
    String? livestreamUrl,
    double? padLatitude,
    double? padLongitude,
    int? probability,
  }) = _Launch;

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
}
