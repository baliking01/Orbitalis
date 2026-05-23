import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitalis/core/router/route_names.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/date_formatter.dart';
import 'package:orbitalis/features/launches/domain/entities/launch.dart';
import 'package:orbitalis/features/launches/presentation/providers/launch_providers.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';

class LaunchesStrip extends ConsumerWidget {
  const LaunchesStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchesAsync = ref.watch(upcomingLaunchesProvider);

    return SizedBox(
      height: 160,
      child: launchesAsync.when(
        loading: () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, __) =>
              const ShimmerCard(height: 160, width: 200),
        ),
        error: (e, _) => Center(
          child: Text(e.toString(), style: AppTextStyles.bodySmall),
        ),
        data: (launches) => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: launches.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) => _LaunchCard(
            launch: launches[i],
            index: i,
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

  Color get _statusColor => switch (launch.statusAbbrev) {
        'Go' => AppColors.green,
        'TBC' || 'TBD' => AppColors.orange,
        'Hold' => AppColors.red,
        _ => AppColors.textMuted,
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        RouteNames.launchDetail.replaceAll(':id', launch.id),
      ),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (launch.providerLogoUrl != null)
                    CachedNetworkImage(
                      imageUrl: launch.providerLogoUrl!,
                      height: 20,
                      width: 20,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.rocket_launch,
                        size: 20,
                        color: AppColors.textMuted,
                      ),
                    )
                  else
                    const Icon(
                      Icons.rocket_launch,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      launch.providerName,
                      style: AppTextStyles.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _statusColor),
                    ),
                    child: Text(
                      launch.statusAbbrev,
                      style: AppTextStyles.labelSmall
                          .copyWith(color: _statusColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  launch.name,
                  style: AppTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: 12,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormatter.relativeCountdown(launch.net),
                    style: AppTextStyles.monoSmall
                        .copyWith(color: AppColors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate(delay: (index * 80).ms).fadeIn().slideX(begin: 0.1),
    );
  }
}
