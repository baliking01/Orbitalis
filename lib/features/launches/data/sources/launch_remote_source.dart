import 'package:dio/dio.dart';
import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/errors/app_exception.dart';
import 'package:orbitalis/features/launches/data/models/launch_dto.dart';
import 'package:orbitalis/shared/models/result.dart';

class LaunchRemoteSource {
  const LaunchRemoteSource(this._dio);

  final Dio _dio;

  Future<Result<LaunchListResponseDto>> getUpcoming({int offset = 0}) =>
      _fetch('launch/upcoming/', offset: offset);

  Future<Result<LaunchListResponseDto>> getPrevious({int offset = 0}) =>
      _fetch('launch/previous/', offset: offset);

  Future<Result<LaunchListResponseDto>> _fetch(
    String path, {
    int offset = 0,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${AppConstants.launchLibraryBaseUrl}$path',
        queryParameters: {
          'limit': AppConstants.launchPageSize,
          'offset': offset,
          'mode': 'detailed',
        },
      );
      if (response.data == null) {
        return failure(const ParseException('Empty launch response'));
      }
      return success(LaunchListResponseDto.fromJson(response.data!));
    } on DioException catch (e) {
      return failure(NetworkException(e.message ?? 'Launch fetch failed'));
    } catch (e) {
      return failure(UnknownException(e.toString()));
    }
  }
}
