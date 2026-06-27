import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class FilterSheet extends StatefulWidget {
  final String currentCategory;
  final String currentDifficulty;
  final String currentSort;

  const FilterSheet({
    super.key,
    required this.currentCategory,
    required this.currentDifficulty,
    required this.currentSort,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late String _category;
  late String _difficulty;
  late bool _showForgotten;
  late bool _showMastered;
  late bool _showArchived;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _category = widget.currentCategory;
    _difficulty = widget.currentDifficulty;
    _showForgotten = false;
    _showMastered = false;
    _showArchived = false;
    _sortBy = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filter & sort', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 16),
          Text('Category', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['All', ...AppConstants.categories].map((c) => ChoiceChip(
              label: Text(c),
              selected: _category == c,
              onSelected: (_) => setState(() => _category = c),
            )).toList(),
          ),
          const SizedBox(height: 16),
          Text('Difficulty', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['All', 'Easy', 'Medium', 'Hard'].map((d) => ChoiceChip(
              label: Text(d),
              selected: _difficulty == d,
              onSelected: (_) => setState(() => _difficulty = d),
            )).toList(),
          ),
          const SizedBox(height: 16),
          Text('Status', style: Theme.of(context).textTheme.titleSmall),
          CheckboxListTile(title: const Text('Show forgotten'), value: _showForgotten, onChanged: (v) => setState(() => _showForgotten = v!), dense: true),
          CheckboxListTile(title: const Text('Show mastered'), value: _showMastered, onChanged: (v) => setState(() => _showMastered = v!), dense: true),
          CheckboxListTile(title: const Text('Show archived'), value: _showArchived, onChanged: (v) => setState(() => _showArchived = v!), dense: true),
          const SizedBox(height: 16),
          Text('Sort by', style: Theme.of(context).textTheme.titleSmall),
          ...['newest', 'oldest', 'alphabetical', 'difficult'].map((s) => RadioListTile<String>(
            title: Text(s[0].toUpperCase() + s.substring(1)),
            value: s,
            groupValue: _sortBy,
            onChanged: (v) => setState(() => _sortBy = v!),
            dense: true,
          )),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: OutlinedButton(
                onPressed: () => Navigator.pop(context, {
                  'category': 'All', 'difficulty': 'All', 'sort': 'newest',
                }),
                child: const Text('Reset'),
              )),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, {
                    'category': _category, 'difficulty': _difficulty, 'sort': _sortBy,
                  }),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
