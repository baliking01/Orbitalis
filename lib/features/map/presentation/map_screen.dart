import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:orbitalis/core/constants/map_constants.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/features/settings/presentation/providers/settings_providers.dart';
import 'package:orbitalis/features/tracking/domain/entities/satellite_position.dart';
import 'package:orbitalis/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();

  void _centerOnIss(SatellitePosition pos) {
    _mapController.move(
      LatLng(pos.latitude, pos.longitude),
      MapConstants.detailZoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final issAsync = ref.watch(issPositionProvider);
    final settingsAsync = ref.watch(appSettingsNotifierProvider);
    final favoriteIds = settingsAsync.valueOrNull?.favoriteNoradIds ?? const [];

    // Only watch position streams for favorited satellites (max ~10)
    final favPositions = {
      for (final id in favoriteIds)
        id: ref.watch(satellitePositionProvider(id)),
    };

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: MapConstants.defaultCenter,
              initialZoom: MapConstants.defaultZoom,
              maxZoom: MapConstants.maxZoom,
              backgroundColor: AppColors.background,
            ),
            children: [
              TileLayer(
                urlTemplate: MapConstants.darkTileUrl,
                subdomains: MapConstants.tileSubdomains,
                tileProvider: CancellableNetworkTileProvider(),
                userAgentPackageName: 'com.orbitalis.app',
              ),
              MarkerLayer(
                markers: [
                  // Favorited satellites
                  for (final entry in favPositions.entries)
                    if (entry.value.valueOrNull != null)
                      _satMarker(
                        entry.value.value!,
                        entry.key,
                        context,
                      ),
                  // ISS always shown
                  if (issAsync.valueOrNull != null)
                    _issMarker(issAsync.value!, context),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: _MapHeader(
              issAsync: issAsync,
              trackedCount: favoriteIds.length,
            ),
          ),
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MapFab(
                  icon: Icons.my_location_rounded,
                  tooltip: 'Center on ISS',
                  onPressed: issAsync.valueOrNull != null
                      ? () => _centerOnIss(issAsync.value!)
                      : null,
                ),
                const SizedBox(height: 8),
                _MapFab(
                  icon: Icons.zoom_out_map_rounded,
                  tooltip: 'World view',
                  onPressed: () => _mapController.move(
                    MapConstants.defaultCenter,
                    MapConstants.defaultZoom,
                  ),
                ),
              ],
            ),
          ),
          if (favoriteIds.isEmpty)
            const Positioned(
              bottom: 88,
              left: 16,
              right: 16,
              child: GlassContainer(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.cyan,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Star satellites in the Tracking tab to show them on the map.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Marker _issMarker(SatellitePosition pos, BuildContext context) {
    return Marker(
      point: LatLng(pos.latitude, pos.longitude),
      width: 32,
      height: 32,
      child: GestureDetector(
        onTap: () => context.push('/tracking/25544'),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cyan.withAlpha(40),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.cyan, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyan.withAlpha(100),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.language_rounded,
            color: AppColors.cyan,
            size: 18,
          ),
        ),
      ),
    );
  }

  Marker _satMarker(
    SatellitePosition pos,
    String noradId,
    BuildContext context,
  ) {
    return Marker(
      point: LatLng(pos.latitude, pos.longitude),
      width: 14,
      height: 14,
      child: GestureDetector(
        onTap: () => context.push('/tracking/$noradId'),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.electricBlue.withAlpha(200),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.electricBlue),
          ),
        ),
      ),
    );
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({required this.issAsync, required this.trackedCount});

  final AsyncValue<SatellitePosition> issAsync;
  final int trackedCount;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.map_rounded, color: AppColors.cyan, size: 16),
          const SizedBox(width: 8),
          Text(
            'LIVE MAP',
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.cyan),
          ),
          const Spacer(),
          Text(
            'ISS + $trackedCount tracked',
            style: AppTextStyles.monoSmall,
          ),
        ],
      ),
    );
  }
}

class _MapFab extends StatelessWidget {
  const _MapFab({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: IconButton(
        icon: Icon(icon, color: AppColors.cyan, size: 20),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
