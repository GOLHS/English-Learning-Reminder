import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/word_repository.dart';
import '../../data/repositories/verb_repository.dart';
import '../../data/repositories/review_log_repository.dart';
import '../../data/repositories/preferences_repository.dart';
import '../../services/ai_service.dart';
import '../../services/srs_engine.dart';

final _testInitProvider = FutureProvider.autoDispose((ref) async {
  final wordRepo = ref.read(wordRepositoryProvider);
  final verbRepo = ref.read(verbRepositoryProvider);
  final words = await wordRepo.getAll(includeArchived: false);
  final verbs = await verbRepo.getAll();
  return _TestSessionData(words: words, verbs: verbs);
});

class _TestSessionData {
  final List words;
  final List verbs;
  const _TestSessionData({required this.words, required this.verbs});
}

int _difficultyWeight(String? d) {
  switch (d) {
    case 'Hard': return 0;
    case 'Medium': return 1;
    case 'Easy': return 2;
    default: return 1;
  }
}

const _sentenceTypes = [
  'Present Simple',
  'Present Continuous',
  'Present Perfect',
  'Past Simple',
  'Past Continuous',
  'Future Simple',
  'Future (going to)',
  'Present Perfect Continuous',
  'Past Perfect',
  'Conditional',
];

class TestItem {
  final String display;
  final String? correctAnswer;
  final bool isVerb;
  final String uuid;
  final String difficulty;
  final int reviewCount;
  final String? meaning;
  final String? pastSimple;
  final String? pastParticiple;

  const TestItem({
    required this.display,
    this.correctAnswer,
    required this.isVerb,
    required this.uuid,
    required this.difficulty,
    required this.reviewCount,
    this.meaning,
    this.pastSimple,
    this.pastParticiple,
  });
}

// ───── Mode Selection Screen ─────

class TestModeScreen extends StatelessWidget {
  const TestModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Test Mode')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 48),
            _ModeCard(
              icon: Icons.book,
              title: 'Vocabulary',
              subtitle: 'Mixed quiz — write examples or guess words from meanings',
              onTap: () => context.replace('/test/vocab'),
            ),
            const SizedBox(height: 16),
            _ModeCard(
              icon: Icons.shuffle,
              title: 'Verbs',
              subtitle: 'Write 12 example sentences per verb across different tenses',
              onTap: () => context.replace('/test/verbs'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _ModeCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(16)),
                child: Icon(icon, color: cs.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

// ───── Vocabulary Test ─────

class VocabTestScreen extends ConsumerStatefulWidget {
  const VocabTestScreen({super.key});

  @override
  ConsumerState<VocabTestScreen> createState() => _VocabTestScreenState();
}

class _VocabTestScreenState extends ConsumerState<VocabTestScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<TestItem> _items = [];
  int _currentIndex = 0;
  bool _showMeaning = false;
  bool? _lastCorrect;
  bool _graded = false;
  bool _correcting = false;
  int _correct = 0;
  int _incorrect = 0;
  int _totalAnswered = 0;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(_testInitProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary Test'),
        actions: [
          TextButton.icon(
            onPressed: _totalAnswered > 0 ? _showSummary : () => context.pop(),
            icon: const Icon(Icons.stop, size: 18),
            label: const Text('Stop'),
          ),
        ],
      ),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (d) {
          if (_items.isEmpty) {
            _initItems(d);
          }
          return _buildTest(cs);
        },
      ),
    );
  }

  void _initItems(_TestSessionData d) {
    final items = <TestItem>[];
    for (final w in d.words) {
      items.add(TestItem(
        display: w.word, correctAnswer: w.word, isVerb: false,
        uuid: w.uuid, difficulty: w.difficulty, reviewCount: w.reviewCount,
        meaning: w.meaning,
      ));
    }
    items.sort((a, b) {
      final w = _difficultyWeight(a.difficulty).compareTo(_difficultyWeight(b.difficulty));
      if (w != 0) return w;
      return a.reviewCount.compareTo(b.reviewCount);
    });
    _items = items;
    _pickMode();
  }

  void _pickMode() {
    _showMeaning = Random().nextBool();
    _graded = false;
    _lastCorrect = null;
    _correcting = false;
    _controller.clear();
  }

  Widget _buildTest(ColorScheme cs) {
    final item = _items[_currentIndex % _items.length];
    if (_items.isEmpty) return const Center(child: Text('No vocabulary yet. Add some words first!'));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LinearProgressIndicator(value: (_currentIndex % _items.length + 1) / _items.length),
          const SizedBox(height: 16),
          Text('$_totalAnswered answered  ·  $_correct correct  ·  $_incorrect incorrect',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    _showMeaning ? 'What word is this?' : 'Write an example sentence',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _showMeaning ? (item.meaning ?? item.display) : item.display,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (!_graded && !_correcting) ...[
                    TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: _showMeaning ? 'Type the word...' : 'Type an example sentence...',
                        border: const OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _check(item),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity, height: 48,
                      child: FilledButton(onPressed: () => _check(item), child: const Text('Check')),
                    ),
                  ],
                  if (_correcting) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                        const SizedBox(width: 12),
                        Text('Checking with AI...', style: TextStyle(color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ],
                  if (_lastCorrect != null && !_correcting) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_lastCorrect! ? Icons.check_circle : Icons.cancel,
                          color: _lastCorrect! ? Colors.green : Colors.red, size: 28),
                        const SizedBox(width: 8),
                        Text(_lastCorrect! ? 'Correct!' : 'Incorrect',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                            color: _lastCorrect! ? Colors.green : Colors.red)),
                      ],
                    ),
                    if (!_lastCorrect! && _showMeaning)
                      Text('Expected: ${item.correctAnswer}',
                        style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
                  ],
                  if (_graded && !_correcting) ...[
                    const SizedBox(height: 24),
                    const Text('How did you do?', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _GradeButton(label: 'Forgot', color: Colors.red.shade400, onTap: () => _grade(item, 'forgot'))),
                        const SizedBox(width: 6),
                        Expanded(child: _GradeButton(label: 'Hard', color: Colors.orange.shade400, onTap: () => _grade(item, 'hard'))),
                        const SizedBox(width: 6),
                        Expanded(child: _GradeButton(label: 'Good', color: Colors.blue.shade400, onTap: () => _grade(item, 'good'))),
                        const SizedBox(width: 6),
                        Expanded(child: _GradeButton(label: 'Easy', color: Colors.green.shade400, onTap: () => _grade(item, 'easy'))),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _check(TestItem item) async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() => _correcting = true);

    try {
      final aiService = ref.read(aiServiceProvider);
      final result = await aiService.checkAnswer(
        _showMeaning ? 'meaning' : 'example',
        input,
        expected: _showMeaning ? item.correctAnswer : null,
        word: _showMeaning ? null : item.display,
      );
      final isCorrect = result['correct'] == true;
      final feedback = (result['feedback'] as String?) ?? '';

      setState(() {
        _lastCorrect = isCorrect;
        if (isCorrect) _correct++; else _incorrect++;
        _totalAnswered++;
        _graded = true;
        _correcting = false;
      });

      if (!mounted) return;
      _showCorrectionPopup(feedback, item);
    } catch (_) {
      if (!mounted) return;
      final isCorrect = _showMeaning
          ? input.toLowerCase() == item.correctAnswer!.toLowerCase()
          : input.isNotEmpty;
      setState(() {
        _lastCorrect = isCorrect;
        if (isCorrect) _correct++; else _incorrect++;
        _totalAnswered++;
        _graded = true;
        _correcting = false;
      });
    }
  }

  void _showCorrectionPopup(String text, TestItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(_lastCorrect! ? Icons.check_circle : Icons.auto_fix_high,
              color: _lastCorrect! ? Colors.green : Colors.orange, size: 24),
            const SizedBox(width: 8),
            Text(_lastCorrect! ? 'Good job!' : 'AI Correction'),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(text, style: const TextStyle(fontSize: 15)),
        ),
        actions: [
          TextButton(
            onPressed: () { Navigator.pop(ctx); },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Future<void> _grade(TestItem item, String grade) async {
    final engine = SRSEngine();
    final logRepo = ref.read(reviewLogRepositoryProvider);

    if (item.isVerb) {
      final repo = ref.read(verbRepositoryProvider);
      final verb = await repo.getByUuid(item.uuid);
      if (verb != null) { await engine.applyToVerb(verb, grade, logRepo); await repo.save(verb); }
    } else {
      final repo = ref.read(wordRepositoryProvider);
      final word = await repo.getByUuid(item.uuid);
      if (word != null) { await engine.applyToWord(word, grade, logRepo); await repo.save(word); }
    }

    setState(() { _currentIndex++; _pickMode(); });
    _focusNode.requestFocus();
  }

  void _showSummary() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Test Complete'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(label: 'Total questions', value: '$_totalAnswered'),
            const SizedBox(height: 8),
            _SummaryRow(label: 'Correct', value: '$_correct', color: Colors.green),
            const SizedBox(height: 8),
            _SummaryRow(label: 'Incorrect', value: '$_incorrect', color: Colors.red),
            const SizedBox(height: 8),
            _SummaryRow(label: 'Accuracy', value: _totalAnswered > 0 ? '${(_correct / _totalAnswered * 100).round()}%' : '0%'),
          ],
        ),
        actions: [
          TextButton(onPressed: () { Navigator.pop(ctx); context.pop(); }, child: const Text('Done')),
        ],
      ),
    );
  }
}

// ───── Verb Test ─────

class VerbTestScreen extends ConsumerStatefulWidget {
  const VerbTestScreen({super.key});

  @override
  ConsumerState<VerbTestScreen> createState() => _VerbTestScreenState();
}

class _VerbTestScreenState extends ConsumerState<VerbTestScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<TestItem> _verbItems = [];
  int _verbIndex = 0;
  String _sentenceType = _sentenceTypes.first;
  int _examplesCount = 0;
  bool _correcting = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(_testInitProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb Examples'),
        actions: [
          TextButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.stop, size: 18),
            label: const Text('Stop'),
          ),
        ],
      ),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (d) {
          if (_verbItems.isEmpty) {
            _initItems(d);
          }
          return _buildTest(cs);
        },
      ),
    );
  }

  void _initItems(_TestSessionData d) {
    final items = <TestItem>[];
    for (final v in d.verbs) {
      items.add(TestItem(
        display: v.baseForm, isVerb: true,
        uuid: v.uuid, difficulty: v.difficulty, reviewCount: v.reviewCount,
        meaning: v.meaning, pastSimple: v.pastSimple, pastParticiple: v.pastParticiple,
      ));
    }
    items.sort((a, b) {
      final w = _difficultyWeight(a.difficulty).compareTo(_difficultyWeight(b.difficulty));
      if (w != 0) return w;
      return a.reviewCount.compareTo(b.reviewCount);
    });
    _verbItems = items;
  }

  Widget _buildTest(ColorScheme cs) {
    if (_verbItems.isEmpty) return const Center(child: Text('No verbs found.'));
    final verb = _verbItems[_verbIndex % _verbItems.length];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Verb ${(_verbIndex % _verbItems.length) + 1} of ${_verbItems.length}',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(verb.display, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${verb.pastSimple} / ${verb.pastParticiple}',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 16)),
                  if (verb.meaning != null) ...[
                    const SizedBox(height: 4),
                    Text(verb.meaning!, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Examples ($_examplesCount / 12)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _sentenceType,
            decoration: const InputDecoration(labelText: 'Sentence type', border: OutlineInputBorder()),
            items: _sentenceTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _sentenceType = v!),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: 'Write a sentence...',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _addExample(verb),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 100,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _correcting ? null : () => _addExample(verb),
                  icon: _correcting
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.add),
                  label: Text(_correcting ? '' : 'Add'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_examplesCount >= 12) ...[
            Center(
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 48),
                  const SizedBox(height: 8),
                  const Text('All 12 examples completed!', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: _nextVerb, child: const Text('Next Verb')),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ] else ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text('Write 12 example sentences using "${verb.display}" in different tenses.',
                  textAlign: TextAlign.center, style: TextStyle(color: cs.onSurfaceVariant)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _addExample(dynamic verb) async {
    final sentence = _controller.text.trim();
    if (sentence.isEmpty) return;

    setState(() => _correcting = true);

    try {
      final aiService = ref.read(aiServiceProvider);
      final result = await aiService.checkAnswer(
        'verb',
        sentence,
        word: verb.display,
        tense: _sentenceType,
      );
      final isCorrect = result['correct'] == true;
      final feedback = (result['feedback'] as String?) ?? '';

      if (!mounted) return;

      setState(() {
        _examplesCount = (_examplesCount + 1).clamp(0, 12);
        _correcting = false;
        _controller.clear();
      });

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Row(
            children: [
              Icon(isCorrect ? Icons.check_circle : Icons.auto_fix_high,
                color: isCorrect ? Colors.green : Colors.orange, size: 24),
              const SizedBox(width: 8),
              Text(isCorrect ? 'Correct!' : 'AI Correction'),
            ],
          ),
          content: SingleChildScrollView(child: Text(feedback, style: const TextStyle(fontSize: 15))),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Continue')),
          ],
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _examplesCount = (_examplesCount + 1).clamp(0, 12);
        _correcting = false;
        _controller.clear();
      });
    }
  }

  void _nextVerb() {
    setState(() {
      _verbIndex++;
      _examplesCount = 0;
      _sentenceType = _sentenceTypes.first;
      _controller.clear();
    });
    _focusNode.requestFocus();
  }
}

// ───── Shared Widgets ─────

class _GradeButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _GradeButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: color, padding: EdgeInsets.zero),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontSize: 11)),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _SummaryRow({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: color ?? Theme.of(context).colorScheme.onSurface)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
