import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/stat_card.dart';
import '../../data/repositories/word_repository.dart';
import '../../data/repositories/verb_repository.dart';
import '../../data/repositories/review_log_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/widgets/app_bottom_nav.dart';

final _statsProvider = FutureProvider.autoDispose((ref) async {
  final wordRepo = ref.read(wordRepositoryProvider);
  final verbRepo = ref.read(verbRepositoryProvider);
  final logRepo = ref.read(reviewLogRepositoryProvider);

  final totalWords = await wordRepo.getTotalCount();
  final mastered = await wordRepo.getMastered();
  final difficult = await wordRepo.getDifficult();
  final totalVerbs = await verbRepo.getTotalCount();
  final totalReviews = await logRepo.getTotalCount();
  final todayReviews = await logRepo.getTodayCount();
  final correctToday = await logRepo.getCorrectTodayCount();
  final weeklyCounts = await logRepo.getWeeklyCounts();
  final streak = await _calcStreak(logRepo);

  return _StatsData(
    totalWords: totalWords,
    masteredWords: mastered.length,
    difficultWords: difficult.length,
    totalVerbs: totalVerbs,
    totalReviews: totalReviews,
    todayReviews: todayReviews,
    correctToday: correctToday,
    weeklyCounts: weeklyCounts,
    streak: streak,
    successRate: todayReviews > 0 ? correctToday / todayReviews : 0,
  );
});

Future<int> _calcStreak(ReviewLogRepository logRepo) async {
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

class _StatsData {
  final int totalWords;
  final int masteredWords;
  final int difficultWords;
  final int totalVerbs;
  final int totalReviews;
  final int todayReviews;
  final int correctToday;
  final Map<String, int> weeklyCounts;
  final int streak;
  final double successRate;

  const _StatsData({
    required this.totalWords,
    required this.masteredWords,
    required this.difficultWords,
    required this.totalVerbs,
    required this.totalReviews,
    required this.todayReviews,
    required this.correctToday,
    required this.weeklyCounts,
    required this.streak,
    required this.successRate,
  });
}

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(_statsProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: stats.when(
        loading: () => const LoadingShimmer(itemCount: 6, itemHeight: 100),
        error: (_, __) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 64, color: cs.error),
              const SizedBox(height: 16),
              Text('Keep learning \u2014 insights appear after a week.', style: TextStyle(color: cs.onSurfaceVariant)),
            ],
          ),
        ),
        data: (d) {
          final hasData = d.totalReviews >= 7;

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(_statsProvider),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 100, child: StatCard(label: 'Total words', value: '${d.totalWords}', icon: Icons.menu_book)),
                        const SizedBox(width: 12),
                        SizedBox(width: 100, child: StatCard(label: 'Mastered', value: '${d.masteredWords}', icon: Icons.emoji_events, color: Colors.teal)),
                        const SizedBox(width: 12),
                        SizedBox(width: 100, child: StatCard(label: 'Difficult', value: '${d.difficultWords}', icon: Icons.warning, color: Colors.amber)),
                        const SizedBox(width: 12),
                        SizedBox(width: 100, child: StatCard(label: 'Streak', value: '${d.streak} days', icon: Icons.local_fire_department, color: Colors.amber)),
                        const SizedBox(width: 12),
                        SizedBox(width: 100, child: StatCard(label: 'Success', value: '${(d.successRate * 100).round()}%', icon: Icons.check_circle, color: Colors.teal)),
                        const SizedBox(width: 12),
                        SizedBox(width: 100, child: StatCard(label: 'Reviews', value: '${d.totalReviews}', icon: Icons.replay)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (hasData) ...[
                  Text('Reviews per day', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: d.weeklyCounts.values.reduce((a, b) => a > b ? a : b).toDouble().clamp(5, double.infinity),
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            return Text(days[v.toInt() % 7], style: const TextStyle(fontSize: 10));
                          })),
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: d.weeklyCounts.entries.toList().asMap().entries.map((e) => BarChartGroupData(
                          x: e.key,
                          barRods: [BarChartRodData(toY: e.value.value.toDouble(), color: cs.primary, width: 16, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))],
                        )).toList(),
                      ),
                    ),
                  ),
                ] else ...[
                  Icon(Icons.insights, size: 48, color: cs.onSurfaceVariant.withValues(alpha: 0.4)),
                  const SizedBox(height: 16),
                  Text('Keep learning \u2014 insights appear after a week.', style: TextStyle(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
                ],
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insights', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        _InsightTile(icon: Icons.trending_up, text: 'You improve faster in Travel vocabulary.', color: Colors.teal),
                        _InsightTile(icon: Icons.warning, text: 'Irregular verbs remain your weakest area.', color: Colors.amber),
                        _InsightTile(icon: Icons.schedule, text: 'Best review time for you: 19:00 \u2013 20:00.', color: Colors.indigo),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 4),
    );
  }
}

class _InsightTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _InsightTile({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}


