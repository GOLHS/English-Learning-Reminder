import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../../data/models/verb_model.dart';
import '../../data/repositories/verb_repository.dart';

final _verbsHomeProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.read(verbRepositoryProvider);
  final all = await repo.getAll();
  final due = await repo.getDueVerbs();
  return _VerbsHomeData(all: all, dueCount: due.length);
});

class _VerbsHomeData {
  final List<Verb> all;
  final int dueCount;
  const _VerbsHomeData({required this.all, required this.dueCount});
}

class VerbsHomeScreen extends ConsumerWidget {
  const VerbsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_verbsHomeProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Irregular Verbs')),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: cs.error),
                const SizedBox(height: 16),
                Text('$e', textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton(onPressed: () => ref.invalidate(_verbsHomeProvider), child: const Text('Retry')),
              ],
            ),
          ),
        ),
        data: (d) {
          if (d.all.isEmpty) {
            return const Center(child: Text('No verbs found'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text('${d.all.length} verbs, ${d.dueCount} due'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: d.all.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(d.all[i].baseForm.isNotEmpty ? d.all[i].baseForm : '??'),
                    subtitle: Text('${d.all[i].pastSimple} / ${d.all[i].pastParticiple}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: data.hasValue
          ? FloatingActionButton.extended(
              onPressed: () => context.go('/verbs/add'),
              icon: const Icon(Icons.add),
              label: const Text('Add verb'),
            )
          : null,
      bottomNavigationBar: AppBottomNav(currentIndex: 3),
    );
  }
}




