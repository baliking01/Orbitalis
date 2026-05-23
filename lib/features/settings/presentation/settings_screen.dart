import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/features/settings/presentation/providers/settings_providers.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/orbitalis_app_bar.dart';
import 'package:orbitalis/shared/widgets/section_header.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsNotifierProvider);
    final settings = settingsAsync.valueOrNull;
    final notifier = ref.read(appSettingsNotifierProvider.notifier);

    return Scaffold(
      appBar: const OrbitalisAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
        children: [
          const SectionHeader(title: 'Display'),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Unit System', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 4),
                const Text(
                  'Choose metric or imperial units throughout the app',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 12),
                _SegmentedPicker(
                  options: const ['metric', 'imperial'],
                  labels: const ['Metric (km)', 'Imperial (mi)'],
                  selected: settings?.unitSystem ?? 'metric',
                  onChanged: settings != null ? notifier.setUnitSystem : null,
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Data'),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TLE Refresh Interval', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 4),
                const Text(
                  'How often to fetch updated orbital data',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 12),
                _HoursPicker(
                  options: const [6, 12, 24, 48],
                  selected: settings?.tleRefreshHours ?? 24,
                  onChanged: settings != null ? notifier.setTleRefreshHours : null,
                ),
              ],
            ),
          ).animate(delay: 60.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Notifications'),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                _SwitchRow(
                  label: 'Launch Alerts',
                  subtitle: 'Notify before upcoming launches',
                  value: settings?.notifyLaunches ?? true,
                  onChanged: settings != null
                      ? (v) => notifier.setNotifyLaunches(enabled: v)
                      : null,
                ),
                const Divider(height: 1, color: AppColors.border),
                _SwitchRow(
                  label: 'Flyover Alerts',
                  subtitle: 'Notify when ISS passes overhead',
                  value: settings?.notifyFlyovers ?? true,
                  onChanged: settings != null
                      ? (v) => notifier.setNotifyFlyovers(enabled: v)
                      : null,
                ),
              ],
            ),
          ).animate(delay: 120.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
          const SizedBox(height: 24),
          const SectionHeader(title: 'About'),
          const SizedBox(height: 12),
          const GlassContainer(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(label: 'App', value: 'Orbitalis'),
                SizedBox(height: 8),
                _InfoRow(label: 'Version', value: '1.0.0'),
                SizedBox(height: 8),
                _InfoRow(label: 'TLE Source', value: 'CelesTrak'),
                SizedBox(height: 8),
                _InfoRow(label: 'Launch Data', value: 'Launch Library 2'),
                SizedBox(height: 8),
                _InfoRow(label: 'News', value: 'Spaceflight News API'),
              ],
            ),
          ).animate(delay: 180.ms).fadeIn(duration: 300.ms).slideY(begin: 0.06),
        ],
      ),
    );
  }
}

class _SegmentedPicker extends StatelessWidget {
  const _SegmentedPicker({
    required this.options,
    required this.labels,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final List<String> labels;
  final String selected;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < options.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < options.length - 1 ? 8 : 0),
              child: GestureDetector(
                onTap: onChanged != null ? () => onChanged!(options[i]) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected == options[i]
                        ? AppColors.cyan.withAlpha(40)
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected == options[i]
                          ? AppColors.cyan
                          : AppColors.border,
                    ),
                  ),
                  child: Text(
                    labels[i],
                    style: AppTextStyles.labelSmall.copyWith(
                      color: selected == options[i]
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

class _HoursPicker extends StatelessWidget {
  const _HoursPicker({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<int> options;
  final int selected;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < options.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < options.length - 1 ? 8 : 0),
              child: GestureDetector(
                onTap: onChanged != null ? () => onChanged!(options[i]) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected == options[i]
                        ? AppColors.cyan.withAlpha(40)
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected == options[i]
                          ? AppColors.cyan
                          : AppColors.border,
                    ),
                  ),
                  child: Text(
                    '${options[i]}h',
                    style: AppTextStyles.monoSmall.copyWith(
                      color: selected == options[i]
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

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.labelSmall,
        ),
        const Spacer(),
        Text(value, style: AppTextStyles.monoSmall),
      ],
    );
  }
}
