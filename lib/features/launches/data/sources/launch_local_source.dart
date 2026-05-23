import 'dart:convert';

import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/services/hive_service.dart';

class LaunchLocalSource {
  static const String _upcomingKey = 'upcoming_launches';
  static const String _previousKey = 'previous_launches';
  static const String _lastFetchKey = 'launches_last_fetch';

  Future<List<Map<String, dynamic>>?> getUpcoming() => _get(_upcomingKey);
  Future<List<Map<String, dynamic>>?> getPrevious() => _get(_previousKey);

  Future<List<Map<String, dynamic>>?> _get(String key) async {
    final raw = HiveService.launches.get(key);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  Future<void> saveUpcoming(List<Map<String, dynamic>> launches) =>
      _save(_upcomingKey, launches);

  Future<void> savePrevious(List<Map<String, dynamic>> launches) =>
      _save(_previousKey, launches);

  Future<void> _save(String key, List<Map<String, dynamic>> data) async {
    await HiveService.launches.put(key, jsonEncode(data));
    await HiveService.metadata.put(
      _lastFetchKey,
      DateTime.now().toIso8601String(),
    );
  }

  bool get isCacheStale {
    final raw =
        HiveService.metadata.get(_lastFetchKey) as String?;
    if (raw == null) return true;
    final last = DateTime.tryParse(raw);
    if (last == null) return true;
    return DateTime.now().difference(last) > AppConstants.launchCacheDuration;
  }
}
