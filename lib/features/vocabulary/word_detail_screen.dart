import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../data/repositories/word_repository.dart';

final _wordDetailProvider = FutureProvider.autoDispose.family((ref, String id) {
  return ref.read(wordRepositoryProvider).getByUuid(id);
});

class WordDetailScreen extends ConsumerWidget {
  final String id;
  const WordDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordAsync = ref.watch(_wordDetailProvider(id));
    final cs = Theme.of(context).colorScheme;

    return wordAsync.when(
      loading: () => Scaffold(appBar: AppBar(title: const Text('Loading...'), leading: const BackButton()), body: const Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(appBar: AppBar(title: const Text('Error'), leading: const BackButton()), body: Center(child: Text('Could not load word'))),
      data: (word) {
        if (word == null) {
          return Scaffold(appBar: AppBar(leading: const BackButton()), body: const Center(child: Text('Word not found')));
        }

        Color diffColor;
        switch (word.difficulty) {
          case 'Easy': diffColor = Colors.teal;
          case 'Hard': diffColor = Colors.amber;
          default: diffColor = Colors.indigo;
        }

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(word.word),
            actions: [
              IconButton(icon: const Icon(Icons.edit), onPressed: () => context.go('/vocabulary/${word.uuid}/edit')),
              PopupMenuButton<String>(
                onSelected: (v) async {
                  if (v == 'archive') {
                    word.isArchived = true;
                    await ref.read(wordRepositoryProvider).save(word);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word archived')));
                      context.pop();
                    }
                  } else if (v == 'delete') {
                    final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                      title: Text("Delete '${word.word}'?"),
                      content: const Text('This cannot be undone.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                      ],
                    ));
                    if (confirmed == true) {
                      await ref.read(wordRepositoryProvider).delete(word);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word deleted')));
                        context.pop();
                      }
                    }
                  }
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'archive', child: Text('Archive')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(word.word, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (word.pronunciation != null) ...[
                        Row(
                          children: [
                            Text(word.pronunciation!, style: TextStyle(color: cs.onSurfaceVariant)),
                            const SizedBox(width: 8),
                            Icon(Icons.volume_up, size: 20, color: cs.primary),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      Wrap(
                        spacing: 8,
                        children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: diffColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)), child: Text(word.difficulty, style: TextStyle(color: diffColor, fontSize: 12))),
                          if (word.category != null) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(12)), child: Text(word.category!, style: TextStyle(color: cs.onPrimaryContainer, fontSize: 12))),
                          if (word.isMastered) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)), child: const Text('Mastered', style: TextStyle(color: Colors.teal, fontSize: 12))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Meaning', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(word.meaning, style: Theme.of(context).textTheme.bodyLarge),
              if (word.examples.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text('Examples (${word.examples.length})', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ...word.examples.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('  \u2022  '),
                    Expanded(child: Text(e, style: TextStyle(color: cs.onSurfaceVariant, fontStyle: FontStyle.italic))),
                  ]),
                )),
              ],
              if (word.synonyms.isNotEmpty || word.antonyms.isNotEmpty) ...[
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Synonyms', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          word.synonyms.isNotEmpty
                              ? Wrap(spacing: 8, runSpacing: 4, children: word.synonyms.map((s) => Chip(label: Text(s), visualDensity: VisualDensity.compact)).toList())
                              : Text('\u2014', style: TextStyle(color: cs.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Antonyms', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          word.antonyms.isNotEmpty
                              ? Wrap(spacing: 8, runSpacing: 4, children: word.antonyms.map((a) => Chip(label: Text(a), visualDensity: VisualDensity.compact)).toList())
                              : Text('\u2014', style: TextStyle(color: cs.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              if (word.notes != null && word.notes!.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text('Notes', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(word.notes!, style: TextStyle(color: cs.onSurfaceVariant)),
              ],
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MiniStat(label: 'Success', value: '${(word.successRate * 100).round()}%'),
                      _MiniStat(label: 'Reviews', value: '${word.reviewCount}'),
                      _MiniStat(label: 'Next', value: word.nextReviewAt != null ? AppDateUtils.daysUntil(word.nextReviewAt!) : 'Now'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Review now'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(onPressed: () => context.go('/vocabulary/${word.uuid}/edit'), icon: const Icon(Icons.edit)),
                  IconButton(
                    onPressed: () async {
                      word.isArchived = true;
                      await ref.read(wordRepositoryProvider).save(word);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word archived')));
                        context.pop();
                      }
                    },
                    icon: const Icon(Icons.archive),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
      ],
    );
  }
}
