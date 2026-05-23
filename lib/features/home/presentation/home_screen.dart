import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/features/home/presentation/providers/home_providers.dart';
import 'package:orbitalis/features/home/presentation/widgets/iss_card.dart';
import 'package:orbitalis/features/home/presentation/widgets/launches_strip.dart';
import 'package:orbitalis/features/home/presentation/widgets/news_feed.dart';
import 'package:orbitalis/features/home/presentation/widgets/quick_actions_bar.dart';
import 'package:orbitalis/features/launches/presentation/providers/launch_providers.dart';
import 'package:orbitalis/shared/animations/fade_slide_transition.dart';
import 'package:orbitalis/shared/widgets/orbitalis_app_bar.dart';
import 'package:orbitalis/shared/widgets/section_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const OrbitalisAppBar(title: 'Orbitalis'),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(spaceNewsProvider)
            ..invalidate(upcomingLaunchesProvider);
        },
        color: AppColors.cyan,
        backgroundColor: AppColors.surface,
        child: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              sliver: SliverToBoxAdapter(
                child: FadeSlideIn(child: IssCard()),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              sliver: SliverToBoxAdapter(
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 80),
                  child: SectionHeader(title: 'Upcoming Launches'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FadeSlideIn(
                delay: Duration(milliseconds: 120),
                child: LaunchesStrip(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
              sliver: SliverToBoxAdapter(
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 160),
                  child: SectionHeader(title: 'Quick Actions'),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 200),
                  child: QuickActionsBar(),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
              sliver: SliverToBoxAdapter(
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 240),
                  child: SectionHeader(title: 'Space News'),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverToBoxAdapter(
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 280),
                  child: NewsFeed(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
