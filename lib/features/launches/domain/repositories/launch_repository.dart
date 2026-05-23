import 'package:orbitalis/features/launches/domain/entities/launch.dart';
import 'package:orbitalis/shared/models/result.dart';

abstract class LaunchRepository {
  Future<Result<List<Launch>>> getUpcomingLaunches({int offset = 0});
  Future<Result<List<Launch>>> getPreviousLaunches({int offset = 0});
  Future<Result<Launch>> getLaunchById(String id);
  Future<Result<void>> refresh();
}
