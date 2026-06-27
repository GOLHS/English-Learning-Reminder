import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_preferences.dart';
import '../../data/repositories/preferences_repository.dart';

class LearningSettingsScreen extends ConsumerStatefulWidget {
  const LearningSettingsScreen({super.key});

  @override
  ConsumerState<LearningSettingsScreen> createState() => _LearningSettingsScreenState();
}

class _LearningSettingsScreenState extends ConsumerState<LearningSettingsScreen> {
  late UserPreferences _prefs;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _prefs = await ref.read(preferencesRepositoryProvider).get();
    setState(() => _isLoading = false);
  }

  Future<void> _save() async {
    await ref.read(preferencesRepositoryProvider).save(_prefs);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return Scaffold(appBar: AppBar(title: const Text('Learning preferences')), body: const Center(child: CircularProgressIndicator()));

    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Learning preferences')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Review intensity'),
            subtitle: Text(_prefs.reviewIntensity[0].toUpperCase() + _prefs.reviewIntensity.substring(1)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text('Typing mode during review'),
            subtitle: const Text('Type meanings during recall phase'),
            value: _prefs.typingMode,
            onChanged: (v) => setState(() { _prefs.typingMode = v; _save(); }),
          ),
          SwitchListTile(
            title: const Text('Show examples during recall'),
            value: _prefs.showExamplesDuringRecall,
            onChanged: (v) => setState(() { _prefs.showExamplesDuringRecall = v; _save(); }),
          ),
          ListTile(
            title: const Text('Default verb review mode'),
            subtitle: Text(_prefs.defaultVerbReviewMode[0].toUpperCase() + _prefs.defaultVerbReviewMode.substring(1)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: ['classic', 'missing', 'reverse', 'typing', 'multiple'].map((m) => ListTile(
                  title: Text(m[0].toUpperCase() + m.substring(1)),
                  trailing: _prefs.defaultVerbReviewMode == m ? Icon(Icons.check, color: cs.primary) : null,
                  onTap: () { setState(() => _prefs.defaultVerbReviewMode = m); _save(); Navigator.pop(context); },
                )).toList(),
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Auto-play pronunciation'),
            value: _prefs.autoPlayPronunciation,
            onChanged: (v) => setState(() { _prefs.autoPlayPronunciation = v; _save(); }),
          ),
        ],
      ),
    );
  }
}
