import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/error_banner.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/repositories/story_summary_repository.dart';

final _storiesProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.read(storyRepositoryProvider);
  final summaryRepo = ref.read(storySummaryRepositoryProvider);
  final stories = await repo.getAll();
  final hasWrittenToday = await summaryRepo.hasWrittenToday();
  return _StoriesData(stories: stories, hasWrittenToday: hasWrittenToday);
});

class _StoriesData {
  final List stories;
  final bool hasWrittenToday;
  const _StoriesData({required this.stories, required this.hasWrittenToday});
}

class StoriesHomeScreen extends ConsumerWidget {
  const StoriesHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_storiesProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorBanner(message: 'Could not load stories', onRetry: () => ref.invalidate(_storiesProvider)),
        data: (d) {
          if (d.stories.isEmpty) {
            return EmptyState(
              icon: Icons.auto_stories,
              title: 'No stories yet',
              body: 'Add a story to start summarizing',
              buttonLabel: 'Add your first story',
              onButtonPressed: () => context.go('/stories/add'),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (!d.hasWrittenToday)
                _DailyStoryCard(onTap: () => _startDailySummary(context, ref)),
              const SizedBox(height: 16),
              Text('All stories (${d.stories.length})', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...d.stories.map((s) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(s.isPreloaded ? Icons.auto_stories : Icons.edit_note, color: cs.primary),
                  title: Text(s.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${s.text.length} chars', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/stories/${s.uuid}'),
                ),
              )),
            ],
          );
        },
      ),
      floatingActionButton: data.hasValue
          ? FloatingActionButton.extended(
              onPressed: () => context.go('/stories/add'),
              icon: const Icon(Icons.add),
              label: const Text('Add story'),
            )
          : null,
    );
  }

  Future<void> _startDailySummary(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(storyRepositoryProvider);
    final story = await repo.getRandom();
    if (story == null) return;
    if (context.mounted) context.go('/stories/${story.uuid}/summarize');
  }
}

class _DailyStoryCard extends StatelessWidget {
  final VoidCallback onTap;
  const _DailyStoryCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.primaryContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.today, color: cs.onPrimaryContainer, size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily story', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: cs.onPrimaryContainer, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('Summarize a random story today', style: TextStyle(color: cs.onPrimaryContainer.withValues(alpha: 0.7), fontSize: 13)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: cs.onPrimaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}
