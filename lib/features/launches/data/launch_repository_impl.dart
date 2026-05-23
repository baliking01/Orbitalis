import 'dart:convert';

import 'package:orbitalis/core/errors/app_exception.dart';
import 'package:orbitalis/core/network/dio_provider.dart';
import 'package:orbitalis/features/launches/data/models/launch_dto.dart';
import 'package:orbitalis/features/launches/data/sources/launch_local_source.dart';
import 'package:orbitalis/features/launches/data/sources/launch_remote_source.dart';
import 'package:orbitalis/features/launches/domain/entities/launch.dart';
import 'package:orbitalis/features/launches/domain/repositories/launch_repository.dart';
import 'package:orbitalis/shared/models/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launch_repository_impl.g.dart';

@Riverpod(keepAlive: true)
LaunchRepository launchRepository(LaunchRepositoryRef ref) {
  return LaunchRepositoryImpl(
    remote: LaunchRemoteSource(ref.watch(dioProvider)),
    local: LaunchLocalSource(),
  );
}

class LaunchRepositoryImpl implements LaunchRepository {
  LaunchRepositoryImpl({required this.remote, required this.local});

  final LaunchRemoteSource remote;
  final LaunchLocalSource local;

  @override
  Future<Result<List<Launch>>> getUpcomingLaunches({int offset = 0}) async {
    if (offset == 0 && local.isCacheStale) {
      final r = await remote.getUpcoming();
      if (r.isSuccess) {
        final maps = r.data!.results.map(_dtoToMap).toList();
        await local.saveUpcoming(maps);
        return success(r.data!.results.map(_dtoToEntity).toList());
      }
    }
    if (offset == 0) {
      final cached = await local.getUpcoming();
      if (cached != null) {
        return success(cached.map(_mapToEntity).toList());
      }
    }
    final r = await remote.getUpcoming(offset: offset);
    if (r.isFailure) return failure(r.error!);
    return success(r.data!.results.map(_dtoToEntity).toList());
  }

  @override
  Future<Result<List<Launch>>> getPreviousLaunches({int offset = 0}) async {
    if (offset == 0) {
      final cached = await local.getPrevious();
      if (cached != null && !local.isCacheStale) {
        return success(cached.map(_mapToEntity).toList());
      }
    }
    final r = await remote.getPrevious(offset: offset);
    if (r.isFailure) return failure(r.error!);
    if (offset == 0) {
      await local.savePrevious(
        r.data!.results.map(_dtoToMap).toList(),
      );
    }
    return success(r.data!.results.map(_dtoToEntity).toList());
  }

  @override
  Future<Result<Launch>> getLaunchById(String id) async {
    final cached = await local.getUpcoming();
    if (cached != null) {
      final match = cached.where((m) => m['id'] == id).toList();
      if (match.isNotEmpty) return success(_mapToEntity(match.first));
    }
    return failure(const CacheException('Launch not found'));
  }

  @override
  Future<Result<void>> refresh() async {
    final r = await remote.getUpcoming();
    if (r.isFailure) return failure(r.error!);
    await local.saveUpcoming(r.data!.results.map(_dtoToMap).toList());
    return success(null);
  }

  Launch _dtoToEntity(LaunchDto d) => Launch(
        id: d.id,
        name: d.name,
        providerName: d.launchServiceProvider?.name ?? 'Unknown',
        rocketName: d.rocket?.configuration?.name ?? 'Unknown',
        padName: d.pad?.name ?? 'Unknown',
        padLocation: d.pad?.location?.name ?? '',
        statusAbbrev: d.status?.abbrev ?? 'TBD',
        net: d.net != null ? DateTime.parse(d.net!) : DateTime.now(),
        providerLogoUrl: d.launchServiceProvider?.logoUrl,
        missionDescription: d.mission?.description,
        missionType: d.mission?.type,
        livestreamUrl:
            d.vidUrls != null && d.vidUrls!.isNotEmpty
                ? d.vidUrls!.first.url
                : null,
        padLatitude: double.tryParse(d.pad?.latitude ?? ''),
        padLongitude: double.tryParse(d.pad?.longitude ?? ''),
        probability: d.probability,
      );

  Map<String, dynamic> _dtoToMap(LaunchDto d) =>
      jsonDecode(jsonEncode(_dtoToEntity(d).toJson())) as Map<String, dynamic>;

  Launch _mapToEntity(Map<String, dynamic> m) =>
      Launch.fromJson(m);
}
