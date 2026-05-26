// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'launch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Launch _$LaunchFromJson(Map<String, dynamic> json) {
  return _Launch.fromJson(json);
}

/// @nodoc
mixin _$Launch {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  String get rocketName => throw _privateConstructorUsedError;
  String get padName => throw _privateConstructorUsedError;
  String get padLocation => throw _privateConstructorUsedError;
  String get statusAbbrev => throw _privateConstructorUsedError;
  DateTime get net => throw _privateConstructorUsedError;
  String? get providerLogoUrl => throw _privateConstructorUsedError;
  String? get missionDescription => throw _privateConstructorUsedError;
  String? get missionType => throw _privateConstructorUsedError;
  String? get livestreamUrl => throw _privateConstructorUsedError;
  double? get padLatitude => throw _privateConstructorUsedError;
  double? get padLongitude => throw _privateConstructorUsedError;
  int? get probability => throw _privateConstructorUsedError;

  /// Serializes this Launch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Launch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LaunchCopyWith<Launch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaunchCopyWith<$Res> {
  factory $LaunchCopyWith(Launch value, $Res Function(Launch) then) =
      _$LaunchCopyWithImpl<$Res, Launch>;
  @useResult
  $Res call(
      {String id,
      String name,
      String providerName,
      String rocketName,
      String padName,
      String padLocation,
      String statusAbbrev,
      DateTime net,
      String? providerLogoUrl,
      String? missionDescription,
      String? missionType,
      String? livestreamUrl,
      double? padLatitude,
      double? padLongitude,
      int? probability});
}

/// @nodoc
class _$LaunchCopyWithImpl<$Res, $Val extends Launch>
    implements $LaunchCopyWith<$Res> {
  _$LaunchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Launch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? providerName = null,
    Object? rocketName = null,
    Object? padName = null,
    Object? padLocation = null,
    Object? statusAbbrev = null,
    Object? net = null,
    Object? providerLogoUrl = freezed,
    Object? missionDescription = freezed,
    Object? missionType = freezed,
    Object? livestreamUrl = freezed,
    Object? padLatitude = freezed,
    Object? padLongitude = freezed,
    Object? probability = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      rocketName: null == rocketName
          ? _value.rocketName
          : rocketName // ignore: cast_nullable_to_non_nullable
              as String,
      padName: null == padName
          ? _value.padName
          : padName // ignore: cast_nullable_to_non_nullable
              as String,
      padLocation: null == padLocation
          ? _value.padLocation
          : padLocation // ignore: cast_nullable_to_non_nullable
              as String,
      statusAbbrev: null == statusAbbrev
          ? _value.statusAbbrev
          : statusAbbrev // ignore: cast_nullable_to_non_nullable
              as String,
      net: null == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as DateTime,
      providerLogoUrl: freezed == providerLogoUrl
          ? _value.providerLogoUrl
          : providerLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      missionDescription: freezed == missionDescription
          ? _value.missionDescription
          : missionDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      missionType: freezed == missionType
          ? _value.missionType
          : missionType // ignore: cast_nullable_to_non_nullable
              as String?,
      livestreamUrl: freezed == livestreamUrl
          ? _value.livestreamUrl
          : livestreamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      padLatitude: freezed == padLatitude
          ? _value.padLatitude
          : padLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      padLongitude: freezed == padLongitude
          ? _value.padLongitude
          : padLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      probability: freezed == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LaunchImplCopyWith<$Res> implements $LaunchCopyWith<$Res> {
  factory _$$LaunchImplCopyWith(
          _$LaunchImpl value, $Res Function(_$LaunchImpl) then) =
      __$$LaunchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String providerName,
      String rocketName,
      String padName,
      String padLocation,
      String statusAbbrev,
      DateTime net,
      String? providerLogoUrl,
      String? missionDescription,
      String? missionType,
      String? livestreamUrl,
      double? padLatitude,
      double? padLongitude,
      int? probability});
}

/// @nodoc
class __$$LaunchImplCopyWithImpl<$Res>
    extends _$LaunchCopyWithImpl<$Res, _$LaunchImpl>
    implements _$$LaunchImplCopyWith<$Res> {
  __$$LaunchImplCopyWithImpl(
      _$LaunchImpl _value, $Res Function(_$LaunchImpl) _then)
      : super(_value, _then);

  /// Create a copy of Launch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? providerName = null,
    Object? rocketName = null,
    Object? padName = null,
    Object? padLocation = null,
    Object? statusAbbrev = null,
    Object? net = null,
    Object? providerLogoUrl = freezed,
    Object? missionDescription = freezed,
    Object? missionType = freezed,
    Object? livestreamUrl = freezed,
    Object? padLatitude = freezed,
    Object? padLongitude = freezed,
    Object? probability = freezed,
  }) {
    return _then(_$LaunchImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      rocketName: null == rocketName
          ? _value.rocketName
          : rocketName // ignore: cast_nullable_to_non_nullable
              as String,
      padName: null == padName
          ? _value.padName
          : padName // ignore: cast_nullable_to_non_nullable
              as String,
      padLocation: null == padLocation
          ? _value.padLocation
          : padLocation // ignore: cast_nullable_to_non_nullable
              as String,
      statusAbbrev: null == statusAbbrev
          ? _value.statusAbbrev
          : statusAbbrev // ignore: cast_nullable_to_non_nullable
              as String,
      net: null == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as DateTime,
      providerLogoUrl: freezed == providerLogoUrl
          ? _value.providerLogoUrl
          : providerLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      missionDescription: freezed == missionDescription
          ? _value.missionDescription
          : missionDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      missionType: freezed == missionType
          ? _value.missionType
          : missionType // ignore: cast_nullable_to_non_nullable
              as String?,
      livestreamUrl: freezed == livestreamUrl
          ? _value.livestreamUrl
          : livestreamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      padLatitude: freezed == padLatitude
          ? _value.padLatitude
          : padLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      padLongitude: freezed == padLongitude
          ? _value.padLongitude
          : padLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      probability: freezed == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LaunchImpl implements _Launch {
  const _$LaunchImpl(
      {required this.id,
      required this.name,
      required this.providerName,
      required this.rocketName,
      required this.padName,
      required this.padLocation,
      required this.statusAbbrev,
      required this.net,
      this.providerLogoUrl,
      this.missionDescription,
      this.missionType,
      this.livestreamUrl,
      this.padLatitude,
      this.padLongitude,
      this.probability});

  factory _$LaunchImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaunchImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String providerName;
  @override
  final String rocketName;
  @override
  final String padName;
  @override
  final String padLocation;
  @override
  final String statusAbbrev;
  @override
  final DateTime net;
  @override
  final String? providerLogoUrl;
  @override
  final String? missionDescription;
  @override
  final String? missionType;
  @override
  final String? livestreamUrl;
  @override
  final double? padLatitude;
  @override
  final double? padLongitude;
  @override
  final int? probability;

  @override
  String toString() {
    return 'Launch(id: $id, name: $name, providerName: $providerName, rocketName: $rocketName, padName: $padName, padLocation: $padLocation, statusAbbrev: $statusAbbrev, net: $net, providerLogoUrl: $providerLogoUrl, missionDescription: $missionDescription, missionType: $missionType, livestreamUrl: $livestreamUrl, padLatitude: $padLatitude, padLongitude: $padLongitude, probability: $probability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaunchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.rocketName, rocketName) ||
                other.rocketName == rocketName) &&
            (identical(other.padName, padName) || other.padName == padName) &&
            (identical(other.padLocation, padLocation) ||
                other.padLocation == padLocation) &&
            (identical(other.statusAbbrev, statusAbbrev) ||
                other.statusAbbrev == statusAbbrev) &&
            (identical(other.net, net) || other.net == net) &&
            (identical(other.providerLogoUrl, providerLogoUrl) ||
                other.providerLogoUrl == providerLogoUrl) &&
            (identical(other.missionDescription, missionDescription) ||
                other.missionDescription == missionDescription) &&
            (identical(other.missionType, missionType) ||
                other.missionType == missionType) &&
            (identical(other.livestreamUrl, livestreamUrl) ||
                other.livestreamUrl == livestreamUrl) &&
            (identical(other.padLatitude, padLatitude) ||
                other.padLatitude == padLatitude) &&
            (identical(other.padLongitude, padLongitude) ||
                other.padLongitude == padLongitude) &&
            (identical(other.probability, probability) ||
                other.probability == probability));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      providerName,
      rocketName,
      padName,
      padLocation,
      statusAbbrev,
      net,
      providerLogoUrl,
      missionDescription,
      missionType,
      livestreamUrl,
      padLatitude,
      padLongitude,
      probability);

  /// Create a copy of Launch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaunchImplCopyWith<_$LaunchImpl> get copyWith =>
      __$$LaunchImplCopyWithImpl<_$LaunchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaunchImplToJson(
      this,
    );
  }
}

abstract class _Launch implements Launch {
  const factory _Launch(
      {required final String id,
      required final String name,
      required final String providerName,
      required final String rocketName,
      required final String padName,
      required final String padLocation,
      required final String statusAbbrev,
      required final DateTime net,
      final String? providerLogoUrl,
      final String? missionDescription,
      final String? missionType,
      final String? livestreamUrl,
      final double? padLatitude,
      final double? padLongitude,
      final int? probability}) = _$LaunchImpl;

  factory _Launch.fromJson(Map<String, dynamic> json) = _$LaunchImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get providerName;
  @override
  String get rocketName;
  @override
  String get padName;
  @override
  String get padLocation;
  @override
  String get statusAbbrev;
  @override
  DateTime get net;
  @override
  String? get providerLogoUrl;
  @override
  String? get missionDescription;
  @override
  String? get missionType;
  @override
  String? get livestreamUrl;
  @override
  double? get padLatitude;
  @override
  double? get padLongitude;
  @override
  int? get probability;

  /// Create a copy of Launch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaunchImplCopyWith<_$LaunchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
