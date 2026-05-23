import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitalis/core/services/notification_service.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/features/settings/presentation/providers/settings_providers.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/orbitalis_app_bar.dart';
import 'package:orbitalis/shared/widgets/section_header.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsNotifierProvider);
    final settings = settingsAsync.valueOrNull;

    return Scaffold(
      appBar: const OrbitalisAppBar(title: 'Alerts'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          const SectionHeader(title: 'Alert Settings'),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                _SwitchTile(
                  icon: Icons.rocket_launch_rounded,
                  label: 'Launch Alerts',
                  subtitle: 'Notify before upcoming launches',
                  value: settings?.notifyLaunches ?? true,
                  onChanged: settings != null
                      ? (v) => ref
                          .read(appSettingsNotifierProvider.notifier)
                          .setNotifyLaunches(enabled: v)
                      : null,
                ),
                const Divider(height: 1, color: AppColors.border),
                _SwitchTile(
                  icon: Icons.satellite_alt_rounded,
                  label: 'Flyover Alerts',
                  subtitle: 'Notify when ISS passes overhead',
                  value: settings?.notifyFlyovers ?? true,
                  onChanged: settings != null
                      ? (v) => ref
                          .read(appSettingsNotifierProvider.notifier)
                          .setNotifyFlyovers(enabled: v)
                      : null,
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Flyover Settings'),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lead Time', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 4),
                const Text(
                  'Alert this many minutes before a flyover',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 12),
                _LeadTimeSelector(
                  current: settings?.flyoverLeadMinutes ?? 60,
                  onChanged: settings != null
                      ? (v) => ref
                          .read(appSettingsNotifierProvider.notifier)
                          .setFlyoverLeadMinutes(v)
                      : null,
                ),
              ],
            ),
          ).animate(delay: 60.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Pending Alerts'),
          const SizedBox(height: 12),
          const _PendingAlertsList(),
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.cyan, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodyMedium),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.cyan,
            activeTrackColor: AppColors.cyan.withAlpha(80),
            inactiveThumbColor: AppColors.textMuted,
            inactiveTrackColor: AppColors.surfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _LeadTimeSelector extends StatelessWidget {
  const _LeadTimeSelector({required this.current, required this.onChanged});

  final int current;
  final ValueChanged<int>? onChanged;

  static const _options = [15, 30, 60, 120];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final minutes in _options)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: onChanged != null ? () => onChanged!(minutes) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: current == minutes
                        ? AppColors.cyan.withAlpha(40)
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: current == minutes
                          ? AppColors.cyan
                          : AppColors.border,
                    ),
                  ),
                  child: Text(
                    '${minutes}m',
                    style: AppTextStyles.monoSmall.copyWith(
                      color: current == minutes
                          ? AppColors.cyan
                          : AppColors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PendingAlertsList extends StatefulWidget {
  const _PendingAlertsList();

  @override
  State<_PendingAlertsList> createState() => _PendingAlertsListState();
}

class _PendingAlertsListState extends State<_PendingAlertsList> {
  List<PendingNotificationRequest> _pending = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pending =
        await NotificationService.instance.getPendingNotifications();
    if (mounted) {
      setState(() {
        _pending = pending;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.cyan,
          strokeWidth: 2,
        ),
      );
    }
    if (_pending.isEmpty) {
      return GlassContainer(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.notifications_off_rounded,
                color: AppColors.textMuted,
                size: 36,
              ),
              const SizedBox(height: 12),
              Text(
                'No scheduled alerts',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: [
        for (final n in _pending)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassContainer(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_rounded,
                    color: AppColors.cyan,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      n.title ?? 'Scheduled alert',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
