import 'dart:convert';

import 'package:orbitalis/features/settings/domain/entities/app_settings.dart';
import 'package:orbitalis/features/settings/domain/repositories/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository_impl.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) =>
    SettingsRepositoryImpl();

class SettingsRepositoryImpl implements SettingsRepository {
  static const _key = 'app_settings';

  @override
  Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return const AppSettings();
    try {
      return AppSettings.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return const AppSettings();
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(settings.toJson()));
  }

  @override
  Future<void> addFavorite(String noradId) async {
    final settings = await getSettings();
    if (settings.favoriteNoradIds.contains(noradId)) return;
    await saveSettings(
      settings.copyWith(
        favoriteNoradIds: [...settings.favoriteNoradIds, noradId],
      ),
    );
  }

  @override
  Future<void> removeFavorite(String noradId) async {
    final settings = await getSettings();
    await saveSettings(
      settings.copyWith(
        favoriteNoradIds: settings.favoriteNoradIds
            .where((String id) => id != noradId)
            .toList(),
      ),
    );
  }
}
