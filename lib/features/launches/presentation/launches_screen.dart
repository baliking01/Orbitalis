import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/date_formatter.dart';
import 'package:orbitalis/features/launches/domain/entities/launch.dart';
import 'package:orbitalis/features/launches/presentation/providers/launch_providers.dart';
import 'package:orbitalis/shared/widgets/error_state_widget.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/orbitalis_app_bar.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';

class LaunchesScreen extends ConsumerStatefulWidget {
  const LaunchesScreen({super.key});

  @override
  ConsumerState<LaunchesScreen> createState() => _LaunchesScreenState();
}

class _LaunchesScreenState extends ConsumerState<LaunchesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrbitalisAppBar(
        title: 'Launches',
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.cyan,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.cyan,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: AppTextStyles.labelSmall.copyWith(letterSpacing: 1.4),
          tabs: const [
            Tab(text: 'UPCOMING'),
            Tab(text: 'PREVIOUS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _LaunchList(upcoming: true),
          _LaunchList(upcoming: false),
        ],
      ),
    );
  }
}

class _LaunchList extends ConsumerWidget {
  const _LaunchList({required this.upcoming});

  final bool upcoming;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchesAsync = upcoming
        ? ref.watch(upcomingLaunchesProvider)
        : ref.watch(previousLaunchesProvider);

    return RefreshIndicator(
      color: AppColors.cyan,
      backgroundColor: AppColors.surface,
      onRefresh: () async => ref.invalidate(
        upcoming ? upcomingLaunchesProvider : previousLaunchesProvider,
      ),
      child: launchesAsync.when(
        loading: () => ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          itemCount: 6,
          itemBuilder: (_, __) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: ShimmerCard(height: 96),
          ),
        ),
        error: (e, _) => ErrorStateWidget(
          message: 'Could not load launches',
          onRetry: () => ref.invalidate(
            upcoming ? upcomingLaunchesProvider : previousLaunchesProvider,
          ),
        ),
        data: (launches) => ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          itemCount: launches.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _LaunchCard(launch: launches[i], index: i),
          ),
        ),
      ),
    );
  }
}

class _LaunchCard extends StatelessWidget {
  const _LaunchCard({required this.launch, required this.index});

  final Launch launch;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isUpcoming = launch.net.isAfter(DateTime.now());
    return GestureDetector(
      onTap: () => context.push('/launches/${launch.id}'),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProviderLogo(logoUrl: launch.providerLogoUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _StatusChip(abbrev: launch.statusAbbrev),
                      const SizedBox(width: 8),
                      if (launch.missionType != null)
                        Flexible(
                          child: Text(
                            launch.missionType!.toUpperCase(),
                            style: AppTextStyles.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    launch.name,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${launch.rocketName} · ${launch.padLocation}',
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 12,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormatter.shortDateTime(launch.net),
                        style: AppTextStyles.monoSmall,
                      ),
                      if (isUpcoming) ...[
                        const SizedBox(width: 8),
                        _Countdown(net: launch.net),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ).animate(delay: (index * 40).ms).fadeIn().slideY(begin: 0.06),
    );
  }
}

class _ProviderLogo extends StatelessWidget {
  const _ProviderLogo({required this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: logoUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: logoUrl!,
                fit: BoxFit.contain,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.rocket_launch_rounded,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
            )
          : const Icon(
              Icons.rocket_launch_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.abbrev});

  final String abbrev;

  Color get _color {
    return switch (abbrev) {
      'Go' => AppColors.green,
      'TBC' || 'TBD' => AppColors.orange,
      'Success' => AppColors.green,
      'Failure' => AppColors.red,
      _ => AppColors.textMuted,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withAlpha(30),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _color.withAlpha(80)),
      ),
      child: Text(
        abbrev.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(color: _color),
      ),
    );
  }
}

class _Countdown extends StatelessWidget {
  const _Countdown({required this.net});

  final DateTime net;

  String _format(Duration d) {
    if (d.isNegative) return '';
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (h > 0) return 'T-${h}h${m}m';
    return 'T-${m}m${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final remaining = net.difference(DateTime.now());
    if (remaining.isNegative) return const SizedBox.shrink();
    return Text(
      _format(remaining),
      style: AppTextStyles.monoSmall.copyWith(color: AppColors.cyan),
    );
  }
}
