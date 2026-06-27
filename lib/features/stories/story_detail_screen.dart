import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/word_model.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/repositories/story_summary_repository.dart';
import '../../data/repositories/word_repository.dart';

final _storyDetailProvider = FutureProvider.autoDispose.family((ref, String uuid) async {
  final repo = ref.read(storyRepositoryProvider);
  final summaryRepo = ref.read(storySummaryRepositoryProvider);
  final story = await repo.getByUuid(uuid);
  final summaries = story != null ? await summaryRepo.getByStory(story.uuid) : [];
  return _StoryDetailData(story: story, summaries: summaries);
});

class _StoryDetailData {
  final dynamic story;
  final List summaries;
  const _StoryDetailData({required this.story, required this.summaries});
}

class StoryDetailScreen extends ConsumerWidget {
  final String id;
  const StoryDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_storyDetailProvider(id));
    final cs = Theme.of(context).colorScheme;

    return data.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading...'), leading: const BackButton()),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error'), leading: const BackButton()),
        body: const Center(child: Text('Could not load story')),
      ),
      data: (d) {
        final story = d.story;
        if (story == null) {
          return Scaffold(
            appBar: AppBar(leading: const BackButton()),
            body: const Center(child: Text('Story not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(story.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.go('/stories/${story.uuid}/edit'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (story.isPreloaded)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: cs.tertiaryContainer, borderRadius: BorderRadius.circular(8)),
                              child: Text('Pre-loaded', style: TextStyle(color: cs.onTertiaryContainer, fontSize: 11)),
                            ),
                          const Spacer(),
                          Text('${story.text.length} chars', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _TappableStoryText(
                        text: story.text,
                        onWordTap: (word) => _addWordToVocabulary(context, ref, word),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Summaries (${d.summaries.length})', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  FilledButton.icon(
                    onPressed: () => context.go('/stories/${story.uuid}/summarize'),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Write summary'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (d.summaries.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text('No summaries yet', style: TextStyle(color: cs.onSurfaceVariant)),
                  ),
                )
              else
                ...d.summaries.map((s) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: cs.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Text(_formatDate(s.summaryDate), style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
                            const Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (v) async {
                                if (v == 'delete') {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('Delete summary?'),
                                      content: const Text('This cannot be undone.'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                  );
                                  if (confirmed == true) {
                                    await ref.read(storySummaryRepositoryProvider).delete(s);
                                    ref.invalidate(_storyDetailProvider(id));
                                  }
                                }
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(s.text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)),
                      ],
                    ),
                  ),
                )),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addWordToVocabulary(BuildContext context, WidgetRef ref, String selectedWord) async {
    final wordCtrl = TextEditingController(text: selectedWord);
    final meaningCtrl = TextEditingController();
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add to vocabulary', style: Theme.of(ctx).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextField(
              controller: wordCtrl,
              decoration: const InputDecoration(labelText: 'Word', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: meaningCtrl,
              decoration: const InputDecoration(labelText: 'Meaning', border: OutlineInputBorder(), hintText: 'Enter meaning'),
              autofocus: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (wordCtrl.text.trim().isNotEmpty && meaningCtrl.text.trim().isNotEmpty) {
                    Navigator.pop(ctx, true);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );

    if (saved == true) {
      final repo = ref.read(wordRepositoryProvider);
      final word = Word.create(
        word: wordCtrl.text,
        meaning: meaningCtrl.text,
      );
      await repo.save(word);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${word.word}" added to vocabulary')),
        );
      }
    }
    wordCtrl.dispose();
    meaningCtrl.dispose();
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class _TappableStoryText extends StatelessWidget {
  final String text;
  final ValueChanged<String> onWordTap;

  const _TappableStoryText({required this.text, required this.onWordTap});

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    final spans = <InlineSpan>[];

    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final clean = word.replaceAll(RegExp("[^\\w']"), '');
      final suffix = word.replaceFirst(clean, '');

      if (clean.isNotEmpty) {
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onLongPress: () => onWordTap(clean.toLowerCase()),
            child: Text(clean, style: const TextStyle()),
          ),
        ));
      }
      if (suffix.isNotEmpty) {
        spans.add(TextSpan(text: suffix));
      }
      if (i < words.length - 1) {
        spans.add(const TextSpan(text: ' '));
      }
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        children: spans,
      ),
    );
  }
}
