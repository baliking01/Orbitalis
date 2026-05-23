import 'package:orbitalis/features/launches/data/launch_repository_impl.dart';
import 'package:orbitalis/features/launches/domain/entities/launch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launch_providers.g.dart';

@riverpod
Future<List<Launch>> upcomingLaunches(UpcomingLaunchesRef ref) async {
  final repo = ref.watch(launchRepositoryProvider);
  final result = await repo.getUpcomingLaunches();
  if (result.error != null) throw result.error!;
  return result.data!;
}

@riverpod
Future<List<Launch>> previousLaunches(PreviousLaunchesRef ref) async {
  final repo = ref.watch(launchRepositoryProvider);
  final result = await repo.getPreviousLaunches();
  if (result.error != null) throw result.error!;
  return result.data!;
}

@riverpod
Future<Launch> launchById(LaunchByIdRef ref, String id) async {
  final repo = ref.watch(launchRepositoryProvider);
  final result = await repo.getLaunchById(id);
  if (result.error != null) throw result.error!;
  return result.data!;
}
