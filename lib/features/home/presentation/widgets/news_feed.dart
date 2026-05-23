import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/core/utils/date_formatter.dart';
import 'package:orbitalis/features/home/domain/entities/article.dart';
import 'package:orbitalis/features/home/presentation/providers/home_providers.dart';
import 'package:orbitalis/shared/widgets/error_state_widget.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';
import 'package:orbitalis/shared/widgets/shimmer_card.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeed extends ConsumerWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(spaceNewsProvider);
    return newsAsync.when(
      loading: () => const ShimmerList(itemCount: 3, itemHeight: 100),
      error: (e, _) => ErrorStateWidget(
        message: 'Could not load news',
        onRetry: () => ref.invalidate(spaceNewsProvider),
      ),
      data: (articles) => Column(
        children: [
          for (var i = 0; i < articles.take(6).length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ArticleCard(article: articles[i], index: i),
            ),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article, required this.index});

  final Article article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.tryParse(article.url);
        if (uri != null) await launchUrl(uri);
      },
      child: GlassContainer(
        child: Row(
          children: [
            if (article.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => const SizedBox(
                    width: 90,
                    height: 90,
                    child: Icon(
                      Icons.image_not_supported,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.newsSite.toUpperCase(),
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.cyan),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      style: AppTextStyles.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormatter.shortDateTime(article.publishedAt),
                      style: AppTextStyles.monoSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 250.ms),
    );
  }
}
