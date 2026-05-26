// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchDto _$LaunchDtoFromJson(Map<String, dynamic> json) => LaunchDto(
      id: json['id'] as String,
      name: json['name'] as String,
      net: json['net'] as String?,
      status: json['status'] == null
          ? null
          : LaunchStatusDto.fromJson(json['status'] as Map<String, dynamic>),
      launchServiceProvider: json['launch_service_provider'] == null
          ? null
          : LaunchProviderDto.fromJson(
              json['launch_service_provider'] as Map<String, dynamic>),
      rocket: json['rocket'] == null
          ? null
          : LaunchRocketDto.fromJson(json['rocket'] as Map<String, dynamic>),
      mission: json['mission'] == null
          ? null
          : LaunchMissionDto.fromJson(json['mission'] as Map<String, dynamic>),
      pad: json['pad'] == null
          ? null
          : LaunchPadDto.fromJson(json['pad'] as Map<String, dynamic>),
      vidUrls: (json['vidURLs'] as List<dynamic>?)
          ?.map((e) => LaunchVidUrlDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      probability: (json['probability'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LaunchDtoToJson(LaunchDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'net': instance.net,
      'status': instance.status,
      'launch_service_provider': instance.launchServiceProvider,
      'rocket': instance.rocket,
      'mission': instance.mission,
      'pad': instance.pad,
      'vidURLs': instance.vidUrls,
      'probability': instance.probability,
    };

LaunchStatusDto _$LaunchStatusDtoFromJson(Map<String, dynamic> json) =>
    LaunchStatusDto(
      abbrev: json['abbrev'] as String?,
    );

Map<String, dynamic> _$LaunchStatusDtoToJson(LaunchStatusDto instance) =>
    <String, dynamic>{
      'abbrev': instance.abbrev,
    };

LaunchProviderDto _$LaunchProviderDtoFromJson(Map<String, dynamic> json) =>
    LaunchProviderDto(
      name: json['name'] as String?,
      logoUrl: json['logo_url'] as String?,
    );

Map<String, dynamic> _$LaunchProviderDtoToJson(LaunchProviderDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'logo_url': instance.logoUrl,
    };

LaunchRocketDto _$LaunchRocketDtoFromJson(Map<String, dynamic> json) =>
    LaunchRocketDto(
      configuration: json['configuration'] == null
          ? null
          : LaunchRocketConfigDto.fromJson(
              json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LaunchRocketDtoToJson(LaunchRocketDto instance) =>
    <String, dynamic>{
      'configuration': instance.configuration,
    };

LaunchRocketConfigDto _$LaunchRocketConfigDtoFromJson(
        Map<String, dynamic> json) =>
    LaunchRocketConfigDto(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LaunchRocketConfigDtoToJson(
        LaunchRocketConfigDto instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

LaunchMissionDto _$LaunchMissionDtoFromJson(Map<String, dynamic> json) =>
    LaunchMissionDto(
      description: json['description'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$LaunchMissionDtoToJson(LaunchMissionDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'type': instance.type,
    };

LaunchPadDto _$LaunchPadDtoFromJson(Map<String, dynamic> json) => LaunchPadDto(
      name: json['name'] as String?,
      location: json['location'] == null
          ? null
          : LaunchPadLocationDto.fromJson(
              json['location'] as Map<String, dynamic>),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$LaunchPadDtoToJson(LaunchPadDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

LaunchPadLocationDto _$LaunchPadLocationDtoFromJson(
        Map<String, dynamic> json) =>
    LaunchPadLocationDto(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LaunchPadLocationDtoToJson(
        LaunchPadLocationDto instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

LaunchVidUrlDto _$LaunchVidUrlDtoFromJson(Map<String, dynamic> json) =>
    LaunchVidUrlDto(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LaunchVidUrlDtoToJson(LaunchVidUrlDto instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

LaunchListResponseDto _$LaunchListResponseDtoFromJson(
        Map<String, dynamic> json) =>
    LaunchListResponseDto(
      results: (json['results'] as List<dynamic>)
          .map((e) => LaunchDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
    );

Map<String, dynamic> _$LaunchListResponseDtoToJson(
        LaunchListResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'next': instance.next,
    };
