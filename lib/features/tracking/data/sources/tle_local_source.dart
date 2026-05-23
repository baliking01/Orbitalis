import 'dart:convert';

import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/services/hive_service.dart';

class TleLocalSource {
  static const String _issLastFetchKey = 'iss_tle_last_fetch';

  String _groupFetchKey(String group) => 'tle_fetch_$group';

  // ── Read ──────────────────────────────────────────────────────────────────

  Future<List<Map<String, String>>> getAllTles() async {
    return HiveService.tle.values
        .map((v) => Map<String, String>.from(jsonDecode(v) as Map))
        .toList();
  }

  Future<Map<String, String>?> getTleById(String noradId) async {
    final raw = HiveService.tle.get(noradId);
    if (raw == null) return null;
    return Map<String, String>.from(jsonDecode(raw) as Map);
  }

  bool isGroupStale(String group) {
    final raw = HiveService.metadata.get(_groupFetchKey(group)) as String?;
    if (raw == null) return true;
    final t = DateTime.tryParse(raw);
    if (t == null) return true;
    return DateTime.now().difference(t) > AppConstants.tleCacheDuration;
  }

  Duration? issLastFetchAge() {
    final raw = HiveService.metadata.get(_issLastFetchKey) as String?;
    if (raw == null) return null;
    final t = DateTime.tryParse(raw);
    if (t == null) return null;
    return DateTime.now().difference(t);
  }

  bool get isEmpty => HiveService.tle.isEmpty;

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Additive save — writes entries into the box keyed by noradId.
  /// Does NOT clear other groups' data.
  Future<void> saveTlesForGroup(
    String group,
    List<Map<String, String>> tles,
  ) async {
    final entries = <String, String>{};
    for (final t in tles) {
      final id = t['noradId'];
      if (id != null) entries[id] = jsonEncode(t);
    }
    await HiveService.tle.putAll(entries);
    await HiveService.metadata.put(
      _groupFetchKey(group),
      DateTime.now().toIso8601String(),
    );
  }

  /// Upsert a single TLE entry without touching anything else in the box.
  Future<void> saveSingleTle(Map<String, String> tle) async {
    final id = tle['noradId'];
    if (id != null) await HiveService.tle.put(id, jsonEncode(tle));
  }

  Future<void> markIssLastFetch() async {
    await HiveService.metadata.put(
      _issLastFetchKey,
      DateTime.now().toIso8601String(),
    );
  }
}
