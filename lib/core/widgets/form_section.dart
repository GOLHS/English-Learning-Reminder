import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const FormSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.primary, letterSpacing: 0.5)),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(subtitle!, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
          ),
      ],
    );
  }
}
