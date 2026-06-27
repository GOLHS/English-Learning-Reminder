import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/error_banner.dart';
import '../../core/widgets/word_tile.dart';
import '../../data/repositories/word_repository.dart';

final _archivedProvider = FutureProvider.autoDispose((ref) {
  return ref.read(wordRepositoryProvider).getArchived();
});

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_archivedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Archive')),
      body: data.when(
        loading: () => const LoadingShimmer(),
        error: (e, _) => ErrorBanner(message: 'Could not load archive', onRetry: () => ref.invalidate(_archivedProvider)),
        data: (words) {
          if (words.isEmpty) {
            return const EmptyState(
              icon: Icons.archive_outlined,
              title: 'No archived words yet',
              body: 'Archived words will appear here',
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${words.length} archived ${words.length == 1 ? 'word' : 'words'}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: words.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                  itemBuilder: (_, i) {
                    final word = words[i];
                    return WordTile(
                      word: word,
                      onTap: null,
                      onArchive: () async {
                        word.isArchived = false;
                        await ref.read(wordRepositoryProvider).save(word);
                        ref.invalidate(_archivedProvider);
                      },
                      onDelete: () async {
                        final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                          title: const Text('Delete permanently?'),
                          content: Text("Delete '${word.word}'? This cannot be undone."),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                          ],
                        ));
                        if (confirmed == true) {
                          await ref.read(wordRepositoryProvider).delete(word);
                          ref.invalidate(_archivedProvider);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
