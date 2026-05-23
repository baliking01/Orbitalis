import 'package:orbitalis/features/settings/data/settings_repository_impl.dart';
import 'package:orbitalis/features/settings/domain/entities/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
class AppSettingsNotifier extends _$AppSettingsNotifier {
  @override
  Future<AppSettings> build() async {
    final repo = ref.watch(settingsRepositoryProvider);
    return repo.getSettings();
  }

  Future<void> persist(AppSettings settings) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.saveSettings(settings);
    state = AsyncData(settings);
  }

  Future<void> setUnitSystem(String system) async {
    final current = state.valueOrNull ?? const AppSettings();
    await persist(current.copyWith(unitSystem: system));
  }

  Future<void> setNotifyLaunches({required bool enabled}) async {
    final current = state.valueOrNull ?? const AppSettings();
    await persist(current.copyWith(notifyLaunches: enabled));
  }

  Future<void> setNotifyFlyovers({required bool enabled}) async {
    final current = state.valueOrNull ?? const AppSettings();
    await persist(current.copyWith(notifyFlyovers: enabled));
  }

  Future<void> setFlyoverLeadMinutes(int minutes) async {
    final current = state.valueOrNull ?? const AppSettings();
    await persist(current.copyWith(flyoverLeadMinutes: minutes));
  }

  Future<void> setTleRefreshHours(int hours) async {
    final current = state.valueOrNull ?? const AppSettings();
    await persist(current.copyWith(tleRefreshHours: hours));
  }

  Future<void> toggleFavorite(String noradId) async {
    final current = state.valueOrNull ?? const AppSettings();
    final repo = ref.read(settingsRepositoryProvider);
    if (current.favoriteNoradIds.contains(noradId)) {
      await repo.removeFavorite(noradId);
      state = AsyncData(
        current.copyWith(
          favoriteNoradIds: current.favoriteNoradIds
              .where((String id) => id != noradId)
              .toList(),
        ),
      );
    } else {
      await repo.addFavorite(noradId);
      state = AsyncData(
        current.copyWith(
          favoriteNoradIds: [...current.favoriteNoradIds, noradId],
        ),
      );
    }
  }
}

/// Convenience provider — true when the user has chosen metric units (default).
/// Widgets that format altitude/velocity watch this instead of reading
/// the full settings object.
final isMetricProvider = Provider<bool>(
  (ref) =>
      ref.watch(appSettingsNotifierProvider).valueOrNull?.unitSystem !=
      'imperial',
);
