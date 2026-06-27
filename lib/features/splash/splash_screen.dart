import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/preferences_repository.dart';

final _splashProvider = FutureProvider<void>((ref) async {
  final prefs = await ref.read(preferencesRepositoryProvider).get();
  await Future.delayed(const Duration(milliseconds: 800));
  ref.read(splashNavProvider.notifier).state = prefs.onboardingCompleted ? '/' : '/onboarding';
});

final splashNavProvider = StateProvider<String?>((_) => null);

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(splashNavProvider);
    ref.watch(_splashProvider);

    ref.listen(splashNavProvider, (_, next) {
      if (next != null) context.go(next);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(Icons.auto_stories, size: 60, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text(AppConstants.appName, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(AppConstants.appTagline, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 48),
            const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
          ],
        ),
      ),
    );
  }
}
