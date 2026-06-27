import 'package:isar/isar.dart';

part 'review_log_model.g.dart';

@collection
class ReviewLog {
  Id id = Isar.autoIncrement;
  @Index()
  late String itemId;
  late String itemType;
  late String result;
  late DateTime reviewedAt;
  double interval = 0;
  double easeFactor = 2.5;
  int repetitions = 0;
  bool wasCorrect = false;

  static ReviewLog create({
    required String itemId,
    required String itemType,
    required String result,
    double interval = 0,
    double easeFactor = 2.5,
    int repetitions = 0,
    bool wasCorrect = false,
  }) {
    return ReviewLog()
      ..itemId = itemId
      ..itemType = itemType
      ..result = result
      ..reviewedAt = DateTime.now()
      ..interval = interval
      ..easeFactor = easeFactor
      ..repetitions = repetitions
      ..wasCorrect = wasCorrect;
  }
}
