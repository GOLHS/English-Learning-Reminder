import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/form_section.dart';
import '../../data/repositories/preferences_repository.dart';

const _providerModels = <String, List<String>>{
  'openai': ['gpt-4o-mini', 'gpt-4o', 'gpt-3.5-turbo'],
  'gemini': ['gemini-2.0-flash', 'gemini-2.0-flash-lite', 'gemini-1.5-pro'],
  'claude': ['claude-sonnet-4-20250514', 'claude-3-5-haiku-20241022', 'claude-3-opus-20240229'],
};

const _providerLabels = <String, String>{
  'openai': 'OpenAI',
  'gemini': 'Google Gemini',
  'claude': 'Anthropic Claude',
};

const _providerHints = <String, String>{
  'openai': 'sk-...',
  'gemini': 'AIza...',
  'claude': 'sk-ant-...',
};

const _providerDescriptions = <String, String>{
  'openai': 'Enter your OpenAI API key. Create one at platform.openai.com/api-keys.',
  'gemini': 'Enter your Google AI API key. Get one at ai.google.dev.',
  'claude': 'Enter your Anthropic API key. Get one at console.anthropic.com.',
};

class AiSettingsScreen extends ConsumerStatefulWidget {
  const AiSettingsScreen({super.key});

  @override
  ConsumerState<AiSettingsScreen> createState() => _AiSettingsScreenState();
}

class _AiSettingsScreenState extends ConsumerState<AiSettingsScreen> {
  final _keyCtrl = TextEditingController();
  String _provider = 'openai';
  String _model = 'gpt-4o-mini';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await ref.read(preferencesRepositoryProvider).get();
    _keyCtrl.text = prefs.aiApiKey;
    _provider = prefs.aiProvider.isNotEmpty ? prefs.aiProvider : 'openai';
    final models = _providerModels[_provider]!;
    _model = models.contains(prefs.aiModel) ? prefs.aiModel : models.first;
    setState(() {});
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    final repo = ref.read(preferencesRepositoryProvider);
    final prefs = await repo.get();
    prefs.aiApiKey = _keyCtrl.text.trim();
    prefs.aiProvider = _provider;
    prefs.aiModel = _model;
    await repo.save(prefs);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI settings saved')));
    }
    setState(() => _isSaving = false);
  }

  @override
  void dispose() {
    _keyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final models = _providerModels[_provider]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI settings'),
        actions: [
          TextButton(onPressed: _isSaving ? null : _save, child: const Text('Save')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(child: Text(
                    'Your API key is stored locally on your device.',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FormSection(title: 'CONFIGURATION', child: Column(
            children: [
              TextField(
                controller: _keyCtrl,
                decoration: InputDecoration(
                  labelText: 'API key',
                  hintText: _providerHints[_provider],
                ),
                obscureText: true,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _provider,
                decoration: const InputDecoration(labelText: 'Provider'),
                items: _providerLabels.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
                onChanged: (v) {
                  if (v != null) {
                    final newModels = _providerModels[v]!;
                    setState(() {
                      _provider = v;
                      if (!newModels.contains(_model)) _model = newModels.first;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _model,
                decoration: const InputDecoration(labelText: 'Model'),
                items: models.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _model = v);
                },
              ),
            ],
          )),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(_providerDescriptions[_provider]!, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
