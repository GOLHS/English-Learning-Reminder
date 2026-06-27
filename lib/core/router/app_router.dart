import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/frequency_screen.dart';
import '../../features/onboarding/custom_frequency_screen.dart';
import '../../features/onboarding/notification_setup_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/vocabulary/vocabulary_list_screen.dart';
import '../../features/vocabulary/add_word_screen.dart';
import '../../features/vocabulary/word_detail_screen.dart';
import '../../features/review/review_session_screen.dart';
import '../../features/review/review_summary_screen.dart';
import '../../features/verbs/verbs_home_screen.dart';
import '../../features/verbs/verb_review_screen.dart';
import '../../features/verbs/add_verb_screen.dart';
import '../../features/verbs/verb_detail_screen.dart';
import '../../features/statistics/statistics_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/notification_settings_screen.dart';
import '../../features/settings/learning_settings_screen.dart';
import '../../features/settings/data_settings_screen.dart';
import '../../features/settings/ai_settings_screen.dart';
import '../../features/archive/archive_screen.dart';
import '../../features/stories/stories_home_screen.dart';
import '../../features/stories/add_story_screen.dart';
import '../../features/stories/story_detail_screen.dart';
import '../../features/stories/write_summary_screen.dart';
import '../../features/test/test_screen.dart';
import '../../data/repositories/preferences_repository.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(preferencesRepositoryProvider);
  return AppRouter(prefs).router;
});

class AppRouter {
  final PreferencesRepository _prefs;
  AppRouter(this._prefs);

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (_, state) => NoTransitionPage(key: state.pageKey, child: const OnboardingScreen()),
      ),
      GoRoute(
        path: '/onboarding/frequency',
        pageBuilder: (_, state) => NoTransitionPage(key: state.pageKey, child: const FrequencyScreen()),
      ),
      GoRoute(
        path: '/onboarding/custom',
        pageBuilder: (_, state) => NoTransitionPage(key: state.pageKey, child: const CustomFrequencyScreen()),
      ),
      GoRoute(
        path: '/onboarding/notifications',
        pageBuilder: (_, state) => NoTransitionPage(key: state.pageKey, child: const NotificationSetupScreen()),
      ),
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(path: 'vocabulary', builder: (_, __) => const VocabularyListScreen()),
          GoRoute(path: 'vocabulary/add', builder: (_, __) => const AddWordScreen()),
          GoRoute(path: 'vocabulary/:id', builder: (_, state) => WordDetailScreen(id: state.pathParameters['id']!)),
          GoRoute(path: 'vocabulary/:id/edit', builder: (_, state) => AddWordScreen(wordId: state.pathParameters['id']!)),
          GoRoute(path: 'review', builder: (_, __) => const ReviewSessionScreen()),
          GoRoute(path: 'review/summary', builder: (_, __) => const ReviewSummaryScreen()),
          GoRoute(path: 'test', builder: (_, __) => const TestModeScreen()),
          GoRoute(path: 'test/vocab', builder: (_, __) => const VocabTestScreen()),
          GoRoute(path: 'test/verbs', builder: (_, __) => const VerbTestScreen()),
          GoRoute(path: 'verbs', builder: (_, __) => const VerbsHomeScreen()),
          GoRoute(path: 'stories', builder: (_, __) => const StoriesHomeScreen()),
          GoRoute(path: 'stories/add', builder: (_, __) => const AddStoryScreen()),
          GoRoute(path: 'stories/:id', builder: (_, state) => StoryDetailScreen(id: state.pathParameters['id']!)),
          GoRoute(path: 'stories/:id/edit', builder: (_, state) => AddStoryScreen(storyId: state.pathParameters['id']!)),
          GoRoute(path: 'stories/:id/summarize', builder: (_, state) => WriteSummaryScreen(storyId: state.pathParameters['id']!)),
          GoRoute(path: 'verbs/review', builder: (_, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'classic';
            return VerbReviewScreen(mode: mode);
          }),
          GoRoute(path: 'verbs/add', builder: (_, __) => const AddVerbScreen()),
          GoRoute(path: 'verbs/:id', builder: (_, state) => VerbDetailScreen(id: state.pathParameters['id']!)),
          GoRoute(path: 'verbs/:id/edit', builder: (_, state) => AddVerbScreen(verbId: state.pathParameters['id']!)),
          GoRoute(path: 'stats', builder: (_, __) => const StatisticsScreen()),
          GoRoute(path: 'settings', builder: (_, __) => const SettingsScreen()),
          GoRoute(path: 'settings/notifications', builder: (_, __) => const NotificationSettingsScreen()),
          GoRoute(path: 'settings/learning', builder: (_, __) => const LearningSettingsScreen()),
          GoRoute(path: 'settings/ai', builder: (_, __) => const AiSettingsScreen()),
          GoRoute(path: 'settings/data', builder: (_, __) => const DataSettingsScreen()),
          GoRoute(path: 'archive', builder: (_, __) => const ArchiveScreen()),
        ],
      ),
    ],
  );
}
