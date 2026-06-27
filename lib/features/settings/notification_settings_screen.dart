import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_preferences.dart';
import '../../data/repositories/preferences_repository.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
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
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings saved')));
  }

  static const _allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return Scaffold(appBar: AppBar(title: const Text('Notifications')), body: const Center(child: CircularProgressIndicator()));

    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable reminders'),
            subtitle: const Text('Daily review notifications'),
            value: _prefs.notificationEnabled,
            onChanged: (v) => setState(() { _prefs.notificationEnabled = v; _save(); }),
          ),
          ListTile(
            title: const Text('Reminder time'),
            subtitle: Text('${_prefs.notificationHour.toString().padLeft(2, '0')}:${_prefs.notificationMinute.toString().padLeft(2, '0')}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final picked = await showTimePicker(context: context, initialTime: TimeOfDay(hour: _prefs.notificationHour, minute: _prefs.notificationMinute));
              if (picked != null) {
                setState(() { _prefs.notificationHour = picked.hour; _prefs.notificationMinute = picked.minute; });
                _save();
              }
            },
          ),
          ListTile(
            title: const Text('Quiet hours'),
            subtitle: Text('${_prefs.quietHoursStart.toString().padLeft(2, '0')}:00 \u2192 ${_prefs.quietHoursEnd.toString().padLeft(2, '0')}:00'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final start = await showTimePicker(context: context, initialTime: TimeOfDay(hour: _prefs.quietHoursStart, minute: 0));
              if (start == null) return;
              final end = await showTimePicker(context: context, initialTime: TimeOfDay(hour: _prefs.quietHoursEnd, minute: 0));
              if (end != null) setState(() { _prefs.quietHoursStart = start.hour; _prefs.quietHoursEnd = end.hour; _save(); });
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Allowed days', style: Theme.of(context).textTheme.titleSmall),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 8,
              children: _allDays.map((day) => FilterChip(
                label: Text(day),
                selected: _prefs.notificationDays.contains(day),
                onSelected: (v) {
                  setState(() {
                    if (v) { _prefs.notificationDays.add(day); } else { _prefs.notificationDays.remove(day); }
                  });
                  _save();
                },
              )).toList(),
            ),
          ),
          ListTile(
            title: const Text('Daily review limit'),
            subtitle: Text('${_prefs.maxDailyReviews} reviews per day'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await showDialog<int>(context: context, builder: (ctx) => _SliderDialog(
                title: 'Daily review limit',
                initial: _prefs.maxDailyReviews.toDouble(),
                min: 5, max: 100, divisions: 19,
              ));
              if (result != null) setState(() { _prefs.maxDailyReviews = result; _save(); });
            },
          ),
          SwitchListTile(
            title: const Text('Direct recall notifications'),
            subtitle: const Text('"What does X mean?"'),
            value: false,
            onChanged: (_) {},
          ),
          SwitchListTile(
            title: const Text('Motivation messages'),
            subtitle: const Text('Streak achievements'),
            value: false,
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              child: const Text('Send test notification'),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SliderDialog extends StatefulWidget {
  final String title;
  final double initial;
  final double min;
  final double max;
  final int divisions;
  const _SliderDialog({required this.title, required this.initial, required this.min, required this.max, required this.divisions});

  @override
  State<_SliderDialog> createState() => _SliderDialogState();
}

class _SliderDialogState extends State<_SliderDialog> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${_value.round()}', style: Theme.of(context).textTheme.headlineMedium),
          Slider(value: _value, min: widget.min, max: widget.max, divisions: widget.divisions, onChanged: (v) => setState(() => _value = v)),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context, _value.round()), child: const Text('Apply')),
      ],
    );
  }
}
