// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$satellitesHash() => r'c355b1ae265609a0743b9b29341b46f713218d30';

/// Progressive catalog stream — emits cached data immediately, then extends
/// the list as each TLE group finishes loading in the background.
///
/// Copied from [satellites].
@ProviderFor(satellites)
final satellitesProvider = StreamProvider<List<Satellite>>.internal(
  satellites,
  name: r'satellitesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$satellitesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SatellitesRef = StreamProviderRef<List<Satellite>>;
String _$satellitePositionHash() => r'bd27ed50e4e9479e56466736523205f3fa9309b0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Live position stream for a single satellite.
/// Subscribe only for starred satellites and the detail screen —
/// not for every row in the tracking list.
///
/// Copied from [satellitePosition].
@ProviderFor(satellitePosition)
const satellitePositionProvider = SatellitePositionFamily();

/// Live position stream for a single satellite.
/// Subscribe only for starred satellites and the detail screen —
/// not for every row in the tracking list.
///
/// Copied from [satellitePosition].
class SatellitePositionFamily extends Family<AsyncValue<SatellitePosition>> {
  /// Live position stream for a single satellite.
  /// Subscribe only for starred satellites and the detail screen —
  /// not for every row in the tracking list.
  ///
  /// Copied from [satellitePosition].
  const SatellitePositionFamily();

  /// Live position stream for a single satellite.
  /// Subscribe only for starred satellites and the detail screen —
  /// not for every row in the tracking list.
  ///
  /// Copied from [satellitePosition].
  SatellitePositionProvider call(
    String noradId,
  ) {
    return SatellitePositionProvider(
      noradId,
    );
  }

  @override
  SatellitePositionProvider getProviderOverride(
    covariant SatellitePositionProvider provider,
  ) {
    return call(
      provider.noradId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'satellitePositionProvider';
}

/// Live position stream for a single satellite.
/// Subscribe only for starred satellites and the detail screen —
/// not for every row in the tracking list.
///
/// Copied from [satellitePosition].
class SatellitePositionProvider
    extends AutoDisposeStreamProvider<SatellitePosition> {
  /// Live position stream for a single satellite.
  /// Subscribe only for starred satellites and the detail screen —
  /// not for every row in the tracking list.
  ///
  /// Copied from [satellitePosition].
  SatellitePositionProvider(
    String noradId,
  ) : this._internal(
          (ref) => satellitePosition(
            ref as SatellitePositionRef,
            noradId,
          ),
          from: satellitePositionProvider,
          name: r'satellitePositionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$satellitePositionHash,
          dependencies: SatellitePositionFamily._dependencies,
          allTransitiveDependencies:
              SatellitePositionFamily._allTransitiveDependencies,
          noradId: noradId,
        );

  SatellitePositionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.noradId,
  }) : super.internal();

  final String noradId;

  @override
  Override overrideWith(
    Stream<SatellitePosition> Function(SatellitePositionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SatellitePositionProvider._internal(
        (ref) => create(ref as SatellitePositionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        noradId: noradId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SatellitePosition> createElement() {
    return _SatellitePositionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SatellitePositionProvider && other.noradId == noradId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, noradId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SatellitePositionRef on AutoDisposeStreamProviderRef<SatellitePosition> {
  /// The parameter `noradId` of this provider.
  String get noradId;
}

class _SatellitePositionProviderElement
    extends AutoDisposeStreamProviderElement<SatellitePosition>
    with SatellitePositionRef {
  _SatellitePositionProviderElement(super.provider);

  @override
  String get noradId => (origin as SatellitePositionProvider).noradId;
}

String _$issPositionHash() => r'46b02c1c6b2b05a452ec1d15d5039c94d31442e0';

/// Dedicated ISS position stream — always active on the home screen.
///
/// Copied from [issPosition].
@ProviderFor(issPosition)
final issPositionProvider = StreamProvider<SatellitePosition>.internal(
  issPosition,
  name: r'issPositionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$issPositionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IssPositionRef = StreamProviderRef<SatellitePosition>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
