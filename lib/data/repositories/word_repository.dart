import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/word_model.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return WordRepository(isar);
});

class WordRepository {
  final IsarService _isarService;

  WordRepository(this._isarService);

  Isar get _db => _isarService.db;

  Future<List<Word>> getAll({bool includeArchived = false}) async {
    final query = _db.words.where();
    if (!includeArchived) {
      return query.filter().isArchivedEqualTo(false).findAll();
    }
    return query.findAll();
  }

  Future<Word?> getByUuid(String uuid) async {
    return _db.words.where().filter().uuidEqualTo(uuid).findFirst();
  }

  Future<Word?> getById(int id) async {
    return _db.words.get(id);
  }

  Future<List<Word>> getDueWords({int limit = 100}) async {
    final now = DateTime.now();
    return _db.words.where()
      .filter()
      .isArchivedEqualTo(false)
      .nextReviewAtIsNotNull()
      .nextReviewAtLessThan(now)
      .limit(limit)
      .findAll();
  }

  Future<List<Word>> getByCategory(String category) async {
    return _db.words.where().filter().categoryEqualTo(category).isArchivedEqualTo(false).findAll();
  }

  Future<List<Word>> getByDifficulty(String difficulty) async {
    return _db.words.where().filter().difficultyEqualTo(difficulty).isArchivedEqualTo(false).findAll();
  }

  Future<List<Word>> getMastered() async {
    return _db.words.where().filter().isMasteredEqualTo(true).isArchivedEqualTo(false).findAll();
  }

  Future<List<Word>> getArchived() async {
    return _db.words.where().filter().isArchivedEqualTo(true).findAll();
  }

  Future<List<Word>> getDifficult() async {
    return _db.words.where().filter().difficultyEqualTo('Hard').isArchivedEqualTo(false).findAll();
  }

  Future<List<Word>> getForgotten() async {
    return _db.words.where().filter().consecutiveCorrectLessThan(1).isArchivedEqualTo(false).findAll();
  }

  Future<int> getTotalCount() async {
    return _db.words.where().filter().isArchivedEqualTo(false).count();
  }

  Future<List<Word>> search(String query) async {
    if (query.isEmpty) return getAll();
    final q = query.toLowerCase();
    final all = await getAll();
    return all.where((w) =>
      w.word.toLowerCase().contains(q) ||
      w.meaning.toLowerCase().contains(q)
    ).toList();
  }

  Future<void> save(Word word) async {
    await _db.writeTxn(() => _db.words.put(word));
  }

  Future<void> saveAll(List<Word> words) async {
    await _db.writeTxn(() => _db.words.putAll(words));
  }

  Future<void> delete(Word word) async {
    await _db.writeTxn(() => _db.words.delete(word.id));
  }

  Future<void> deleteByUuid(String uuid) async {
    final word = await getByUuid(uuid);
    if (word != null) await delete(word);
  }

  Future<List<String>> getAllCategories() async {
    final words = await _db.words.where().filter().isArchivedEqualTo(false).findAll();
    return words.map((w) => w.category).where((c) => c != null && c.isNotEmpty).toSet().cast<String>().toList();
  }
}
