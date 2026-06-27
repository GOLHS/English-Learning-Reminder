import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        switch (i) {
          case 0: context.go('/');
          case 1: context.go('/vocabulary');
          case 2: context.go('/stories');
          case 3: context.go('/verbs');
          case 4: context.go('/stats');
          case 5: context.go('/settings');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Vocabulary'),
        BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Stories'),
        BottomNavigationBarItem(icon: Icon(Icons.shuffle), label: 'Verbs'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
