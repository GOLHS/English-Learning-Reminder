import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'verb_model.g.dart';

@collection
class Verb {
  Id id = Isar.autoIncrement;
  @Index()
  String uuid = '';
  String baseForm = '';
  String pastSimple = '';
  String pastParticiple = '';
  String? meaning;
  List<String> examples = [];
  String difficulty = 'Medium';
  String? patternGroup;
  int reviewScore = 0;
  DateTime createdAt = DateTime.now();

  // SRS fields
  double easeFactor = 2.5;
  int interval = 0;
  int repetitions = 0;
  int reviewCount = 0;
  int successCount = 0;
  int consecutiveCorrect = 0;
  DateTime? nextReviewAt;
  DateTime? lastReviewedAt;

  double get successRate => reviewCount > 0 ? successCount / reviewCount : 0;

  bool get isDifficult => consecutiveCorrect < 2 && reviewCount >= 3;

  static Verb create({
    required String baseForm,
    required String pastSimple,
    required String pastParticiple,
    String? meaning,
    List<String>? examples,
    String difficulty = 'Medium',
    String? patternGroup,
  }) {
    final v = Verb()
      ..uuid = const Uuid().v4()
      ..baseForm = baseForm.trim()
      ..pastSimple = pastSimple.trim()
      ..pastParticiple = pastParticiple.trim()
      ..meaning = meaning?.trim()
      ..examples = examples ?? []
      ..difficulty = difficulty
      ..patternGroup = patternGroup
      ..createdAt = DateTime.now()
      ..nextReviewAt = DateTime.now();
    return v;
  }
}
