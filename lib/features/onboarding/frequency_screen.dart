import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FrequencyScreen extends StatefulWidget {
  const FrequencyScreen({super.key});

  @override
  State<FrequencyScreen> createState() => _FrequencyScreenState();
}

class _FrequencyScreenState extends State<FrequencyScreen> {
  String? _selected;

  final _options = [
    _IntensityOption('light', 'Light', '1 review per word per month', Icons.eco, null),
    _IntensityOption('balanced', 'Balanced', '2 reviews per word per month', Icons.scale, 'Recommended'),
    _IntensityOption('intensive', 'Intensive', 'Daily reviews', Icons.local_fire_department, null),
    _IntensityOption('custom', 'Custom', 'Set your own rhythm', Icons.tune, null),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Choose your pace'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text('How often do you want to review each word?', style: Theme.of(context).textTheme.bodyLarge),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _options.map((opt) {
                final selected = _selected == opt.key;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    color: selected ? cs.primaryContainer : null,
                    child: InkWell(
                      onTap: () => setState(() => _selected = opt.key),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(opt.icon, color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(opt.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                                      if (opt.badge != null) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
                                          child: Text(opt.badge!, style: const TextStyle(color: Colors.white, fontSize: 11)),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(opt.subtitle, style: TextStyle(color: cs.onSurfaceVariant)),
                                ],
                              ),
                            ),
                            Radio<String>(value: opt.key, groupValue: _selected, onChanged: (v) => setState(() => _selected = v)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _selected == null
                    ? null
                    : () {
                        if (_selected == 'custom') {
                          context.replace('/onboarding/custom');
                        } else {
                          context.replace('/onboarding/notifications');
                        }
                      },
                child: const Text('Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntensityOption {
  final String key;
  final String title;
  final String subtitle;
  final IconData icon;
  final String? badge;
  const _IntensityOption(this.key, this.title, this.subtitle, this.icon, this.badge);
}
