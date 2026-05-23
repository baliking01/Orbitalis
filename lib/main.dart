import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitalis/core/router/app_router.dart';
import 'package:orbitalis/core/services/hive_service.dart';
import 'package:orbitalis/core/services/notification_service.dart';
import 'package:orbitalis/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await NotificationService.instance.init();
  runApp(const ProviderScope(child: OrbitalisApp()));
}

class OrbitalisApp extends ConsumerWidget {
  const OrbitalisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Orbitalis',
      theme: AppTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
