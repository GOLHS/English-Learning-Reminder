import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/story_summary_model.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/repositories/story_summary_repository.dart';

final _summaryScreenProvider = FutureProvider.autoDispose.family((ref, String storyUuid) async {
  final repo = ref.read(storyRepositoryProvider);
  final summaryRepo = ref.read(storySummaryRepositoryProvider);
  final story = await repo.getByUuid(storyUuid);
  final today = DateTime.now();
  final existing = await summaryRepo.getByStoryAndDate(storyUuid, today);
  return _SummaryData(story: story, existingSummary: existing);
});

class _SummaryData {
  final dynamic story;
  final dynamic existingSummary;
  const _SummaryData({required this.story, required this.existingSummary});
}

class WriteSummaryScreen extends ConsumerStatefulWidget {
  final String storyId;
  const WriteSummaryScreen({super.key, required this.storyId});

  @override
  ConsumerState<WriteSummaryScreen> createState() => _WriteSummaryScreenState();
}

class _WriteSummaryScreenState extends ConsumerState<WriteSummaryScreen> {
  final _textCtrl = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_textCtrl.text.trim().isEmpty) return;
    setState(() => _isSaving = true);
    final summaryRepo = ref.read(storySummaryRepositoryProvider);
    final today = DateTime.now();

    final summary = StorySummary.create(
      storyUuid: widget.storyId,
      text: _textCtrl.text.trim(),
      summaryDate: today,
    );
    await summaryRepo.save(summary);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Summary saved')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(_summaryScreenProvider(widget.storyId));
    final cs = Theme.of(context).colorScheme;

    return data.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading...'), leading: const BackButton()),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: const Center(child: Text('Could not load story')),
      ),
      data: (d) {
        if (d.story == null) {
          return Scaffold(
            appBar: AppBar(leading: const BackButton()),
            body: const Center(child: Text('Story not found')),
          );
        }
        if (d.existingSummary != null) {
          _textCtrl.text = d.existingSummary.text;
        }

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Write summary'),
            actions: [
              TextButton(onPressed: _isSaving ? null : _save, child: const Text('Save')),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.story.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text(d.story.text, style: TextStyle(color: cs.onSurfaceVariant, height: 1.5, fontSize: 13), maxLines: 8, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Your summary', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _textCtrl,
                decoration: const InputDecoration(
                  hintText: 'Rewrite the story in your own words...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 12,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Text('${_textCtrl.text.length} characters', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _textCtrl.text.trim().isNotEmpty && !_isSaving ? _save : null,
                  child: Text(d.existingSummary != null ? 'Update summary' : 'Save summary'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
