import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/review_log_repository.dart';

final _summaryProvider = FutureProvider.autoDispose((ref) async {
  final logRepo = ref.read(reviewLogRepositoryProvider);
  final todayCount = await logRepo.getTodayCount();
  final correctToday = await logRepo.getCorrectTodayCount();
  final streak = await _calcStreak(logRepo);
  return _SummaryData(
    totalReviewed: todayCount,
    correctCount: correctToday,
    streak: streak,
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

class _SummaryData {
  final int totalReviewed;
  final int correctCount;
  final int streak;
  const _SummaryData({required this.totalReviewed, required this.correctCount, required this.streak});
}

class ReviewSummaryScreen extends ConsumerWidget {
  const ReviewSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(_summaryProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: summary.when(
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Could not load summary'),
            data: (d) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.celebration, size: 64, color: Colors.amber),
                const SizedBox(height: 24),
                Text('Great session!', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                _SummaryRow(label: 'Words reviewed:', value: '${d.totalReviewed}'),
                _SummaryRow(label: 'Correct:', value: '${d.correctCount} (${d.totalReviewed > 0 ? (d.correctCount * 100 / d.totalReviewed).round() : 0}%)'),
                _SummaryRow(label: 'Streak:', value: '${d.streak} days'),
                const SizedBox(height: 32),
                Row(
                  children: [
                    if (d.totalReviewed > d.correctCount) ...[
                      Expanded(
                        child: OutlinedButton(onPressed: () {}, child: const Text('Review mistakes')),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: FilledButton(onPressed: () => context.go('/'), child: const Text('Done')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(width: 8),
          Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
