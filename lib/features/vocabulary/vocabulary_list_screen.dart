import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/error_banner.dart';
import '../../core/widgets/word_tile.dart';
import '../../data/models/word_model.dart';
import '../../data/repositories/word_repository.dart';
import 'widgets/filter_sheet.dart';

final _vocabListProvider = FutureProvider.autoDispose<List<Word>>((ref) async {
  final repo = ref.read(wordRepositoryProvider);
  return repo.getAll();
});

class VocabularyListScreen extends ConsumerStatefulWidget {
  const VocabularyListScreen({super.key});

  @override
  ConsumerState<VocabularyListScreen> createState() => _VocabularyListScreenState();
}

class _VocabularyListScreenState extends ConsumerState<VocabularyListScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _categoryFilter = 'All';
  String _difficultyFilter = 'All';
  String _sortBy = 'newest';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Word> _applyFilters(List<Word> items) {
    var result = items.toList();

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result.where((w) => w.word.toLowerCase().contains(q) || w.meaning.toLowerCase().contains(q)).toList();
    }

    if (_categoryFilter != 'All') {
      result = result.where((w) => w.category == _categoryFilter).toList();
    }

    if (_difficultyFilter != 'All') {
      result = result.where((w) => w.difficulty == _difficultyFilter).toList();
    }

    switch (_sortBy) {
      case 'oldest': result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case 'alphabetical': result.sort((a, b) => a.word.compareTo(b.word));
      case 'difficult': result.sort((a, b) => b.difficulty.compareTo(a.difficulty));
      default: result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  Future<void> _deleteWord(String uuid) async {
    final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Delete word'),
      content: Text('This cannot be undone.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
      ],
    ));
    if (confirmed == true) {
      await ref.read(wordRepositoryProvider).deleteByUuid(uuid);
      ref.invalidate(_vocabListProvider);
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word deleted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(_vocabListProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _isSearching
          ? AppBar(
              leading: const BackButton(),
              title: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Search words...', border: InputBorder.none),
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.close), onPressed: () {
                  setState(() { _isSearching = false; _searchQuery = ''; _searchController.clear(); });
                }),
              ],
            )
          : AppBar(
              title: const Text('Vocabulary'),
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () => setState(() => _isSearching = true)),
                IconButton(
                  icon: Badge(isLabelVisible: _categoryFilter != 'All' || _difficultyFilter != 'All' || _sortBy != 'newest',
                    child: const Icon(Icons.filter_list)),
                  onPressed: () async {
                    final result = await showModalBottomSheet<Map<String, String>>(
                      context: context,
                      builder: (_) => FilterSheet(currentCategory: _categoryFilter, currentDifficulty: _difficultyFilter, currentSort: _sortBy),
                    );
                    if (result != null) {
                      setState(() {
                        _categoryFilter = result['category'] ?? 'All';
                        _difficultyFilter = result['difficulty'] ?? 'All';
                        _sortBy = result['sort'] ?? 'newest';
                      });
                    }
                  },
                ),
              ],
            ),
      body: Column(
        children: [
          data.when(
            data: (items) {
              final filtered = _applyFilters(items);
              return Expanded(
                child: filtered.isEmpty
                    ? EmptyState(
                        icon: Icons.menu_book,
                        title: items.isEmpty ? 'No words yet' : 'No results found',
                        body: items.isEmpty ? 'Add your first word to get started' : 'Try different filters',
                        buttonLabel: items.isEmpty ? 'Add your first word' : null,
                        onButtonPressed: items.isEmpty ? () => context.go('/vocabulary/add') : null,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                        itemBuilder: (_, i) {
                          final w = filtered[i];
                          return WordTile(
                            word: w,
                            onTap: () => context.go('/vocabulary/${w.uuid}'),
                            onEdit: () => context.go('/vocabulary/${w.uuid}/edit'),
                            onDelete: () => _deleteWord(w.uuid),
                            onMarkDifficult: () async {
                              final repo = ref.read(wordRepositoryProvider);
                              final wordObj = await repo.getByUuid(w.uuid);
                              if (wordObj != null) {
                                wordObj.difficulty = 'Hard';
                                await repo.save(wordObj);
                                ref.invalidate(_vocabListProvider);
                              }
                            },
                            onReviewNow: () => context.go('/review'),
                            onArchive: () async {
                              final repo = ref.read(wordRepositoryProvider);
                              final wordObj = await repo.getByUuid(w.uuid);
                              if (wordObj != null) {
                                wordObj.isArchived = true;
                                await repo.save(wordObj);
                                ref.invalidate(_vocabListProvider);
                                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word archived')));
                              }
                            },
                          );
                        },
                      ),
              );
            },
            loading: () => const Expanded(child: LoadingShimmer()),
            error: (e, _) => Expanded(child: ErrorBanner(message: 'Could not load vocabulary', onRetry: () => ref.invalidate(_vocabListProvider))),
          ),
          if (_categoryFilter != 'All' || _difficultyFilter != 'All' || _sortBy != 'newest')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: cs.surfaceContainerLow,
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, size: 16),
                  const SizedBox(width: 8),
                  if (_categoryFilter != 'All') Chip(label: Text(_categoryFilter), onDeleted: () => setState(() => _categoryFilter = 'All'), visualDensity: VisualDensity.compact),
                  if (_difficultyFilter != 'All') Chip(label: Text(_difficultyFilter), onDeleted: () => setState(() => _difficultyFilter = 'All'), visualDensity: VisualDensity.compact),
                  if (_sortBy != 'newest') Chip(label: Text('Sort: $_sortBy'), onDeleted: () => setState(() => _sortBy = 'newest'), visualDensity: VisualDensity.compact),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: data.hasValue
          ? FloatingActionButton.extended(
              onPressed: () => context.go('/vocabulary/add'),
              icon: const Icon(Icons.add),
              label: const Text('Add word'),
            )
          : null,
    );
  }
}
