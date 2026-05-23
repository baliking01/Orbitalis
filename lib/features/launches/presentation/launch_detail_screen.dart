import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:orbitalis/core/constants/map_constants.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/date_formatter.dart';
import 'package:orbitalis/features/launches/domain/entities/launch.dart';
import 'package:orbitalis/features/launches/presentation/providers/launch_providers.dart';
import 'package:orbitalis/shared/widgets/data_readout.dart';
import 'package:orbitalis/shared/widgets/error_state_widget.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchDetailScreen extends ConsumerWidget {
  const LaunchDetailScreen({required this.launchId, super.key});

  final String launchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchAsync = ref.watch(launchByIdProvider(launchId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/launches'),
        ),
        title: launchAsync.maybeWhen(
          data: (l) => Text(
            l.name,
            style: AppTextStyles.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          orElse: () => const Text('Launch', style: AppTextStyles.headlineMedium),
        ),
      ),
      body: launchAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(16),
          child: ShimmerCard(height: 400),
        ),
        error: (e, _) => const ErrorStateWidget(message: 'Could not load launch'),
        data: (launch) => _LaunchBody(launch: launch),
      ),
    );
  }
}

class _LaunchBody extends StatelessWidget {
  const _LaunchBody({required this.launch});

  final Launch launch;

  @override
  Widget build(BuildContext context) {
    final isUpcoming = launch.net.isAfter(DateTime.now());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isUpcoming) _CountdownCard(net: launch.net),
          if (isUpcoming) const SizedBox(height: 16),
          _MissionCard(launch: launch),
          const SizedBox(height: 16),
          if (launch.missionDescription != null &&
              launch.missionDescription!.isNotEmpty)
            _DescriptionCard(description: launch.missionDescription!),
          if (launch.missionDescription != null &&
              launch.missionDescription!.isNotEmpty)
            const SizedBox(height: 16),
          if (launch.padLatitude != null && launch.padLongitude != null)
            _PadMapCard(
              name: launch.padName,
              lat: launch.padLatitude!,
              lon: launch.padLongitude!,
            ),
          if (launch.padLatitude != null && launch.padLongitude != null)
            const SizedBox(height: 16),
          if (launch.livestreamUrl != null)
            _LivestreamButton(url: launch.livestreamUrl!),
        ],
      ).animate().fadeIn(duration: 300.ms),
    );
  }
}

class _CountdownCard extends StatelessWidget {
  const _CountdownCard({required this.net});

  final DateTime net;

  @override
  Widget build(BuildContext context) {
    final remaining = net.difference(DateTime.now());
    final days = remaining.inDays;
    final hours = remaining.inHours.remainder(24);
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      glowColor: AppColors.cyan,
      child: Column(
        children: [
          Text(
            'LAUNCH COUNTDOWN',
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.cyan),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CountdownUnit(value: days, label: 'DAYS'),
              _Separator(),
              _CountdownUnit(value: hours, label: 'HRS'),
              _Separator(),
              _CountdownUnit(value: minutes, label: 'MIN'),
              _Separator(),
              _CountdownUnit(value: seconds, label: 'SEC'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: AppTextStyles.monoLarge,
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      ':',
      style: AppTextStyles.monoLarge.copyWith(color: AppColors.textMuted),
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({required this.launch});

  final Launch launch;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (launch.providerLogoUrl != null)
                CachedNetworkImage(
                  imageUrl: launch.providerLogoUrl!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.rocket_launch_rounded,
                    color: AppColors.textMuted,
                    size: 24,
                  ),
                )
              else
                const Icon(
                  Icons.rocket_launch_rounded,
                  color: AppColors.cyan,
                  size: 24,
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(launch.providerName, style: AppTextStyles.bodyMedium),
                    Text(
                      launch.rocketName,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DataReadout(
                  label: 'Status',
                  value: launch.statusAbbrev,
                  valueStyle: AppTextStyles.monoMedium.copyWith(
                    color: _statusColor(launch.statusAbbrev),
                  ),
                ),
              ),
              if (launch.probability != null)
                Expanded(
                  child: DataReadout(
                    label: 'Probability',
                    value: '${launch.probability}%',
                    valueStyle: AppTextStyles.monoMedium,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          DataReadout(
            label: 'NET',
            value: DateFormatter.shortDateTime(launch.net),
            valueStyle: AppTextStyles.monoMedium,
          ),
          const SizedBox(height: 12),
          DataReadout(
            label: 'Launch Pad',
            value: launch.padName,
            valueStyle: AppTextStyles.monoSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          DataReadout(
            label: 'Location',
            value: launch.padLocation,
            valueStyle: AppTextStyles.monoSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String abbrev) {
    return switch (abbrev) {
      'Go' => AppColors.green,
      'Success' => AppColors.green,
      'Failure' => AppColors.red,
      'TBC' || 'TBD' => AppColors.orange,
      _ => AppColors.textMuted,
    };
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MISSION', style: AppTextStyles.titleSmall),
          const SizedBox(height: 8),
          Text(description, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _PadMapCard extends StatelessWidget {
  const _PadMapCard({
    required this.name,
    required this.lat,
    required this.lon,
  });

  final String name;
  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    final center = LatLng(lat, lon);
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 200,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: MapConstants.detailZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: MapConstants.darkTileUrl,
                subdomains: MapConstants.tileSubdomains,
                userAgentPackageName: 'com.orbitalis.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: center,
                    width: 32,
                    height: 32,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.orange,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LivestreamButton extends StatelessWidget {
  const _LivestreamButton({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () async {
        final uri = Uri.tryParse(url);
        if (uri != null) await launchUrl(uri);
      },
      icon: const Icon(Icons.play_circle_rounded),
      label: const Text('Watch Livestream'),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.red.withAlpha(200),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
