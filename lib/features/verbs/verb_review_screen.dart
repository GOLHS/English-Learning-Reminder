import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/verb_repository.dart';
import '../../data/repositories/review_log_repository.dart';
import '../../services/srs_engine.dart';

final _verbReviewInitProvider = FutureProvider.autoDispose.family((ref, String mode) async {
  final repo = ref.read(verbRepositoryProvider);
  final verbs = await repo.getDueVerbs(limit: 50);
  verbs.shuffle(Random());
  return verbs;
});

class VerbReviewScreen extends ConsumerStatefulWidget {
  final String mode;
  const VerbReviewScreen({super.key, required this.mode});

  @override
  ConsumerState<VerbReviewScreen> createState() => _VerbReviewScreenState();
}

class _VerbReviewScreenState extends ConsumerState<VerbReviewScreen> {
  List _verbs = [];
  int _currentIndex = 0;
  bool _revealed = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final verbs = await ref.read(_verbReviewInitProvider(widget.mode).future);
    if (mounted) setState(() { _verbs = verbs; _initialized = true; });
  }

  void _nextCard() {
    setState(() { _currentIndex++; _revealed = false; });
  }

  Future<void> _grade(String grade) async {
    if (_currentIndex >= _verbs.length) return;
    final verb = _verbs[_currentIndex];
    final engine = SRSEngine();
    final logRepo = ref.read(reviewLogRepositoryProvider);
    final repo = ref.read(verbRepositoryProvider);

    final verbObj = await repo.getByUuid(verb.uuid);
    if (verbObj != null) {
      await engine.applyToVerb(verbObj, grade, logRepo);
      await repo.save(verbObj);
    }

    _nextCard();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_verbs.isEmpty) {
      return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: const Center(child: Text('No verbs to review!')),
      );
    }

    if (_currentIndex >= _verbs.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/review/summary');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final verb = _verbs[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: Column(
          children: [
            LinearProgressIndicator(value: _currentIndex / _verbs.length),
            const SizedBox(height: 4),
            Text('${_currentIndex} / ${_verbs.length}', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      body: _buildModeBody(context, verb),
    );
  }

  Widget _buildModeBody(BuildContext context, dynamic verb) {
    switch (widget.mode) {
      case 'classic':
        return _ClassicReview(verb: verb, revealed: _revealed, onReveal: () => setState(() => _revealed = true), onGrade: _grade);
      case 'missing':
        return _MissingForm(verb: verb, onGrade: _grade);
      case 'reverse':
        return _ReverseQuiz(verb: verb, onGrade: _grade);
      case 'typing':
        return _TypingMode(verb: verb, onGrade: _grade);
      case 'multiple':
        return _MultipleChoice(verb: verb, onGrade: _grade);
      default:
        return _ClassicReview(verb: verb, revealed: _revealed, onReveal: () => setState(() => _revealed = true), onGrade: _grade);
    }
  }
}

class _ClassicReview extends StatelessWidget {
  final dynamic verb;
  final bool revealed;
  final VoidCallback onReveal;
  final ValueChanged<String> onGrade;

  const _ClassicReview({required this.verb, required this.revealed, required this.onReveal, required this.onGrade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(verb.baseForm, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          if (revealed) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(verb.pastSimple, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.indigo)),
                    const SizedBox(height: 8),
                    Text('\u00B7', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(verb.pastParticiple, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.indigo)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            _GradeButtons(onGrade: onGrade),
          ] else ...[
            const Spacer(),
            FilledButton(onPressed: onReveal, child: const Text('Show answer')),
          ],
        ],
      ),
    );
  }
}

class _MissingForm extends StatefulWidget {
  final dynamic verb;
  final ValueChanged<String> onGrade;
  const _MissingForm({required this.verb, required this.onGrade});

  @override
  State<_MissingForm> createState() => _MissingFormState();
}

class _MissingFormState extends State<_MissingForm> {
  final _ctrl = TextEditingController();
  bool _checked = false;
  bool _correct = false;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: '${widget.verb.baseForm} \u2192 ',
              style: Theme.of(context).textTheme.headlineMedium,
              children: [
                TextSpan(text: '${widget.verb.pastSimple} \u2192 ', style: TextStyle(color: cs.primary)),
                TextSpan(text: '___', style: TextStyle(color: cs.onSurfaceVariant, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _ctrl,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Type the past participle',
              suffixIcon: _checked
                  ? Icon(_correct ? Icons.check : Icons.close, color: _correct ? Colors.teal : Colors.red)
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          if (_checked && _correct) ...[
            _GradeButtons(onGrade: widget.onGrade),
          ] else if (_checked) ...[
            Text('Correct: ${widget.verb.pastParticiple}', style: TextStyle(color: Colors.red.shade600)),
            const SizedBox(height: 16),
            _GradeButtons(onGrade: widget.onGrade),
          ] else ...[
            FilledButton(onPressed: () {
              setState(() {
                _correct = _ctrl.text.trim().toLowerCase() == widget.verb.pastParticiple.toLowerCase();
                _checked = true;
              });
            }, child: const Text('Check')),
          ],
        ],
      ),
    );
  }
}

class _ReverseQuiz extends StatefulWidget {
  final dynamic verb;
  final ValueChanged<String> onGrade;
  const _ReverseQuiz({required this.verb, required this.onGrade});

  @override
  State<_ReverseQuiz> createState() => _ReverseQuizState();
}

class _ReverseQuizState extends State<_ReverseQuiz> {
  final _ctrl = TextEditingController();
  bool _revealed = false;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.verb.pastParticiple, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('What is the base form?', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 32),
          if (_revealed) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(widget.verb.baseForm, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${widget.verb.pastSimple} / ${widget.verb.pastParticiple}', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            _GradeButtons(onGrade: widget.onGrade),
          ] else ...[
            TextFormField(
              controller: _ctrl,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'Type the base form'),
            ),
            const Spacer(),
            FilledButton(onPressed: () => setState(() => _revealed = true), child: const Text('Reveal')),
          ],
        ],
      ),
    );
  }
}

class _TypingMode extends StatefulWidget {
  final dynamic verb;
  final ValueChanged<String> onGrade;
  const _TypingMode({required this.verb, required this.onGrade});

  @override
  State<_TypingMode> createState() => _TypingModeState();
}

class _TypingModeState extends State<_TypingMode> {
  final _pastCtrl = TextEditingController();
  final _participleCtrl = TextEditingController();
  bool _checked = false;

  @override
  void dispose() { _pastCtrl.dispose(); _participleCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pastCorrect = _pastCtrl.text.trim().toLowerCase() == widget.verb.pastSimple.toLowerCase();
    final partCorrect = _participleCtrl.text.trim().toLowerCase() == widget.verb.pastParticiple.toLowerCase();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.verb.baseForm, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          TextFormField(
            controller: _pastCtrl,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Past Simple',
              suffixIcon: _checked ? Icon(pastCorrect ? Icons.check : Icons.close, color: pastCorrect ? Colors.teal : Colors.red) : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _participleCtrl,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Past Participle',
              suffixIcon: _checked ? Icon(partCorrect ? Icons.check : Icons.close, color: partCorrect ? Colors.teal : Colors.red) : null,
            ),
          ),
          const Spacer(),
          if (_checked) ...[
            _GradeButtons(onGrade: widget.onGrade),
          ] else ...[
            FilledButton(onPressed: () => setState(() => _checked = true), child: const Text('Check')),
          ],
        ],
      ),
    );
  }
}

class _MultipleChoice extends StatefulWidget {
  final dynamic verb;
  final ValueChanged<String> onGrade;
  const _MultipleChoice({required this.verb, required this.onGrade});

  @override
  State<_MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<_MultipleChoice> {
  String? _selected;
  bool _checked = false;

  List<String> get _options {
    final correct = widget.verb.pastParticiple as String;
    final d1 = widget.verb.pastSimple as String;
    final d2 = '${widget.verb.baseForm}ed';
    final d3 = '${widget.verb.baseForm}ing';
    final opts = <String>{correct, d1, d2, d3};
    final list = opts.toList();
    list.shuffle();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final options = _options;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.verb.baseForm} \u2192 ___ (past participle)', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          ...options.map((opt) {
            final isCorrect = opt == widget.verb.pastParticiple;
            final isSelected = _selected == opt;
            Color? bgColor;
            if (_checked && isCorrect) bgColor = Colors.teal.withValues(alpha: 0.2);
            else if (_checked && isSelected && !isCorrect) bgColor = Colors.red.withValues(alpha: 0.2);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _checked ? null : () => setState(() => _selected = opt),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: bgColor ?? cs.outline),
                    backgroundColor: bgColor,
                  ),
                  child: Text(opt, style: const TextStyle(fontSize: 16)),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          if (_checked) ...[
            _GradeButtons(onGrade: widget.onGrade),
          ] else ...[
            FilledButton(
              onPressed: _selected == null ? null : () => setState(() => _checked = true),
              child: const Text('Check'),
            ),
          ],
        ],
      ),
    );
  }
}

class _GradeButtons extends StatelessWidget {
  final ValueChanged<String> onGrade;
  const _GradeButtons({required this.onGrade});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GradeBtn(label: 'Forgot', subtitle: '1d', color: Colors.red, onTap: () => onGrade('forgot')),
        const SizedBox(height: 8),
        _GradeBtn(label: 'Hard', subtitle: '3d', color: Colors.amber, onTap: () => onGrade('hard')),
        const SizedBox(height: 8),
        _GradeBtn(label: 'Good', subtitle: '7d', color: Colors.indigo, onTap: () => onGrade('good')),
        const SizedBox(height: 8),
        _GradeBtn(label: 'Easy', subtitle: '15d', color: Colors.teal, onTap: () => onGrade('easy')),
      ],
    );
  }
}

class _GradeBtn extends StatelessWidget {
  final String label;
  final String subtitle;
  final MaterialColor color;
  final VoidCallback onTap;
  const _GradeBtn({required this.label, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.15),
          foregroundColor: color.shade700,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text(subtitle, style: TextStyle(fontSize: 12, color: color.shade700.withValues(alpha: 0.7))),
          ],
        ),
      ),
    );
  }
}
