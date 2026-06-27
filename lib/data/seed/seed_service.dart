import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/story_model.dart';
import '../models/verb_model.dart';
import '../models/user_preferences.dart';
import 'irregular_verbs.dart';
import 'story_seed.dart';

class SeedService {
  final IsarService _isarService;

  SeedService(this._isarService);

  Future<void> seedIfEmpty() async {
    await _seedVerbs();
    await _seedStories();
    await _seedAiConfig();
  }

  Future<void> _seedAiConfig() async {
    final prefs = await _isarService.db.userPreferences.where().findFirst();
    if (prefs != null && (prefs.aiApiKey?.isNotEmpty == true)) return;
    final p = prefs ?? UserPreferences();
    p.aiProvider = 'gemini';
    p.aiModel = 'gemini-2.0-flash';
    p.aiApiKey = 'AIzaSyAb8RN6JBnnaVfqL77b_etvkm50T1hY3cpF6Bh_-MiE_kBJ41wg';
    await _isarService.db.writeTxn(() => _isarService.db.userPreferences.put(p));
  }

  Future<void> _seedVerbs() async {
    final count = await _isarService.db.verbs.where().count();
    if (count > 0) return;
    final verbs = VerbSeed.all.map((s) => s.toVerb()).toList();
    for (final v in verbs) {
      v.nextReviewAt = DateTime.now();
    }
    await _isarService.db.writeTxn(() => _isarService.db.verbs.putAll(verbs));
  }

  Future<void> _seedStories() async {
    final count = await _isarService.db.storys.where().count();
    if (count > 0) return;
    final stories = StorySeed.preloaded.map((s) => Story.create(
      title: s.title,
      text: s.text,
      isPreloaded: true,
    )).toList();
    await _isarService.db.writeTxn(() => _isarService.db.storys.putAll(stories));
  }
}
