import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/preferences_repository.dart';

class NotificationSetupScreen extends ConsumerStatefulWidget {
  const NotificationSetupScreen({super.key});

  @override
  ConsumerState<NotificationSetupScreen> createState() => _NotificationSetupScreenState();
}

class _NotificationSetupScreenState extends ConsumerState<NotificationSetupScreen> {
  bool _enabled = true;
  TimeOfDay _time = const TimeOfDay(hour: 19, minute: 0);
  Set<String> _days = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'};
  TimeOfDay _quietStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietEnd = const TimeOfDay(hour: 8, minute: 0);

  static const _allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Stay consistent'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SwitchListTile(
                  title: const Text('Enable daily reminders'),
                  value: _enabled,
                  onChanged: (v) => setState(() => _enabled = v),
                ),
                ListTile(
                  title: const Text('Preferred hour'),
                  trailing: Text(_time.format(context)),
                  onTap: _pickTime,
                ),
                const SizedBox(height: 16),
                Text('Allowed days', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _allDays.map((day) {
                    final selected = _days.contains(day);
                    return FilterChip(
                      label: Text(day),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          if (v) { _days.add(day); } else { _days.remove(day); }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Quiet hours'),
                  subtitle: Text('${_quietStart.format(context)} \u2192 ${_quietEnd.format(context)}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final start = await showTimePicker(context: context, initialTime: _quietStart);
                    if (start == null) return;
                    final end = await showTimePicker(context: context, initialTime: _quietEnd);
                    if (end != null) setState(() { _quietStart = start; _quietEnd = end; });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('We never send more than one reminder per day.', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
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
                    child: FilledButton(
                      onPressed: () async {
                        final prefsRepo = ref.read(preferencesRepositoryProvider);
                        final prefs = await prefsRepo.get();
                        prefs.notificationEnabled = _enabled;
                        prefs.notificationHour = _time.hour;
                        prefs.notificationMinute = _time.minute;
                        prefs.notificationDays = _days.toList();
                        prefs.quietHoursStart = _quietStart.hour;
                        prefs.quietHoursEnd = _quietEnd.hour;
                        await prefsRepo.completeOnboarding();
                        if (context.mounted) context.replace('/');
                      },
                      child: const Text('Finish'),
                    ),
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
