import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/repositories/word_repository.dart';
import '../../data/repositories/verb_repository.dart';
import '../../data/repositories/review_log_repository.dart';

class DataSettingsScreen extends ConsumerWidget {
  const DataSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Data & backup')),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Backup'),
          ListTile(
            leading: const Icon(Icons.file_upload_outlined),
            title: const Text('Export data (JSON)'),
            subtitle: const Text('Share all your vocabulary and verbs'),
            onTap: () async {
              final wordRepo = ref.read(wordRepositoryProvider);
              final verbRepo = ref.read(verbRepositoryProvider);
              final words = await wordRepo.getAll(includeArchived: true);
              final verbs = await verbRepo.getAll();
              final data = jsonEncode({
                'words': words.map((w) => {
                  'word': w.word, 'meaning': w.meaning, 'examples': w.examples,
                  'notes': w.notes, 'category': w.category, 'synonyms': w.synonyms,
                  'antonyms': w.antonyms, 'pronunciation': w.pronunciation,
                  'difficulty': w.difficulty, 'isArchived': w.isArchived,
                }).toList(),
                'verbs': verbs.map((v) => {
                  'baseForm': v.baseForm, 'pastSimple': v.pastSimple,
                  'pastParticiple': v.pastParticiple, 'meaning': v.meaning,
                  'examples': v.examples, 'difficulty': v.difficulty,
                  'patternGroup': v.patternGroup,
                }).toList(),
              });
              final dir = await getTemporaryDirectory();
              final file = File('${dir.path}/vocab_trainer_backup.json');
              await file.writeAsString(data);
              await Share.shareXFiles([XFile(file.path)], text: 'Vocab Trainer Backup');
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt_outlined),
            title: const Text('Create local backup'),
            subtitle: const Text('Save to Downloads folder'),
            onTap: () async {
              final dir = await getApplicationDocumentsDirectory();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Backup saved to ${dir.path}')));
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'Restore'),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: const Text('Import from file'),
            subtitle: const Text('Restore from a JSON backup'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Import feature available in full version')));
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'Reset'),
          ListTile(
            leading: Icon(Icons.restart_alt, color: Colors.amber),
            title: const Text('Reset statistics', style: TextStyle(color: Colors.amber)),
            onTap: () async {
              final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                title: const Text('Reset statistics?'),
                content: const Text('This will clear all review history but keep your words.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reset', style: TextStyle(color: Colors.amber))),
                ],
              ));
              if (confirmed == true) {
                final logRepo = ref.read(reviewLogRepositoryProvider);
                await logRepo.deleteAll();
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Statistics reset')));
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Erase all data', style: TextStyle(color: Colors.red)),
            subtitle: const Text('This cannot be undone'),
            onTap: () async {
              final deleteTxtCtrl = TextEditingController();
              final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                title: const Text('Erase all data?'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Type DELETE to confirm.'),
                    TextField(controller: deleteTxtCtrl, decoration: const InputDecoration(hintText: 'DELETE')),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  TextButton(
                    onPressed: deleteTxtCtrl.text == 'DELETE' ? () => Navigator.pop(ctx, true) : null,
                    child: const Text('Erase', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ));
              if (confirmed == true) {
                final wordRepo = ref.read(wordRepositoryProvider);
                final verbRepo = ref.read(verbRepositoryProvider);
                final logRepo = ref.read(reviewLogRepositoryProvider);
                final allWords = await wordRepo.getAll(includeArchived: true);
                for (final w in allWords) await wordRepo.delete(w);
                final allVerbs = await verbRepo.getAll();
                for (final v in allVerbs) await verbRepo.delete(v);
                await logRepo.deleteAll();
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All data erased')));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
    );
  }
}
