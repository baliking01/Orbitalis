// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaunchImpl _$$LaunchImplFromJson(Map<String, dynamic> json) => _$LaunchImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      providerName: json['providerName'] as String,
      rocketName: json['rocketName'] as String,
      padName: json['padName'] as String,
      padLocation: json['padLocation'] as String,
      statusAbbrev: json['statusAbbrev'] as String,
      net: DateTime.parse(json['net'] as String),
      providerLogoUrl: json['providerLogoUrl'] as String?,
      missionDescription: json['missionDescription'] as String?,
      missionType: json['missionType'] as String?,
      livestreamUrl: json['livestreamUrl'] as String?,
      padLatitude: (json['padLatitude'] as num?)?.toDouble(),
      padLongitude: (json['padLongitude'] as num?)?.toDouble(),
      probability: (json['probability'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LaunchImplToJson(_$LaunchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'providerName': instance.providerName,
      'rocketName': instance.rocketName,
      'padName': instance.padName,
      'padLocation': instance.padLocation,
      'statusAbbrev': instance.statusAbbrev,
      'net': instance.net.toIso8601String(),
      'providerLogoUrl': instance.providerLogoUrl,
      'missionDescription': instance.missionDescription,
      'missionType': instance.missionType,
      'livestreamUrl': instance.livestreamUrl,
      'padLatitude': instance.padLatitude,
      'padLongitude': instance.padLongitude,
      'probability': instance.probability,
    };
