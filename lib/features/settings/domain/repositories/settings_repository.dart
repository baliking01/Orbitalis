import 'package:orbitalis/features/settings/domain/entities/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
  Future<void> addFavorite(String noradId);
  Future<void> removeFavorite(String noradId);
}
