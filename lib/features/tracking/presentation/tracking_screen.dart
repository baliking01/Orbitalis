import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/unit_converter.dart';
import 'package:orbitalis/features/settings/presentation/providers/settings_providers.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite_position.dart';
import 'package:orbitalis/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:orbitalis/shared/widgets/error_state_widget.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/orbitalis_app_bar.dart';
import 'package:orbitalis/shared/widgets/section_header.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';

final _satelliteFilterProvider = StateProvider<String>((ref) => '');

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(_satelliteFilterProvider);
    final satellitesAsync = ref.watch(satellitesProvider);
    final favoriteIds =
        ref.watch(appSettingsNotifierProvider).valueOrNull?.favoriteNoradIds ??
            const <String>[];

    return Scaffold(
      appBar: const OrbitalisAppBar(title: 'Satellites'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: _SearchBar(
              onChanged: (v) =>
                  ref.read(_satelliteFilterProvider.notifier).state = v,
            ),
          ),
          Expanded(
            child: satellitesAsync.when(
              loading: () => const _LoadingList(),
              error: (e, _) => ErrorStateWidget(
                message: 'Could not load satellites',
                onRetry: () => ref.invalidate(satellitesProvider),
              ),
              data: (satellites) {
                final filtered = query.isEmpty
                    ? satellites
                    : satellites
                        .where(
                          (s) =>
                              s.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              s.noradId.contains(query),
                        )
                        .toList();

                final favorites = filtered
                    .where((s) => favoriteIds.contains(s.noradId))
                    .toList();
                final others = filtered
                    .where((s) => !favoriteIds.contains(s.noradId))
                    .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'No satellites found',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textMuted),
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  children: [
                    if (favorites.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: SectionHeader(title: 'Starred'),
                      ),
                      for (var i = 0; i < favorites.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _SatelliteRow(
                            satellite: favorites[i],
                            index: i,
                            isFavorite: true,
                          ),
                        ),
                      const SizedBox(height: 8),
                      if (others.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: SectionHeader(title: 'All Satellites'),
                        ),
                    ],
                    for (var i = 0; i < others.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _SatelliteRow(
                          satellite: others[i],
                          index:
                              favorites.isNotEmpty ? i + favorites.length : i,
                          isFavorite: false,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Text(
                        '${satellites.length} satellites loaded',
                        style: AppTextStyles.monoSmall
                            .copyWith(color: AppColors.textMuted),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium,
              decoration: const InputDecoration(
                hintText: 'Search by name or NORAD ID',
                hintStyle: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              cursorColor: AppColors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row widget for a single satellite.
///
/// Starred satellites subscribe to a live [satellitePositionProvider] stream
/// (updates every ~15 s). Untracked satellites display the static altitude
/// already baked into the [Satellite] entity at catalog-load time — no stream,
/// no extra SGP4 calls per row.
class _SatelliteRow extends ConsumerWidget {
  const _SatelliteRow({
    required this.satellite,
    required this.index,
    required this.isFavorite,
  });

  final Satellite satellite;
  final int index;
  final bool isFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only subscribe to a live position stream for starred satellites.
    // Untracked rows use the static altitude baked in at catalog load time.
    SatellitePosition? livePos;
    if (isFavorite) {
      livePos =
          ref.watch(satellitePositionProvider(satellite.noradId)).valueOrNull;
    }

    final altKm = livePos?.altitudeKm ?? satellite.altitudeKm;
    final velKms = livePos?.velocityKmS ?? satellite.velocityKmS;
    final isMetric = ref.watch(isMetricProvider);

    return GestureDetector(
      onTap: () => context.push('/tracking/${satellite.noradId}'),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            _OrbitIcon(noradId: satellite.noradId),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isFavorite) ...[
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.orange,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          satellite.name,
                          style: AppTextStyles.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'NORAD ${satellite.noradId}',
                    style: AppTextStyles.monoSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (altKm > 0)
              _AltitudeBadge(
                altKm: altKm,
                velKms: velKms,
                isLive: isFavorite,
                isMetric: isMetric,
              ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFavorite ? AppColors.orange : AppColors.textMuted,
                size: 18,
              ),
              iconSize: 18,
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(),
              onPressed: () => ref
                  .read(appSettingsNotifierProvider.notifier)
                  .toggleFavorite(satellite.noradId),
            ),
          ],
        ),
      ).animate(delay: (index * 20).ms).fadeIn(duration: 200.ms),
    );
  }
}

class _OrbitIcon extends StatelessWidget {
  const _OrbitIcon({required this.noradId});

  final String noradId;

  @override
  Widget build(BuildContext context) {
    final isIss = noradId == '25544';
    final color = isIss ? AppColors.cyan : AppColors.electricBlue;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Icon(
        isIss ? Icons.language_rounded : Icons.satellite_alt_rounded,
        color: color,
        size: 18,
      ),
    );
  }
}

class _AltitudeBadge extends StatelessWidget {
  const _AltitudeBadge({
    required this.altKm,
    required this.velKms,
    required this.isLive,
    required this.isMetric,
  });

  final double altKm;
  final double velKms;
  final bool isLive;
  final bool isMetric;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLive) ...[
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 3),
            ],
            Text(
              UnitConverter.formatAltitude(altKm, metric: isMetric),
              style: AppTextStyles.monoSmall.copyWith(color: AppColors.cyan),
            ),
          ],
        ),
        Text(
          UnitConverter.formatVelocity(velKms, metric: isMetric),
          style: AppTextStyles.monoSmall,
        ),
      ],
    );
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: 8,
      itemBuilder: (_, __) => const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: ShimmerCard(height: 64),
      ),
    );
  }
}
