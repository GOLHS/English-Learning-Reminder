import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../data/repositories/verb_repository.dart';

final _verbDetailProvider = FutureProvider.autoDispose.family((ref, String id) {
  return ref.read(verbRepositoryProvider).getByUuid(id);
});

class VerbDetailScreen extends ConsumerWidget {
  final String id;
  const VerbDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verbAsync = ref.watch(_verbDetailProvider(id));
    final cs = Theme.of(context).colorScheme;

    return verbAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Scaffold(body: Center(child: Text('Error loading verb'))),
      data: (verb) {
        if (verb == null) {
          return const Scaffold(body: Center(child: Text('Verb not found')));
        }

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(verb.baseForm),
            actions: [
              IconButton(icon: const Icon(Icons.edit), onPressed: () => context.go('/verbs/${verb.uuid}/edit')),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                    title: Text("Delete '${verb.baseForm}'?"),
                    content: const Text('This cannot be undone.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                    ],
                  ));
                  if (confirmed == true) {
                    await ref.read(verbRepositoryProvider).delete(verb);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verb deleted')));
                      context.pop();
                    }
                  }
                },
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
                    children: [
                      Text(verb.baseForm, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _FormColumn(label: 'Past', value: verb.pastSimple),
                          Container(height: 40, width: 1, color: cs.outlineVariant),
                          _FormColumn(label: 'Participle', value: verb.pastParticiple),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (verb.meaning != null) ...[
                const SizedBox(height: 16),
                Text('Meaning', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(verb.meaning!, style: Theme.of(context).textTheme.bodyLarge),
              ],
              if (verb.examples.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text('Examples', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ...verb.examples.map((e) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('\u2022  $e', style: TextStyle(color: cs.onSurfaceVariant, fontStyle: FontStyle.italic)))),
              ],
              if (verb.patternGroup != null) ...[
                const SizedBox(height: 24),
                Chip(label: Text(verb.patternGroup!)),
              ],
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MiniStat(label: 'Success', value: '${(verb.successRate * 100).round()}%'),
                      _MiniStat(label: 'Reviews', value: '${verb.reviewCount}'),
                      _MiniStat(label: 'Next', value: verb.nextReviewAt != null ? AppDateUtils.daysUntil(verb.nextReviewAt!) : 'Now'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, height: 52, child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text('Review now'),
              )),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

class _FormColumn extends StatelessWidget {
  final String label;
  final String value;
  const _FormColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo)),
        Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12)),
      ],
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
