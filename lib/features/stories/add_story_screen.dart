import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/form_section.dart';
import '../../data/models/story_model.dart';
import '../../data/repositories/story_repository.dart';
import '../../services/ai_service.dart';

class AddStoryScreen extends ConsumerStatefulWidget {
  final String? storyId;
  const AddStoryScreen({super.key, this.storyId});

  @override
  ConsumerState<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends ConsumerState<AddStoryScreen> {
  final _titleCtrl = TextEditingController();
  final _textCtrl = TextEditingController();
  final _topicCtrl = TextEditingController();
  bool _isLoading = false;
  bool _isEdit = false;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    if (widget.storyId != null) _loadStory();
  }

  Future<void> _loadStory() async {
    setState(() => _isLoading = true);
    final repo = ref.read(storyRepositoryProvider);
    final story = await repo.getByUuid(widget.storyId!);
    if (story != null && mounted) {
      _titleCtrl.text = story.title;
      _textCtrl.text = story.text;
      _isEdit = true;
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _generateWithAI() async {
    final topic = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Generate story with AI'),
        content: TextField(
          controller: _topicCtrl,
          decoration: const InputDecoration(
            hintText: 'e.g., a rabbit who learns to be brave',
            labelText: 'Topic',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(onPressed: () {
            if (_topicCtrl.text.trim().isNotEmpty) Navigator.pop(ctx, _topicCtrl.text.trim());
          }, child: const Text('Generate')),
        ],
      ),
    );
    if (topic == null) return;

    setState(() => _isGenerating = true);
    try {
      final ai = ref.read(aiServiceProvider);
      final story = await ai.generateStory(topic);
      _titleCtrl.text = topic;
      _textCtrl.text = story.trim();
    } catch (e) {
      debugPrint('AI story generation error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$e', maxLines: 3, overflow: TextOverflow.ellipsis),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(label: 'Settings', onPressed: () => context.go('/settings/ai')),
        ));
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
      _topicCtrl.clear();
    }
  }

  bool get _isValid => _titleCtrl.text.trim().isNotEmpty && _textCtrl.text.trim().isNotEmpty;

  Future<void> _save() async {
    if (!_isValid) return;
    setState(() => _isLoading = true);
    final repo = ref.read(storyRepositoryProvider);

    if (_isEdit) {
      final story = await repo.getByUuid(widget.storyId!);
      if (story != null) {
        story.title = _titleCtrl.text.trim();
        story.text = _textCtrl.text.trim();
        story.updatedAt = DateTime.now();
        await repo.save(story);
      }
    } else {
      final story = Story.create(
        title: _titleCtrl.text,
        text: _textCtrl.text,
      );
      await repo.save(story);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isEdit ? 'Story updated' : 'Story saved')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _isEdit) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit story'), leading: const BackButton()),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(_isEdit ? 'Edit story' : 'Add story'),
        actions: [
          TextButton(onPressed: _isValid && !_isLoading ? _save : null, child: const Text('Save')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!_isEdit) ...[
            _isGenerating
              ? const Center(child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ))
              : OutlinedButton.icon(
                  onPressed: _generateWithAI,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Generate with AI'),
                ),
            const SizedBox(height: 16),
          ],
          FormSection(title: 'STORY', child: Column(
            children: [
              TextField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title', hintText: 'Story title'),
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textCtrl,
                decoration: const InputDecoration(
                  labelText: 'Story text',
                  hintText: 'Write or paste your story here...',
                  alignLabelWithHint: true,
                ),
                maxLines: 15,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
              ),
            ],
          )),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isValid ? _save : null,
              child: Text(_isEdit ? 'Update' : 'Save'),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
