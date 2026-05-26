// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      unitSystem: json['unitSystem'] as String? ?? 'metric',
      flyoverLeadMinutes: (json['flyoverLeadMinutes'] as num?)?.toInt() ?? 60,
      favoriteNoradIds: (json['favoriteNoradIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      notifyLaunches: json['notifyLaunches'] as bool? ?? true,
      notifyFlyovers: json['notifyFlyovers'] as bool? ?? true,
      tleRefreshHours: (json['tleRefreshHours'] as num?)?.toInt() ?? 24,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'unitSystem': instance.unitSystem,
      'flyoverLeadMinutes': instance.flyoverLeadMinutes,
      'favoriteNoradIds': instance.favoriteNoradIds,
      'notifyLaunches': instance.notifyLaunches,
      'notifyFlyovers': instance.notifyFlyovers,
      'tleRefreshHours': instance.tleRefreshHours,
    };
