import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/database/isar_service.dart';
import 'data/seed/seed_service.dart';
import 'services/notification_service.dart';
import 'services/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isarService = IsarService();
  await isarService.init();
  await SeedService(isarService).seedIfEmpty();
  final notificationService = NotificationService();
  try {
    await notificationService.init();
    await notificationService.requestPermissions();
  } catch (_) {}

  runApp(
    ProviderScope(
      overrides: [
        isarServiceProvider.overrideWithValue(isarService),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const VocabTrainerApp(),
    ),
  );
}

class VocabTrainerApp extends ConsumerStatefulWidget {
  const VocabTrainerApp({super.key});

  @override
  ConsumerState<VocabTrainerApp> createState() => _VocabTrainerAppState();
}

class _VocabTrainerAppState extends ConsumerState<VocabTrainerApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vocab Trainer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
