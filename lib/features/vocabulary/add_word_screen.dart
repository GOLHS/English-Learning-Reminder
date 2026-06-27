import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/form_section.dart';
import '../../data/models/word_model.dart';
import '../../data/repositories/word_repository.dart';
import '../../services/ai_service.dart';

class AddWordScreen extends ConsumerStatefulWidget {
  final String? wordId;
  const AddWordScreen({super.key, this.wordId});

  @override
  ConsumerState<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends ConsumerState<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _wordCtrl = TextEditingController();
  final _meaningCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _pronunciationCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _synonymCtrl = TextEditingController();
  final _antonymCtrl = TextEditingController();

  List<String> _examples = [];
  List<String> _synonyms = [];
  List<String> _antonyms = [];
  bool _isLoading = false;
  bool _isEdit = false;
  bool _isAiLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.wordId != null) _loadWord();
  }

  Future<void> _loadWord() async {
    setState(() => _isLoading = true);
    final repo = ref.read(wordRepositoryProvider);
    final word = await repo.getByUuid(widget.wordId!);
    if (word != null && mounted) {
      _wordCtrl.text = word.word;
      _meaningCtrl.text = word.meaning;
      _notesCtrl.text = word.notes ?? '';
      _pronunciationCtrl.text = word.pronunciation ?? '';
      _categoryCtrl.text = word.category ?? '';
      _examples = List.from(word.examples);
      _synonyms = List.from(word.synonyms);
      _antonyms = List.from(word.antonyms);
      _isEdit = true;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _aiFill() async {
    final word = _wordCtrl.text.trim();
    if (word.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a word first')));
      return;
    }
    setState(() => _isAiLoading = true);
    try {
      final ai = ref.read(aiServiceProvider);
      final meaningResult = await ai.suggestMeaning(word);
      final examplesResult = await ai.generateExamples(word);

      final meaningMatch = RegExp(r'Meaning:\s*(.+?)(?:\n|$)').firstMatch(meaningResult);
      final pronunciationMatch = RegExp(r'Pronunciation:\s*(.+?)(?:\n|$)').firstMatch(meaningResult);

      if (meaningMatch != null) {
        _meaningCtrl.text = meaningMatch.group(1)!.trim();
      } else {
        _meaningCtrl.text = meaningResult.trim();
      }

      if (pronunciationMatch != null) {
        _pronunciationCtrl.text = pronunciationMatch.group(1)!.trim();
      }

      _examples = examplesResult
          .split('\n')
          .map((l) => l.replaceAll(RegExp(r'^[-*\s]+'), '').trim())
          .where((l) => l.isNotEmpty)
          .take(3)
          .toList();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('AI error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isAiLoading = false);
    }
  }

  @override
  void dispose() {
    _wordCtrl.dispose();
    _meaningCtrl.dispose();
    _notesCtrl.dispose();
    _pronunciationCtrl.dispose();
    _categoryCtrl.dispose();
    _synonymCtrl.dispose();
    _antonymCtrl.dispose();
    super.dispose();
  }

  bool get _isValid => _wordCtrl.text.trim().isNotEmpty && _meaningCtrl.text.trim().isNotEmpty;

  Future<void> _save() async {
    if (!_isValid) return;
    setState(() => _isLoading = true);
    final repo = ref.read(wordRepositoryProvider);

    if (_isEdit) {
      final word = await repo.getByUuid(widget.wordId!);
      if (word != null) {
        word.updateFrom(
          word: _wordCtrl.text,
          meaning: _meaningCtrl.text,
          examples: _examples,
          notes: _notesCtrl.text,
          category: _categoryCtrl.text.isNotEmpty ? _categoryCtrl.text : null,
          synonyms: _synonyms,
          antonyms: _antonyms,
          pronunciation: _pronunciationCtrl.text.isNotEmpty ? _pronunciationCtrl.text : null,
        );
        await repo.save(word);
      }
    } else {
      final word = Word.create(
        word: _wordCtrl.text,
        meaning: _meaningCtrl.text,
        examples: _examples,
        notes: _notesCtrl.text.isNotEmpty ? _notesCtrl.text : null,
        category: _categoryCtrl.text.isNotEmpty ? _categoryCtrl.text : null,
        synonyms: _synonyms,
        antonyms: _antonyms,
        pronunciation: _pronunciationCtrl.text.isNotEmpty ? _pronunciationCtrl.text : null,
      );
      await repo.save(word);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isEdit ? 'Word updated' : 'Word saved')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _isEdit) {
      return Scaffold(appBar: AppBar(title: const Text('Edit word'), leading: const BackButton()), body: const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(_isEdit ? 'Edit word' : 'Add word'),
        actions: [
          TextButton(onPressed: _isValid && !_isLoading ? _save : null, child: const Text('Save')),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (!_isEdit) ...[
              _isAiLoading
                ? const Center(child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ))
                : OutlinedButton.icon(
                    onPressed: _aiFill,
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('AI Fill'),
                  ),
              const SizedBox(height: 16),
            ],
            FormSection(title: 'WORD DETAILS', child: Column(
              children: [
                TextFormField(
                  controller: _wordCtrl,
                  decoration: InputDecoration(labelText: 'Word *', hintText: 'Enter the word', suffixText: '${_wordCtrl.text.length}/${AppConstants.maxWordLength}'),
                  maxLength: AppConstants.maxWordLength,
                  validator: Validators.word,
                  onChanged: (_) => setState(() {}),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _meaningCtrl,
                  decoration: const InputDecoration(labelText: 'Meaning *', hintText: 'Enter the meaning'),
                  maxLines: 3,
                  validator: Validators.meaning,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pronunciationCtrl,
                  decoration: InputDecoration(labelText: 'Pronunciation (IPA)', hintText: '/r\u026a\u02c8z\u026alj\u0259nt/'),
                ),
              ],
            )),
            const SizedBox(height: 20),
            FormSection(title: 'EXAMPLES (${_examples.length}/10)', child: Column(
              children: [
                ...List.generate(_examples.length, (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(child: TextFormField(
                        initialValue: _examples[i],
                        decoration: const InputDecoration(hintText: 'Example sentence', isDense: true),
                        onChanged: (v) => _examples[i] = v,
                      )),
                      const SizedBox(width: 4),
                      IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => setState(() => _examples.removeAt(i))),
                    ],
                  ),
                )),
                if (_examples.length < AppConstants.maxExamples)
                  Align(alignment: Alignment.centerLeft, child: TextButton.icon(
                    onPressed: () => setState(() => _examples.add('')),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add example'),
                  )),
              ],
            )),
            const SizedBox(height: 20),
            FormSection(title: 'CATEGORY', child: Autocomplete<String>(
              optionsBuilder: (text) => AppConstants.categories.where((c) => c.toLowerCase().contains(text.text.toLowerCase())),
              fieldViewBuilder: (ctx, ctrl, focus, onSubmit) => TextFormField(
                controller: ctrl..text = _categoryCtrl.text,
                decoration: const InputDecoration(hintText: 'Category'),
                focusNode: focus,
                onFieldSubmitted: (_) => onSubmit(),
                onChanged: (v) => _categoryCtrl.text = v,
              ),
              onSelected: (v) => _categoryCtrl.text = v,
            )),
            const SizedBox(height: 20),
            FormSection(title: 'RELATED WORDS', child: Column(
              children: [
                _ChipsInput(
                  label: 'Synonyms',
                  chips: _synonyms,
                  controller: _synonymCtrl,
                  onAdd: () {
                    if (_synonymCtrl.text.trim().isNotEmpty) {
                      setState(() => _synonyms.add(_synonymCtrl.text.trim()));
                      _synonymCtrl.clear();
                    }
                  },
                  onRemove: (i) => setState(() => _synonyms.removeAt(i)),
                ),
                const Divider(height: 24),
                _ChipsInput(
                  label: 'Antonyms',
                  chips: _antonyms,
                  controller: _antonymCtrl,
                  onAdd: () {
                    if (_antonymCtrl.text.trim().isNotEmpty) {
                      setState(() => _antonyms.add(_antonymCtrl.text.trim()));
                      _antonymCtrl.clear();
                    }
                  },
                  onRemove: (i) => setState(() => _antonyms.removeAt(i)),
                ),
              ],
            )),
            const SizedBox(height: 20),
            FormSection(title: 'NOTES', child: TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(hintText: 'Additional notes'),
              maxLines: 4,
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
      ),
    );
  }
}

class _ChipsInput extends StatefulWidget {
  final String label;
  final List<String> chips;
  final TextEditingController controller;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  const _ChipsInput({required this.label, required this.chips, required this.controller, required this.onAdd, required this.onRemove});

  @override
  State<_ChipsInput> createState() => _ChipsInputState();
}

class _ChipsInputState extends State<_ChipsInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(hintText: 'Type and press add', isDense: true),
              onSubmitted: (_) => widget.onAdd(),
            )),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.add_circle), onPressed: widget.onAdd),
          ],
        ),
        if (widget.chips.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: List.generate(widget.chips.length, (i) => Chip(
              label: Text(widget.chips[i]),
              onDeleted: () => widget.onRemove(i),
              visualDensity: VisualDensity.compact,
            )),
          ),
        ],
      ],
    );
  }
}
