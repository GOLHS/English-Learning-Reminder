import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'story_summary_model.g.dart';

@collection
class StorySummary {
  Id id = Isar.autoIncrement;
  @Index()
  late String uuid;
  @Index()
  late String storyUuid;
  late String text;
  late DateTime createdAt;
  @Index()
  late DateTime summaryDate;

  static StorySummary create({
    required String storyUuid,
    required String text,
    required DateTime summaryDate,
  }) {
    final s = StorySummary()
      ..uuid = const Uuid().v4()
      ..storyUuid = storyUuid
      ..text = text.trim()
      ..createdAt = DateTime.now()
      ..summaryDate = DateTime(summaryDate.year, summaryDate.month, summaryDate.day);
    return s;
  }
}
