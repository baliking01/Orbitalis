import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitalis/core/router/route_names.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';
import 'package:orbitalis/shared/widgets/glass_container.dart';

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  static const _actions = [
    _Action(Icons.map_rounded, 'Map', RouteNames.map),
    _Action(Icons.track_changes_rounded, 'Satellites', RouteNames.tracking),
    _Action(Icons.rocket_launch_rounded, 'Launches', RouteNames.launches),
    _Action(Icons.notifications_rounded, 'Alerts', RouteNames.notifications),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final action in _actions)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _ActionTile(action: action),
            ),
          ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.action});
  final _Action action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(action.route),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Icon(action.icon, color: AppColors.cyan, size: 22),
            const SizedBox(height: 6),
            Text(
              action.label,
              style: AppTextStyles.labelSmall
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Action {
  const _Action(this.icon, this.label, this.route);
  final IconData icon;
  final String label;
  final String route;
}
