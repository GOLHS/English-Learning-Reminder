import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'story_model.g.dart';

@collection
class Story {
  Id id = Isar.autoIncrement;
  @Index()
  late String uuid;
  late String title;
  late String text;
  bool isPreloaded = false;
  bool isArchived = false;
  late DateTime createdAt;
  DateTime? updatedAt;

  static Story create({
    required String title,
    required String text,
    bool isPreloaded = false,
  }) {
    final s = Story()
      ..uuid = const Uuid().v4()
      ..title = title.trim()
      ..text = text.trim()
      ..isPreloaded = isPreloaded
      ..createdAt = DateTime.now();
    return s;
  }
}
