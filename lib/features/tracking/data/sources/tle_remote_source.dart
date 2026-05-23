import 'package:dio/dio.dart';
import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/errors/app_exception.dart';
import 'package:orbitalis/shared/models/result.dart';

class TleRemoteSource {
  const TleRemoteSource(this._dio);

  final Dio _dio;

  /// Fetch a named CelesTrak group (e.g. 'stations', 'visual', 'weather').
  Future<Result<List<Map<String, String>>>> fetchTlesForGroup(
    String group,
  ) async {
    try {
      final url =
          '${AppConstants.celestrakBaseUrl}?GROUP=$group&FORMAT=TLE';
      final response = await _dio.get<String>(url);
      if (response.data == null) {
        return failure(const ParseException('Empty TLE response'));
      }
      return success(_parseTleText(response.data!));
    } on DioException catch (e) {
      return failure(NetworkException(e.message ?? 'Failed to fetch TLE data'));
    } catch (e) {
      return failure(UnknownException(e.toString()));
    }
  }

  /// Fast single-satellite fetch — only downloads 3 lines for the given NORAD ID.
  Future<Result<Map<String, String>>> fetchIssTle() async {
    try {
      final response = await _dio.get<String>(AppConstants.issTleUrl);
      if (response.data == null) {
        return failure(const ParseException('Empty ISS TLE response'));
      }
      final parsed = _parseTleText(response.data!);
      if (parsed.isEmpty) {
        return failure(const ParseException('Could not parse ISS TLE'));
      }
      return success(parsed.first);
    } on DioException catch (e) {
      return failure(NetworkException(e.message ?? 'Failed to fetch ISS TLE'));
    } catch (e) {
      return failure(UnknownException(e.toString()));
    }
  }

  List<Map<String, String>> _parseTleText(String raw) {
    final lines = raw
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    final result = <Map<String, String>>[];
    for (var i = 0; i + 2 < lines.length; i += 3) {
      final name = lines[i];
      final line1 = lines[i + 1];
      final line2 = lines[i + 2];
      if (line1.startsWith('1 ') && line2.startsWith('2 ')) {
        final noradId = line1.substring(2, 7).trim();
        result.add({
          'noradId': noradId,
          'name': name,
          'line1': line1,
          'line2': line2,
        });
      }
    }
    return result;
  }
}
