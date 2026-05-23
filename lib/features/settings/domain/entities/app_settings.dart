import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('metric') String unitSystem,
    @Default(60) int flyoverLeadMinutes,
    @Default(<String>[]) List<String> favoriteNoradIds,
    @Default(true) bool notifyLaunches,
    @Default(true) bool notifyFlyovers,
    @Default(24) int tleRefreshHours,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
