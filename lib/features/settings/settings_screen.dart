import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_bottom_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final themeMode = ValueNotifier<String>('System');

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person, color: cs.primary)),
              title: const Text('Learner'),
              subtitle: const Text('Local profile'),
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Learning'),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/notifications'),
          ),
          ListTile(
            leading: const Icon(Icons.tune),
            title: const Text('Learning preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/learning'),
          ),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Archive'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/archive'),
          ),
          const Divider(),
          _SectionHeader(title: 'AI'),
          ListTile(
            leading: const Icon(Icons.auto_awesome_outlined),
            title: const Text('AI settings'),
            subtitle: const Text('API key & model'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/ai'),
          ),
          const Divider(),
          _SectionHeader(title: 'Data'),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: const Text('Data & backup'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/data'),
          ),
          const Divider(),
          _SectionHeader(title: 'Appearance'),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            trailing: ValueListenableBuilder<String>(
              valueListenable: themeMode,
              builder: (_, v, __) => Text(v, style: TextStyle(color: cs.onSurfaceVariant)),
            ),
            onTap: () {
              final current = themeMode.value;
              showModalBottomSheet(
                context: context,
                builder: (ctx) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ['System', 'Light', 'Dark'].map((m) => ListTile(
                    title: Text(m),
                    trailing: current == m ? Icon(Icons.check, color: Theme.of(ctx).colorScheme.primary) : null,
                    onTap: () { themeMode.value = m; Navigator.pop(ctx); },
                  )).toList(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: Text('English', style: TextStyle(color: cs.onSurfaceVariant)),
          ),
          const Divider(),
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App version'),
            trailing: Text('1.0.0', style: TextStyle(color: cs.onSurfaceVariant)),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Open-source licenses'),
            onTap: () => showLicensePage(context: context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy policy'),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 5),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
    );
  }
}


