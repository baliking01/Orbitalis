// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$upcomingLaunchesHash() => r'43bb76965b1ac30ea11fd0a7bcfe2d9047fca1eb';

/// See also [upcomingLaunches].
@ProviderFor(upcomingLaunches)
final upcomingLaunchesProvider =
    AutoDisposeFutureProvider<List<Launch>>.internal(
  upcomingLaunches,
  name: r'upcomingLaunchesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingLaunchesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingLaunchesRef = AutoDisposeFutureProviderRef<List<Launch>>;
String _$previousLaunchesHash() => r'ef62eeeb19da1d0be11fdbce1de7b9e190eba4b7';

/// See also [previousLaunches].
@ProviderFor(previousLaunches)
final previousLaunchesProvider =
    AutoDisposeFutureProvider<List<Launch>>.internal(
  previousLaunches,
  name: r'previousLaunchesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$previousLaunchesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreviousLaunchesRef = AutoDisposeFutureProviderRef<List<Launch>>;
String _$launchByIdHash() => r'3940ffd042a0dd1bd92a7d986cb7e8a5b7c61d05';

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

/// See also [launchById].
@ProviderFor(launchById)
const launchByIdProvider = LaunchByIdFamily();

/// See also [launchById].
class LaunchByIdFamily extends Family<AsyncValue<Launch>> {
  /// See also [launchById].
  const LaunchByIdFamily();

  /// See also [launchById].
  LaunchByIdProvider call(
    String id,
  ) {
    return LaunchByIdProvider(
      id,
    );
  }

  @override
  LaunchByIdProvider getProviderOverride(
    covariant LaunchByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'launchByIdProvider';
}

/// See also [launchById].
class LaunchByIdProvider extends AutoDisposeFutureProvider<Launch> {
  /// See also [launchById].
  LaunchByIdProvider(
    String id,
  ) : this._internal(
          (ref) => launchById(
            ref as LaunchByIdRef,
            id,
          ),
          from: launchByIdProvider,
          name: r'launchByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$launchByIdHash,
          dependencies: LaunchByIdFamily._dependencies,
          allTransitiveDependencies:
              LaunchByIdFamily._allTransitiveDependencies,
          id: id,
        );

  LaunchByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Launch> Function(LaunchByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LaunchByIdProvider._internal(
        (ref) => create(ref as LaunchByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Launch> createElement() {
    return _LaunchByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LaunchByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LaunchByIdRef on AutoDisposeFutureProviderRef<Launch> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LaunchByIdProviderElement
    extends AutoDisposeFutureProviderElement<Launch> with LaunchByIdRef {
  _LaunchByIdProviderElement(super.provider);

  @override
  String get id => (origin as LaunchByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
