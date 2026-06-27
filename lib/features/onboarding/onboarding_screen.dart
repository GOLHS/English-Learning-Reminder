import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final _pages = const [
    _WelcomePageData(
      icon: Icons.auto_stories,
      title: 'Learn English Smarter',
      body: 'The app helps you memorize vocabulary using daily reviews and repetition.',
    ),
    _WelcomePageData(
      icon: Icons.psychology,
      title: 'Build Long-Term Memory',
      body: 'Words are reviewed automatically at the best time for memorization.',
    ),
    _WelcomePageData(
      icon: Icons.edit_note,
      title: 'Practice With Real Usage',
      body: 'Write examples and improve contextual understanding.',
    ),
  ];

  void _goNext() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      context.replace('/onboarding/frequency');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ColoredBox(
      color: cs.surface,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.replace('/onboarding/frequency'),
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: _pages.map((p) => _WelcomePage(data: p)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _pages.length,
                    effect: WormEffect(dotColor: cs.outlineVariant, activeDotColor: cs.primary),
                  ),
                  const SizedBox(height: 24),
                  if (_currentPage > 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
                        child: const Text('Back'),
                      ),
                    ),
                  Align(
                    alignment: _currentPage > 0 ? Alignment.centerRight : Alignment.center,
                    child: FilledButton(
                      onPressed: _goNext,
                      child: Text(_currentPage == _pages.length - 1 ? 'Get Started' : 'Next'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePageData {
  final IconData icon;
  final String title;
  final String body;
  const _WelcomePageData({required this.icon, required this.title, required this.body});
}

class _WelcomePage extends StatelessWidget {
  final _WelcomePageData data;
  const _WelcomePage({required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(120),
            ),
            child: Icon(data.icon, size: 80, color: cs.primary),
          ),
          const SizedBox(height: 48),
          Text(data.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(data.body, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
