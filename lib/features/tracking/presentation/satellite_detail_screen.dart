import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/coordinate_formatter.dart';
import 'package:orbitalis/core/utils/unit_converter.dart';
import 'package:orbitalis/features/settings/presentation/providers/settings_providers.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite_position.dart';
import 'package:orbitalis/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:orbitalis/shared/widgets/data_readout.dart';
import 'package:orbitalis/shared/widgets/error_state_widget.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/glow_border.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';
import 'package:orbitalis/shared/widgets/status_dot.dart';

class SatelliteDetailScreen extends ConsumerWidget {
  const SatelliteDetailScreen({required this.noradId, super.key});

  final String noradId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final satellitesAsync = ref.watch(satellitesProvider);
    final posAsync = ref.watch(satellitePositionProvider(noradId));
    final settingsAsync = ref.watch(appSettingsNotifierProvider);
    final isMetric = ref.watch(isMetricProvider);
    final isFavorite = settingsAsync.valueOrNull?.favoriteNoradIds
            .contains(noradId) ??
        false;

    final satellite = satellitesAsync.valueOrNull?.firstWhere(
      (s) => s.noradId == noradId,
      orElse: () => Satellite(
        noradId: noradId,
        name: 'NORAD $noradId',
        line1: '',
        line2: '',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/tracking'),
        ),
        title: Text(
          satellite?.name ?? 'NORAD $noradId',
          style: AppTextStyles.headlineMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
              color: isFavorite ? AppColors.orange : AppColors.textMuted,
            ),
            onPressed: () => ref
                .read(appSettingsNotifierProvider.notifier)
                .toggleFavorite(noradId),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _LiveTelemetry(noradId: noradId, posAsync: posAsync, isMetric: isMetric),
            const SizedBox(height: 16),
            if (satellite != null) _OrbitalParams(satellite: satellite),
            const SizedBox(height: 16),
            _TleSection(satellite: satellite, noradId: noradId),
          ],
        ),
      ),
    );
  }
}

class _LiveTelemetry extends StatelessWidget {
  const _LiveTelemetry({
    required this.noradId,
    required this.posAsync,
    required this.isMetric,
  });

  final String noradId;
  final AsyncValue<SatellitePosition> posAsync;
  final bool isMetric;

  @override
  Widget build(BuildContext context) {
    return GlowBorder(
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        glowColor: AppColors.cyan,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const StatusDot(),
                const SizedBox(width: 6),
                Text(
                  'LIVE TELEMETRY',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.cyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            posAsync.when(
              loading: () => const ShimmerCard(height: 80),
              error: (_, __) => const ErrorStateWidget(
                message: 'Telemetry unavailable',
              ),
              data: (pos) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DataReadout(
                          label: 'Altitude',
                          value: UnitConverter.formatAltitude(pos.altitudeKm, metric: isMetric),
                          valueStyle: AppTextStyles.monoLarge,
                        ),
                      ),
                      Expanded(
                        child: DataReadout(
                          label: 'Velocity',
                          value: UnitConverter.formatVelocity(pos.velocityKmS, metric: isMetric),
                          valueStyle: AppTextStyles.monoMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DataReadout(
                    label: 'Position',
                    value: CoordinateFormatter.latLon(
                      pos.latitude,
                      pos.longitude,
                    ),
                    valueStyle: AppTextStyles.monoMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DataReadout(
                          label: 'Latitude',
                          value: CoordinateFormatter.latitude(pos.latitude),
                          valueStyle: AppTextStyles.monoSmall,
                        ),
                      ),
                      Expanded(
                        child: DataReadout(
                          label: 'Longitude',
                          value: CoordinateFormatter.longitude(pos.longitude),
                          valueStyle: AppTextStyles.monoSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(duration: 300.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrbitalParams extends StatelessWidget {
  const _OrbitalParams({required this.satellite});

  final Satellite satellite;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ORBITAL PARAMETERS',
            style: AppTextStyles.titleSmall,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DataReadout(
                  label: 'NORAD ID',
                  value: satellite.noradId,
                  valueStyle: AppTextStyles.monoMedium,
                ),
              ),
              Expanded(
                child: DataReadout(
                  label: 'Period',
                  value: satellite.orbitalPeriodMin > 0
                      ? '${satellite.orbitalPeriodMin.toStringAsFixed(1)} min'
                      : '—',
                  valueStyle: AppTextStyles.monoMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TleSection extends StatelessWidget {
  const _TleSection({required this.satellite, required this.noradId});

  final Satellite? satellite;
  final String noradId;

  @override
  Widget build(BuildContext context) {
    final line1 = satellite?.line1 ?? '';
    final line2 = satellite?.line2 ?? '';
    if (line1.isEmpty) return const SizedBox.shrink();

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TLE DATA', style: AppTextStyles.titleSmall),
          const SizedBox(height: 12),
          Text(line1, style: AppTextStyles.monoSmall),
          const SizedBox(height: 4),
          Text(line2, style: AppTextStyles.monoSmall),
        ],
      ),
    );
  }
}
