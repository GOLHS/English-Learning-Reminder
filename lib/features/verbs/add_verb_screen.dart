import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/form_section.dart';
import '../../data/models/verb_model.dart';
import '../../data/repositories/verb_repository.dart';

class AddVerbScreen extends ConsumerStatefulWidget {
  final String? verbId;
  const AddVerbScreen({super.key, this.verbId});

  @override
  ConsumerState<AddVerbScreen> createState() => _AddVerbScreenState();
}

class _AddVerbScreenState extends ConsumerState<AddVerbScreen> {
  final _formKey = GlobalKey<FormState>();
  final _baseCtrl = TextEditingController();
  final _pastCtrl = TextEditingController();
  final _participleCtrl = TextEditingController();
  final _meaningCtrl = TextEditingController();
  String _difficulty = 'Medium';
  String? _patternGroup;
  List<String> _examples = [];
  bool _isLoading = false;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.verbId != null) _loadVerb();
  }

  Future<void> _loadVerb() async {
    setState(() => _isLoading = true);
    final repo = ref.read(verbRepositoryProvider);
    final verb = await repo.getByUuid(widget.verbId!);
    if (verb != null && mounted) {
      _baseCtrl.text = verb.baseForm;
      _pastCtrl.text = verb.pastSimple;
      _participleCtrl.text = verb.pastParticiple;
      _meaningCtrl.text = verb.meaning ?? '';
      _difficulty = verb.difficulty;
      _patternGroup = verb.patternGroup;
      _examples = List.from(verb.examples);
      _isEdit = true;
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _baseCtrl.dispose();
    _pastCtrl.dispose();
    _participleCtrl.dispose();
    _meaningCtrl.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _baseCtrl.text.trim().isNotEmpty &&
      _pastCtrl.text.trim().isNotEmpty &&
      _participleCtrl.text.trim().isNotEmpty;

  Future<void> _save() async {
    if (!_isValid) return;
    setState(() => _isLoading = true);
    final repo = ref.read(verbRepositoryProvider);

    if (_isEdit) {
      final verb = await repo.getByUuid(widget.verbId!);
      if (verb != null) {
        verb.baseForm = _baseCtrl.text.trim();
        verb.pastSimple = _pastCtrl.text.trim();
        verb.pastParticiple = _participleCtrl.text.trim();
        verb.meaning = _meaningCtrl.text.trim().isEmpty ? null : _meaningCtrl.text.trim();
        verb.difficulty = _difficulty;
        verb.patternGroup = _patternGroup;
        verb.examples = _examples;
        await repo.save(verb);
      }
    } else {
      final verb = Verb.create(
        baseForm: _baseCtrl.text.trim(),
        pastSimple: _pastCtrl.text.trim(),
        pastParticiple: _participleCtrl.text.trim(),
        meaning: _meaningCtrl.text.trim().isEmpty ? null : _meaningCtrl.text.trim(),
        difficulty: _difficulty,
        patternGroup: _patternGroup,
        examples: _examples,
      );
      await repo.save(verb);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isEdit ? 'Verb updated' : 'Verb saved')));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _isEdit) {
      return Scaffold(appBar: AppBar(title: const Text('Edit verb')), body: const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(_isEdit ? 'Edit verb' : 'Add verb'),
        actions: [TextButton(onPressed: _isValid ? _save : null, child: const Text('Save'))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FormSection(title: 'VERB FORMS', child: Column(
              children: [
                TextFormField(controller: _baseCtrl, decoration: const InputDecoration(labelText: 'Base form *', hintText: 'go'), validator: (v) => Validators.verbForm(v, 'Base form'), onChanged: (_) => setState(() {})),
                const SizedBox(height: 16),
                TextFormField(controller: _pastCtrl, decoration: const InputDecoration(labelText: 'Past simple *', hintText: 'went'), validator: (v) => Validators.verbForm(v, 'Past simple'), onChanged: (_) => setState(() {})),
                const SizedBox(height: 16),
                TextFormField(controller: _participleCtrl, decoration: const InputDecoration(labelText: 'Past participle *', hintText: 'gone'), validator: (v) => Validators.verbForm(v, 'Past participle'), onChanged: (_) => setState(() {})),
                const SizedBox(height: 16),
                TextFormField(controller: _meaningCtrl, decoration: const InputDecoration(labelText: 'Meaning', hintText: 'Optional')),
              ],
            )),
            const SizedBox(height: 20),
            FormSection(title: 'DIFFICULTY', child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Easy', label: Text('Easy')),
                ButtonSegment(value: 'Medium', label: Text('Medium')),
                ButtonSegment(value: 'Hard', label: Text('Hard')),
              ],
              selected: {_difficulty},
              onSelectionChanged: (v) => setState(() => _difficulty = v.first),
            )),
            const SizedBox(height: 20),
            FormSection(title: 'PATTERN GROUP', child: Autocomplete<String>(
              optionsBuilder: (text) => AppConstants.verbPatternGroups.where((g) => g.toLowerCase().contains(text.text.toLowerCase())),
              initialValue: _patternGroup != null ? TextEditingValue(text: _patternGroup!) : null,
              onSelected: (v) => _patternGroup = v,
              fieldViewBuilder: (ctx, ctrl, focus, onSubmit) => TextFormField(
                controller: ctrl,
                decoration: const InputDecoration(hintText: 'Pattern group'),
                focusNode: focus,
                onFieldSubmitted: (_) => onSubmit(),
              ),
            )),
            const SizedBox(height: 20),
            FormSection(title: 'EXAMPLES (${_examples.length}/5)', child: Column(
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
                if (_examples.length < AppConstants.maxVerbExamples)
                  Align(alignment: Alignment.centerLeft, child: TextButton.icon(
                    onPressed: () => setState(() => _examples.add('')),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add example'),
                  )),
              ],
            )),
            const SizedBox(height: 32),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: _isValid ? _save : null, child: Text(_isEdit ? 'Update' : 'Save'))),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
