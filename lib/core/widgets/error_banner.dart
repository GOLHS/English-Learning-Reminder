import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorBanner({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MaterialBanner(
      backgroundColor: cs.errorContainer,
      content: Text(message, style: TextStyle(color: cs.onErrorContainer)),
      leading: Icon(Icons.error_outline, color: cs.error),
      actions: [
        if (onRetry != null)
          TextButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    );
  }
}
