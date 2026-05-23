import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitalis/core/router/route_names.dart';
import 'package:orbitalis/features/home/presentation/home_screen.dart';
import 'package:orbitalis/features/launches/presentation/launch_detail_screen.dart';
import 'package:orbitalis/features/launches/presentation/launches_screen.dart';
import 'package:orbitalis/features/map/presentation/map_screen.dart';
import 'package:orbitalis/features/notifications/presentation/notifications_screen.dart';
import 'package:orbitalis/features/settings/presentation/settings_screen.dart';
import 'package:orbitalis/features/tracking/presentation/satellite_detail_screen.dart';
import 'package:orbitalis/features/tracking/presentation/tracking_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            _NavShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: RouteNames.map,
            builder: (_, __) => const MapScreen(),
          ),
          GoRoute(
            path: RouteNames.tracking,
            builder: (_, __) => const TrackingScreen(),
          ),
          GoRoute(
            path: RouteNames.launches,
            builder: (_, __) => const LaunchesScreen(),
          ),
          GoRoute(
            path: RouteNames.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.satelliteDetail,
        builder: (_, state) => SatelliteDetailScreen(
          noradId: state.pathParameters['noradId'] ?? '',
        ),
      ),
      GoRoute(
        path: RouteNames.launchDetail,
        builder: (_, state) => LaunchDetailScreen(
          launchId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: RouteNames.notifications,
        builder: (_, __) => const NotificationsScreen(),
      ),
    ],
  );
}

class _NavShell extends StatelessWidget {
  const _NavShell({required this.child});

  final Widget child;

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.map_rounded, label: 'Map'),
    _NavItem(icon: Icons.track_changes_rounded, label: 'Track'),
    _NavItem(icon: Icons.rocket_launch_rounded, label: 'Launches'),
    _NavItem(icon: Icons.settings_rounded, label: 'Settings'),
  ];

  static const List<String> _routes = [
    RouteNames.home,
    RouteNames.map,
    RouteNames.tracking,
    RouteNames.launches,
    RouteNames.settings,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = _routes.length - 1; i >= 0; i--) {
      if (location.startsWith(_routes[i]) && _routes[i] != '/') return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: _AnimatedNavBar(
        items: _items,
        currentIndex: current,
        onTap: (i) => context.go(_routes[i]),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _AnimatedNavBar extends StatelessWidget {
  const _AnimatedNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<_NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
