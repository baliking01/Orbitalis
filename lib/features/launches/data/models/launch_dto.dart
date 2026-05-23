import 'package:json_annotation/json_annotation.dart';

part 'launch_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchDto {
  const LaunchDto({
    required this.id,
    required this.name,
    this.net,
    this.status,
    this.launchServiceProvider,
    this.rocket,
    this.mission,
    this.pad,
    this.vidUrls,
    this.probability,
  });

  factory LaunchDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchDtoFromJson(json);

  final String id;
  final String name;
  final String? net;
  final LaunchStatusDto? status;
  final LaunchProviderDto? launchServiceProvider;
  final LaunchRocketDto? rocket;
  final LaunchMissionDto? mission;
  final LaunchPadDto? pad;
  @JsonKey(name: 'vidURLs')
  final List<LaunchVidUrlDto>? vidUrls;
  final int? probability;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchStatusDto {
  const LaunchStatusDto({this.abbrev});

  factory LaunchStatusDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchStatusDtoFromJson(json);

  final String? abbrev;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchProviderDto {
  const LaunchProviderDto({this.name, this.logoUrl});

  factory LaunchProviderDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchProviderDtoFromJson(json);

  final String? name;
  final String? logoUrl;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchRocketDto {
  const LaunchRocketDto({this.configuration});

  factory LaunchRocketDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchRocketDtoFromJson(json);

  final LaunchRocketConfigDto? configuration;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchRocketConfigDto {
  const LaunchRocketConfigDto({this.name});

  factory LaunchRocketConfigDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchRocketConfigDtoFromJson(json);

  final String? name;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchMissionDto {
  const LaunchMissionDto({this.description, this.type});

  factory LaunchMissionDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchMissionDtoFromJson(json);

  final String? description;
  final String? type;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchPadDto {
  const LaunchPadDto({this.name, this.location, this.latitude, this.longitude});

  factory LaunchPadDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchPadDtoFromJson(json);

  final String? name;
  final LaunchPadLocationDto? location;
  final String? latitude;
  final String? longitude;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchPadLocationDto {
  const LaunchPadLocationDto({this.name});

  factory LaunchPadLocationDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchPadLocationDtoFromJson(json);

  final String? name;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchVidUrlDto {
  const LaunchVidUrlDto({this.url});

  factory LaunchVidUrlDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchVidUrlDtoFromJson(json);

  final String? url;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchListResponseDto {
  const LaunchListResponseDto({required this.results, this.next});

  factory LaunchListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LaunchListResponseDtoFromJson(json);

  final List<LaunchDto> results;
  final String? next;
}
