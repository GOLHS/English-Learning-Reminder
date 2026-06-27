import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/word_model.dart';
import '../models/verb_model.dart';
import '../models/review_log_model.dart';
import '../models/user_preferences.dart';
import '../models/story_model.dart';
import '../models/story_summary_model.dart';

class IsarService {
  late Isar db;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open(
      [WordSchema, VerbSchema, ReviewLogSchema, UserPreferencesSchema, StorySchema, StorySummarySchema],
      directory: dir.path,
      inspector: false,
    );
  }

  Future<void> close() => db.close();
}

final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError('IsarService must be overridden in main()');
});
