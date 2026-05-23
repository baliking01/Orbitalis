import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/coordinate_formatter.dart';
import 'package:orbitalis/core/utils/unit_converter.dart';
import 'package:orbitalis/features/settings/presentation/providers/settings_providers.dart';
import 'package:orbitalis/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:orbitalis/shared/widgets/data_readout.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/glow_border.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';
import 'package:orbitalis/shared/widgets/status_dot.dart';

class IssCard extends ConsumerWidget {
  const IssCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posAsync = ref.watch(issPositionProvider);
    final isMetric = ref.watch(isMetricProvider);

    return GlowBorder(
      // Disable continuous animation on web to avoid unnecessary repaints
      animate: !kIsWeb,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        glowColor: AppColors.cyan,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.language_rounded,
                  color: AppColors.cyan,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'ISS — SPACE STATION',
                    style: AppTextStyles.titleSmall
                        .copyWith(color: AppColors.cyan),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const StatusDot(),
                const SizedBox(width: 4),
                const Text('LIVE', style: AppTextStyles.labelSmall),
              ],
            ),
            const SizedBox(height: 16),
            posAsync.when(
              loading: () => const ShimmerCard(height: 64),
              error: (_, __) => const Text(
                'Signal lost — awaiting TLE data',
                style: AppTextStyles.monoSmall,
              ),
              data: (pos) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ).animate().fadeIn(duration: 400.ms),
            ),
          ],
        ),
      ),
    );
  }
}
