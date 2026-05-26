// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'satellite_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SatellitePosition {
  String get noradId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get altitudeKm => throw _privateConstructorUsedError;
  double get velocityKmS => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of SatellitePosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SatellitePositionCopyWith<SatellitePosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SatellitePositionCopyWith<$Res> {
  factory $SatellitePositionCopyWith(
          SatellitePosition value, $Res Function(SatellitePosition) then) =
      _$SatellitePositionCopyWithImpl<$Res, SatellitePosition>;
  @useResult
  $Res call(
      {String noradId,
      double latitude,
      double longitude,
      double altitudeKm,
      double velocityKmS,
      DateTime timestamp});
}

/// @nodoc
class _$SatellitePositionCopyWithImpl<$Res, $Val extends SatellitePosition>
    implements $SatellitePositionCopyWith<$Res> {
  _$SatellitePositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SatellitePosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noradId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? altitudeKm = null,
    Object? velocityKmS = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      noradId: null == noradId
          ? _value.noradId
          : noradId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      altitudeKm: null == altitudeKm
          ? _value.altitudeKm
          : altitudeKm // ignore: cast_nullable_to_non_nullable
              as double,
      velocityKmS: null == velocityKmS
          ? _value.velocityKmS
          : velocityKmS // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SatellitePositionImplCopyWith<$Res>
    implements $SatellitePositionCopyWith<$Res> {
  factory _$$SatellitePositionImplCopyWith(_$SatellitePositionImpl value,
          $Res Function(_$SatellitePositionImpl) then) =
      __$$SatellitePositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String noradId,
      double latitude,
      double longitude,
      double altitudeKm,
      double velocityKmS,
      DateTime timestamp});
}

/// @nodoc
class __$$SatellitePositionImplCopyWithImpl<$Res>
    extends _$SatellitePositionCopyWithImpl<$Res, _$SatellitePositionImpl>
    implements _$$SatellitePositionImplCopyWith<$Res> {
  __$$SatellitePositionImplCopyWithImpl(_$SatellitePositionImpl _value,
      $Res Function(_$SatellitePositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SatellitePosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noradId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? altitudeKm = null,
    Object? velocityKmS = null,
    Object? timestamp = null,
  }) {
    return _then(_$SatellitePositionImpl(
      noradId: null == noradId
          ? _value.noradId
          : noradId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      altitudeKm: null == altitudeKm
          ? _value.altitudeKm
          : altitudeKm // ignore: cast_nullable_to_non_nullable
              as double,
      velocityKmS: null == velocityKmS
          ? _value.velocityKmS
          : velocityKmS // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SatellitePositionImpl implements _SatellitePosition {
  const _$SatellitePositionImpl(
      {required this.noradId,
      required this.latitude,
      required this.longitude,
      required this.altitudeKm,
      required this.velocityKmS,
      required this.timestamp});

  @override
  final String noradId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double altitudeKm;
  @override
  final double velocityKmS;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SatellitePosition(noradId: $noradId, latitude: $latitude, longitude: $longitude, altitudeKm: $altitudeKm, velocityKmS: $velocityKmS, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatellitePositionImpl &&
            (identical(other.noradId, noradId) || other.noradId == noradId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.altitudeKm, altitudeKm) ||
                other.altitudeKm == altitudeKm) &&
            (identical(other.velocityKmS, velocityKmS) ||
                other.velocityKmS == velocityKmS) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, noradId, latitude, longitude,
      altitudeKm, velocityKmS, timestamp);

  /// Create a copy of SatellitePosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SatellitePositionImplCopyWith<_$SatellitePositionImpl> get copyWith =>
      __$$SatellitePositionImplCopyWithImpl<_$SatellitePositionImpl>(
          this, _$identity);
}

abstract class _SatellitePosition implements SatellitePosition {
  const factory _SatellitePosition(
      {required final String noradId,
      required final double latitude,
      required final double longitude,
      required final double altitudeKm,
      required final double velocityKmS,
      required final DateTime timestamp}) = _$SatellitePositionImpl;

  @override
  String get noradId;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get altitudeKm;
  @override
  double get velocityKmS;
  @override
  DateTime get timestamp;

  /// Create a copy of SatellitePosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SatellitePositionImplCopyWith<_$SatellitePositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
