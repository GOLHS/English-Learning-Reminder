import 'package:flutter/material.dart';
import '../../data/models/word_model.dart';
import '../utils/date_utils.dart';

class WordTile extends StatelessWidget {
  final Word word;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onMarkDifficult;
  final VoidCallback? onReviewNow;
  final VoidCallback? onArchive;
  final VoidCallback? onDelete;

  const WordTile({
    super.key,
    required this.word,
    this.onTap,
    this.onEdit,
    this.onMarkDifficult,
    this.onReviewNow,
    this.onArchive,
    this.onDelete,
  });

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.teal;
      case 'Hard':
        return Colors.amber;
      default:
        return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final diffColor = _difficultyColor(word.difficulty);
    final meta = StringBuffer();
    if (word.nextReviewAt != null) {
      meta.write('Next: ${AppDateUtils.daysUntil(word.nextReviewAt!)}');
    }
    if (word.reviewCount > 0) {
      meta.write(' · Success ${(word.successRate * 100).round()}%');
    }
    if (word.category != null) {
      meta.write(' · ${word.category}');
    }

    return ListTile(
      onTap: onTap,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: diffColor, shape: BoxShape.circle)),
          if (word.isMastered) ...[
            const SizedBox(height: 2),
            const Icon(Icons.star, size: 12, color: Colors.amber),
          ],
        ],
      ),
      title: Text(word.word, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(word.meaning, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
          Text(meta.toString(), style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11)),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (v) {
          switch (v) {
            case 'edit': onEdit?.call();
            case 'difficult': onMarkDifficult?.call();
            case 'review': onReviewNow?.call();
            case 'archive': onArchive?.call();
            case 'delete': onDelete?.call();
          }
        },
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'edit', child: Text('Edit')),
          const PopupMenuItem(value: 'difficult', child: Text('Mark difficult')),
          const PopupMenuItem(value: 'review', child: Text('Review now')),
          const PopupMenuItem(value: 'archive', child: Text('Archive')),
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
