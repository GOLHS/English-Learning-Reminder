import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomFrequencyScreen extends StatefulWidget {
  const CustomFrequencyScreen({super.key});

  @override
  State<CustomFrequencyScreen> createState() => _CustomFrequencyScreenState();
}

class _CustomFrequencyScreenState extends State<CustomFrequencyScreen> {
  double _reviewsPerWord = 2;
  String _period = 'Month';
  double _maxDaily = 20;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final summary = "You'll see ${_reviewsPerWord.round()} reviews per word every $_period, up to ${_maxDaily.round()} reviews per day.";

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Custom rhythm'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Reviews per word: ${_reviewsPerWord.round()}', style: Theme.of(context).textTheme.titleSmall),
                Slider(value: _reviewsPerWord, min: 1, max: 10, divisions: 9, label: '${_reviewsPerWord.round()}', onChanged: (v) => setState(() => _reviewsPerWord = v)),
                const SizedBox(height: 24),
                Text('Review period', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _period,
                  items: ['Week', 'Month', 'Quarter'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (v) => setState(() => _period = v!),
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 24),
                Text('Max daily reviews: ${_maxDaily.round()}', style: Theme.of(context).textTheme.titleSmall),
                Slider(value: _maxDaily, min: 5, max: 100, divisions: 19, label: '${_maxDaily.round()}', onChanged: (v) => setState(() => _maxDaily = v)),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.summarize, color: cs.primary),
                        const SizedBox(width: 12),
                        Expanded(child: Text(summary, style: TextStyle(color: cs.onSurfaceVariant))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: TextButton(onPressed: () => context.pop(), child: const Text('Back'))),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: FilledButton(onPressed: () => context.replace('/onboarding/notifications'), child: const Text('Continue')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
