import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/error_banner.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../../data/repositories/word_repository.dart';
import '../../data/repositories/verb_repository.dart';
import '../../data/repositories/review_log_repository.dart';
import '../../data/repositories/preferences_repository.dart';
import '../../services/notification_provider.dart';

final _homeDataProvider = FutureProvider((ref) async {
  final wordRepo = ref.read(wordRepositoryProvider);
  final verbRepo = ref.read(verbRepositoryProvider);
  final logRepo = ref.read(reviewLogRepositoryProvider);
  final prefsRepo = ref.read(preferencesRepositoryProvider);
  final prefs = await prefsRepo.get();
  final dueWords = await wordRepo.getDueWords(limit: prefs.maxDailyReviews);
  final dueVerbs = await verbRepo.getDueVerbs(limit: 50);
  final totalWords = await wordRepo.getTotalCount();
  final masteredWords = await wordRepo.getMastered();
  final difficultWords = await wordRepo.getDifficult();
  final streak = await _calculateStreak(logRepo);
  final notificationService = ref.read(notificationServiceProvider);
  try {
    await notificationService.scheduleHourlyReview(prefs);
  } catch (_) {}
  return _HomeData(
    dueWords: dueWords.length,
    dueVerbs: dueVerbs.length,
    totalWords: totalWords,
    masteredWords: masteredWords.length,
    difficultWords: difficultWords.length,
    streak: streak,
  );
});

Future<int> _calculateStreak(ReviewLogRepository logRepo) async {
  int streak = 0;
  final now = DateTime.now();
  for (int i = 0; i < 365; i++) {
    final date = DateTime(now.year, now.month, now.day - i);
    final next = date.add(const Duration(days: 1));
    final count = await logRepo.getByDateRange(date, next);
    if (count.isNotEmpty) {
      streak++;
    } else if (i > 0) {
      break;
    }
  }
  return streak;
}

class _HomeData {
  final int dueWords;
  final int dueVerbs;
  final int totalWords;
  final int masteredWords;
  final int difficultWords;
  final int streak;
  const _HomeData({
    required this.dueWords,
    required this.dueVerbs,
    required this.totalWords,
    required this.masteredWords,
    required this.difficultWords,
    required this.streak,
  });
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_homeDataProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(_homeDataProvider),
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text('${AppDateUtils.greeting()}, learner'),
              actions: [
                InkWell(
                  onTap: () => context.go('/stats'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          data.when(data: (d) => '${d.streak}', error: (_, __) => '0', loading: () => '-'),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: data.when(
                loading: () => SliverToBoxAdapter(child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: LoadingShimmer(itemCount: 3, itemHeight: 120),
                )),
                error: (e, _) => SliverToBoxAdapter(child: ErrorBanner(
                  message: 'Could not load today\'s data',
                  onRetry: () => ref.invalidate(_homeDataProvider),
                )),
                data: (d) => SliverList(
                  delegate: SliverChildListDelegate([
                    _TodayReviewCard(dueWords: d.dueWords, dueVerbs: d.dueVerbs, onStartReview: () => context.go('/review'), onSkip: () {}),
                    const SizedBox(height: 16),
                    _TestCard(onStartTest: () => context.go('/test')),
                    const SizedBox(height: 24),
                    SectionHeader(title: 'Your progress', trailingLabel: 'See all', onTrailingTap: () => context.go('/stats')),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: [
                        StatCard(label: 'Streak', value: '${d.streak} days', icon: Icons.local_fire_department, color: Colors.amber),
                        StatCard(label: 'Total words', value: '${d.totalWords}', icon: Icons.menu_book),
                        StatCard(label: 'Mastered', value: '${d.masteredWords}', icon: Icons.emoji_events, color: Colors.teal),
                        StatCard(label: 'Difficult', value: '${d.difficultWords}', icon: Icons.warning, color: Colors.red.shade300),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SectionHeader(title: 'Quick actions'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _QuickActionTile(label: 'Add Word', icon: Icons.add, onTap: () => context.go('/vocabulary/add')),
                        _QuickActionTile(label: 'Add Verb', icon: Icons.add_circle, onTap: () => context.go('/verbs/add')),
                        _QuickActionTile(label: 'Vocabulary', icon: Icons.book, onTap: () => context.go('/vocabulary')),
                        _QuickActionTile(label: 'Irregular Verbs', icon: Icons.shuffle, onTap: () => context.go('/verbs')),
                        _QuickActionTile(label: 'Test', icon: Icons.quiz, onTap: () => context.go('/test')),
                        _QuickActionTile(label: 'Statistics', icon: Icons.bar_chart, onTap: () => context.go('/stats')),
                        _QuickActionTile(label: 'Settings', icon: Icons.settings, onTap: () => context.go('/settings')),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 0),
    );
  }
}

class _TodayReviewCard extends StatelessWidget {
  final int dueWords;
  final int dueVerbs;
  final VoidCallback onStartReview;
  final VoidCallback onSkip;

  const _TodayReviewCard({required this.dueWords, required this.dueVerbs, required this.onStartReview, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = dueWords + dueVerbs;
    final estimatedMin = (total * 0.5).round().clamp(1, 60);

    if (total == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.check_circle, size: 48, color: Colors.teal),
              const SizedBox(height: 12),
              const Text("You're all caught up!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              OutlinedButton(onPressed: () {}, child: const Text('Browse vocabulary')),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Today's review", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const Spacer(),
                Text('\u2248 $estimatedMin min', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _MetricTile(label: 'Words', value: '$dueWords'),
                _MetricTile(label: 'Verbs', value: '$dueVerbs'),
                _MetricTile(label: 'Time', value: '$estimatedMin min'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: onStartReview, child: const Text('Start Review'))),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: TextButton(onPressed: onSkip, child: const Text('Skip for today'))),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  const _MetricTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionTile({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: (MediaQuery.of(context).size.width - 56) / 3,
        height: 100,
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: cs.primary, size: 28),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _TestCard extends StatelessWidget {
  final VoidCallback onStartTest;
  const _TestCard({required this.onStartTest});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.quiz, color: cs.primary, size: 24),
                const SizedBox(width: 12),
                Text('Test your vocabulary', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Random words and verbs — type the answer or write an example', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 48, child: OutlinedButton.icon(
              onPressed: onStartTest,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Test'),
            )),
          ],
        ),
      ),
    );
  }
}


