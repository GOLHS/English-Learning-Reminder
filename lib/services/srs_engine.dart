import '../data/models/word_model.dart';
import '../data/models/verb_model.dart';
import '../data/models/review_log_model.dart';
import '../data/repositories/review_log_repository.dart';

class SRSResult {
  final int newInterval;
  final double newEaseFactor;
  final int newRepetitions;
  final bool wasCorrect;

  SRSResult({
    required this.newInterval,
    required this.newEaseFactor,
    required this.newRepetitions,
    required this.wasCorrect,
  });
}

class SRSEngine {
  static const double minEaseFactor = 1.3;
  static const double maxEaseFactor = 3.0;
  static const int maxInterval = 365;

  SRSResult calculate({
    required String grade,
    required int currentInterval,
    required double currentEaseFactor,
    required int currentRepetitions,
  }) {
    int newInterval;
    double newEaseFactor = currentEaseFactor;
    int newRepetitions = currentRepetitions;
    bool wasCorrect;

    switch (grade) {
      case 'forgot':
        newInterval = 1;
        newEaseFactor = (currentEaseFactor - 0.2).clamp(minEaseFactor, maxEaseFactor);
        newRepetitions = 0;
        wasCorrect = false;

      case 'hard':
        if (currentRepetitions == 0) {
          newInterval = 3;
        } else {
          newInterval = (currentInterval * 1.2).round().clamp(1, maxInterval);
        }
        newEaseFactor = (currentEaseFactor - 0.15).clamp(minEaseFactor, maxEaseFactor);
        newRepetitions = currentRepetitions + 1;
        wasCorrect = true;

      case 'good':
        if (currentRepetitions == 0) {
          newInterval = 7;
        } else if (currentRepetitions == 1) {
          newInterval = (currentInterval * currentEaseFactor).round().clamp(1, maxInterval);
        } else {
          newInterval = (currentInterval * currentEaseFactor).round().clamp(1, maxInterval);
        }
        newEaseFactor = (currentEaseFactor + 0.1).clamp(minEaseFactor, maxEaseFactor);
        newRepetitions = currentRepetitions + 1;
        wasCorrect = true;

      case 'easy':
        if (currentRepetitions == 0) {
          newInterval = 15;
        } else if (currentRepetitions == 1) {
          newInterval = (currentInterval * currentEaseFactor * 1.5).round().clamp(1, maxInterval);
        } else {
          newInterval = (currentInterval * currentEaseFactor * 1.5).round().clamp(1, maxInterval);
        }
        newEaseFactor = (currentEaseFactor + 0.15).clamp(minEaseFactor, maxEaseFactor);
        newRepetitions = currentRepetitions + 1;
        wasCorrect = true;

      default:
        newInterval = 7;
        wasCorrect = true;
    }

    return SRSResult(
      newInterval: newInterval,
      newEaseFactor: newEaseFactor,
      newRepetitions: newRepetitions,
      wasCorrect: wasCorrect,
    );
  }

  Future<ReviewLog> applyToWord(Word word, String grade, ReviewLogRepository logRepo) async {
    final result = calculate(
      grade: grade,
      currentInterval: word.interval,
      currentEaseFactor: word.easeFactor,
      currentRepetitions: word.repetitions,
    );

    word.interval = result.newInterval;
    word.easeFactor = result.newEaseFactor;
    word.repetitions = result.newRepetitions;
    word.reviewCount += 1;
    word.lastReviewedAt = DateTime.now();
    word.nextReviewAt = DateTime.now().add(Duration(days: result.newInterval));

    if (result.wasCorrect) {
      word.successCount += 1;
      word.consecutiveCorrect += 1;
    } else {
      word.consecutiveCorrect = 0;
    }

    if (word.successRate > 0.8 && word.reviewCount >= 5) {
      word.isMastered = true;
    } else {
      word.isMastered = false;
    }

    if (word.consecutiveCorrect < 2 && word.reviewCount >= 3) {
      word.difficulty = 'Hard';
    } else if (word.consecutiveCorrect >= 5) {
      word.difficulty = 'Easy';
    } else {
      word.difficulty = 'Medium';
    }

    final log = ReviewLog.create(
      itemId: word.uuid,
      itemType: 'word',
      result: grade,
      interval: result.newInterval.toDouble(),
      easeFactor: result.newEaseFactor,
      repetitions: result.newRepetitions,
      wasCorrect: result.wasCorrect,
    );
    await logRepo.save(log);
    return log;
  }

  Future<ReviewLog> applyToVerb(Verb verb, String grade, ReviewLogRepository logRepo) async {
    final result = calculate(
      grade: grade,
      currentInterval: verb.interval,
      currentEaseFactor: verb.easeFactor,
      currentRepetitions: verb.repetitions,
    );

    verb.interval = result.newInterval;
    verb.easeFactor = result.newEaseFactor;
    verb.repetitions = result.newRepetitions;
    verb.reviewCount += 1;
    verb.lastReviewedAt = DateTime.now();
    verb.nextReviewAt = DateTime.now().add(Duration(days: result.newInterval));

    if (result.wasCorrect) {
      verb.successCount += 1;
      verb.consecutiveCorrect += 1;
    } else {
      verb.consecutiveCorrect = 0;
    }

    if (verb.consecutiveCorrect < 2 && verb.reviewCount >= 3) {
      verb.difficulty = 'Hard';
    } else if (verb.consecutiveCorrect >= 5) {
      verb.difficulty = 'Easy';
    } else {
      verb.difficulty = 'Medium';
    }

    final log = ReviewLog.create(
      itemId: verb.uuid,
      itemType: 'verb',
      result: grade,
      interval: result.newInterval.toDouble(),
      easeFactor: result.newEaseFactor,
      repetitions: result.newRepetitions,
      wasCorrect: result.wasCorrect,
    );
    await logRepo.save(log);
    return log;
  }
}
