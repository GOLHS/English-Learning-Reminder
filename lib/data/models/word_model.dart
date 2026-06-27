import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'word_model.g.dart';

@collection
class Word {
  Id id = Isar.autoIncrement;
  @Index()
  late String uuid;
  late String word;
  late String meaning;
  List<String> examples = [];
  String? notes;
  String? category;
  List<String> synonyms = [];
  List<String> antonyms = [];
  String? pronunciation;
  String difficulty = 'Medium';
  bool isMastered = false;
  bool isArchived = false;
  late DateTime createdAt;

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

  static Word create({
    required String word,
    required String meaning,
    List<String>? examples,
    String? notes,
    String? category,
    List<String>? synonyms,
    List<String>? antonyms,
    String? pronunciation,
    String difficulty = 'Medium',
  }) {
    final w = Word()
      ..uuid = const Uuid().v4()
      ..word = word.trim()
      ..meaning = meaning.trim()
      ..examples = examples ?? []
      ..notes = notes?.trim()
      ..category = category?.trim()
      ..synonyms = synonyms ?? []
      ..antonyms = antonyms ?? []
      ..pronunciation = pronunciation?.trim()
      ..difficulty = difficulty
      ..createdAt = DateTime.now()
      ..nextReviewAt = DateTime.now();
    return w;
  }

  void updateFrom({
    String? word,
    String? meaning,
    List<String>? examples,
    String? notes,
    String? category,
    List<String>? synonyms,
    List<String>? antonyms,
    String? pronunciation,
    String? difficulty,
  }) {
    if (word != null) this.word = word.trim();
    if (meaning != null) this.meaning = meaning.trim();
    if (examples != null) this.examples = examples;
    if (notes != null) this.notes = notes.trim();
    if (category != null) this.category = category.trim();
    if (synonyms != null) this.synonyms = synonyms;
    if (antonyms != null) this.antonyms = antonyms;
    if (pronunciation != null) this.pronunciation = pronunciation.trim();
    if (difficulty != null) this.difficulty = difficulty;
  }
}
