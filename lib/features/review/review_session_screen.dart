import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/word_repository.dart';
import '../../data/repositories/verb_repository.dart';
import '../../data/repositories/review_log_repository.dart';
import '../../services/srs_engine.dart';
import '../../data/repositories/preferences_repository.dart';

enum ReviewStep { showWord, recall, reveal, usage, grade }

final _sessionProvider = FutureProvider.autoDispose<ReviewSession>((ref) async {
  final wordRepo = ref.read(wordRepositoryProvider);
  final verbRepo = ref.read(verbRepositoryProvider);
  final prefsRepo = ref.read(preferencesRepositoryProvider);
  final prefs = await prefsRepo.get();

  final dueWords = await wordRepo.getDueWords(limit: prefs.maxDailyReviews);
  final dueVerbs = await verbRepo.getDueVerbs(limit: 50);

  final items = <ReviewItem>[];
  for (final w in dueWords) {
    items.add(ReviewItem(type: 'word', word: w.word, meaning: w.meaning, examples: w.examples, notes: w.notes, synonyms: w.synonyms, uuid: w.uuid));
  }
  for (final v in dueVerbs) {
    items.add(ReviewItem(type: 'verb', word: v.baseForm, meaning: v.meaning, examples: v.examples, notes: null, synonyms: [], uuid: v.uuid));
  }
  items.shuffle(Random());

  return ReviewSession(items: items, currentIndex: 0, step: ReviewStep.showWord, userExamples: {}, typingMode: prefs.typingMode);
});

class ReviewItem {
  final String type;
  final String word;
  final String? meaning;
  final List<String> examples;
  final String? notes;
  final List<String> synonyms;
  final String uuid;
  ReviewItem({required this.type, required this.word, this.meaning, required this.examples, this.notes, required this.synonyms, required this.uuid});
}

class ReviewSession {
  final List<ReviewItem> items;
  final int currentIndex;
  final ReviewStep step;
  final Map<String, String> userExamples;
  final bool typingMode;

  ReviewSession({
    required this.items,
    required this.currentIndex,
    required this.step,
    required this.userExamples,
    required this.typingMode,
  });

  ReviewItem get currentItem => items[currentIndex];
  int get total => items.length;
  int get reviewed => currentIndex;
  bool get isLast => currentIndex >= items.length - 1;
}

final _sessionStateProvider = StateNotifierProvider.autoDispose<ReviewSessionNotifier, AsyncValue<ReviewSession>>((ref) {
  return ReviewSessionNotifier(ref);
});

class ReviewSessionNotifier extends StateNotifier<AsyncValue<ReviewSession>> {
  final Ref _ref;
  ReviewSessionNotifier(this._ref) : super(const AsyncLoading()) {
    _init();
  }

  Future<void> _init() async {
    final session = await _ref.read(_sessionProvider.future);
    state = AsyncData(session);
  }

  void advanceStep(ReviewStep next) {
    state.whenData((s) {
      state = AsyncData(ReviewSession(
        items: s.items,
        currentIndex: s.currentIndex,
        step: next,
        userExamples: s.userExamples,
        typingMode: s.typingMode,
      ));
    });
  }

  void saveUserExample(String example) {
    state.whenData((s) {
      final examples = Map<String, String>.from(s.userExamples);
      examples[s.currentItem.uuid] = example;
      state = AsyncData(ReviewSession(
        items: s.items,
        currentIndex: s.currentIndex,
        step: s.step,
        userExamples: examples,
        typingMode: s.typingMode,
      ));
    });
  }

  Future<void> gradeCard(String grade) async {
    state.whenData((s) async {
      final item = s.currentItem;
      final engine = SRSEngine();
      final logRepo = _ref.read(reviewLogRepositoryProvider);

      if (item.type == 'word') {
        final repo = _ref.read(wordRepositoryProvider);
        final word = await repo.getByUuid(item.uuid);
        if (word != null) {
          await engine.applyToWord(word, grade, logRepo);
          await repo.save(word);
        }
      } else {
        final repo = _ref.read(verbRepositoryProvider);
        final verb = await repo.getByUuid(item.uuid);
        if (verb != null) {
          await engine.applyToVerb(verb, grade, logRepo);
          await repo.save(verb);
        }
      }

      if (s.isLast) {
        state = AsyncData(ReviewSession(items: s.items, currentIndex: s.currentIndex, step: ReviewStep.grade, userExamples: s.userExamples, typingMode: s.typingMode));
      } else {
        state = AsyncData(ReviewSession(
          items: s.items,
          currentIndex: s.currentIndex + 1,
          step: ReviewStep.showWord,
          userExamples: s.userExamples,
          typingMode: s.typingMode,
        ));
      }
    });
  }
}

class ReviewSessionScreen extends ConsumerWidget {
  const ReviewSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(_sessionStateProvider);
    final cs = Theme.of(context).colorScheme;

    return sessionAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (session) {
        if (session.items.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 64, color: Colors.teal),
                  const SizedBox(height: 16),
                  const Text("Nothing to review!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  FilledButton(onPressed: () => context.pop(), child: const Text('Go back')),
                ],
              ),
            ),
          );
        }

        if (session.isLast && session.step == ReviewStep.grade) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/review/summary');
          });
        }

        final item = session.currentItem;
        final progress = session.currentIndex / session.total;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _showExitConfirm(context, session);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _showExitConfirm(context, session),
              ),
              title: Column(
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 4),
                  Text('${session.currentIndex} / ${session.total}', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildStep(context, ref, session, item, cs),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(BuildContext context, WidgetRef ref, ReviewSession session, ReviewItem item, ColorScheme cs) {
    switch (session.step) {
      case ReviewStep.showWord:
        return _ShowWordStep(item: item, cs: cs, onShowMeaning: () => ref.read(_sessionStateProvider.notifier).advanceStep(session.typingMode ? ReviewStep.recall : ReviewStep.reveal));
      case ReviewStep.recall:
        return _RecallStep(item: item, cs: cs, onReveal: () => ref.read(_sessionStateProvider.notifier).advanceStep(ReviewStep.reveal));
      case ReviewStep.reveal:
        return _RevealStep(item: item, cs: cs, onContinue: () => ref.read(_sessionStateProvider.notifier).advanceStep(ReviewStep.usage));
      case ReviewStep.usage:
        return _UsageStep(item: item, cs: cs, onSave: (ex) {
          ref.read(_sessionStateProvider.notifier).saveUserExample(ex);
          ref.read(_sessionStateProvider.notifier).advanceStep(ReviewStep.grade);
        }, onSkip: () => ref.read(_sessionStateProvider.notifier).advanceStep(ReviewStep.grade));
      case ReviewStep.grade:
        return _GradeStep(onGrade: (grade) => ref.read(_sessionStateProvider.notifier).gradeCard(grade));
    }
  }

  void _showExitConfirm(BuildContext context, ReviewSession session) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('End review?'),
        content: Text("You've reviewed ${session.reviewed} of ${session.total} words. Progress will be saved."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Continue review')),
          FilledButton(onPressed: () { Navigator.pop(ctx); context.go('/'); }, child: const Text('End now')),
        ],
      ),
    );
  }
}

class _ShowWordStep extends StatelessWidget {
  final ReviewItem item;
  final ColorScheme cs;
  final VoidCallback onShowMeaning;
  const _ShowWordStep({required this.item, required this.cs, required this.onShowMeaning});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(item.word, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('Try to recall the meaning', style: TextStyle(color: cs.onSurfaceVariant)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: null, icon: Icon(Icons.volume_up, color: cs.onSurfaceVariant)),
              const SizedBox(width: 8),
              IconButton(onPressed: null, icon: Icon(Icons.star_border, color: cs.onSurfaceVariant)),
              const SizedBox(width: 8),
              IconButton(onPressed: null, icon: Icon(Icons.visibility_off, color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: onShowMeaning, child: const Text('Show meaning'))),
        ],
      ),
    );
  }
}

class _RecallStep extends StatelessWidget {
  final ReviewItem item;
  final ColorScheme cs;
  final VoidCallback onReveal;
  const _RecallStep({required this.item, required this.cs, required this.onReveal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text('Type the meaning of:', style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 16),
          Text(item.word, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Type the meaning...'),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(child: TextButton(onPressed: onReveal, child: const Text('Skip'))),
              const SizedBox(width: 16),
              Expanded(child: SizedBox(height: 52, child: FilledButton(onPressed: onReveal, child: const Text('Reveal')))),
            ],
          ),
        ],
      ),
    );
  }
}

class _RevealStep extends StatelessWidget {
  final ReviewItem item;
  final ColorScheme cs;
  final VoidCallback onContinue;
  const _RevealStep({required this.item, required this.cs, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text('Meaning', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(item.meaning ?? '', style: Theme.of(context).textTheme.bodyLarge),
          if (item.examples.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Examples', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...item.examples.map((e) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('\u2022  $e', style: TextStyle(color: cs.onSurfaceVariant, fontStyle: FontStyle.italic)))),
          ],
          if (item.synonyms.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Synonyms', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: item.synonyms.map((s) => Chip(label: Text(s), visualDensity: VisualDensity.compact)).toList()),
          ],
          if (item.notes != null) ...[
            const SizedBox(height: 16),
            Text('Notes', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(item.notes!, style: TextStyle(color: cs.onSurfaceVariant)),
          ],
          const Spacer(),
          SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: onContinue, child: const Text('Continue'))),
        ],
      ),
    );
  }
}

class _UsageStep extends StatelessWidget {
  final ReviewItem item;
  final ColorScheme cs;
  final ValueChanged<String> onSave;
  final VoidCallback onSkip;
  const _UsageStep({required this.item, required this.cs, required this.onSave, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text('Write a new example using "${item.word}":', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          TextFormField(
            controller: ctrl,
            maxLines: 3,
            decoration: InputDecoration(hintText: 'She remained ___ after failure.'),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(child: TextButton(onPressed: onSkip, child: const Text('Skip'))),
              const SizedBox(width: 16),
              Expanded(child: SizedBox(height: 52, child: FilledButton(onPressed: () => onSave(ctrl.text), child: const Text('Save & continue')))),
            ],
          ),
        ],
      ),
    );
  }
}

class _GradeStep extends StatelessWidget {
  final ValueChanged<String> onGrade;
  const _GradeStep({required this.onGrade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('How well did you know this?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          _GradeButton(label: 'Forgot', subtitle: 'see again in 1d', color: Colors.red.shade400, onTap: () => onGrade('forgot')),
          const SizedBox(height: 12),
          _GradeButton(label: 'Hard', subtitle: 'see again in 3d', color: Colors.amber.shade600, onTap: () => onGrade('hard')),
          const SizedBox(height: 12),
          _GradeButton(label: 'Good', subtitle: 'see again in 7d', color: Colors.indigo.shade400, onTap: () => onGrade('good')),
          const SizedBox(height: 12),
          _GradeButton(label: 'Easy', subtitle: 'see again in 15d', color: Colors.teal.shade400, onTap: () => onGrade('easy')),
        ],
      ),
    );
  }
}

class _GradeButton extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _GradeButton({required this.label, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.15),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }
}
