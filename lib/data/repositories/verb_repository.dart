import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/verb_model.dart';

final verbRepositoryProvider = Provider<VerbRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return VerbRepository(isar);
});

class VerbRepository {
  final IsarService _isarService;

  VerbRepository(this._isarService);

  Isar get _db => _isarService.db;

  Future<List<Verb>> getAll() async {
    return _db.verbs.where().findAll();
  }

  Future<Verb?> getByUuid(String uuid) async {
    return _db.verbs.where().filter().uuidEqualTo(uuid).findFirst();
  }

  Future<Verb?> getById(int id) async {
    return _db.verbs.get(id);
  }

  Future<List<Verb>> getDueVerbs({int limit = 100}) async {
    final now = DateTime.now();
    return _db.verbs.where()
      .filter()
      .nextReviewAtIsNotNull()
      .nextReviewAtLessThan(now)
      .limit(limit)
      .findAll();
  }

  Future<List<Verb>> getDifficult() async {
    final all = await _db.verbs.where().findAll();
    return all.where((v) => v.consecutiveCorrect < 2 && v.reviewCount >= 3).toList();
  }

  Future<List<Verb>> getMastered() async {
    return _db.verbs.where().filter().consecutiveCorrectGreaterThan(2).findAll();
  }

  Future<List<Verb>> getByPatternGroup(String group) async {
    return _db.verbs.where().filter().patternGroupEqualTo(group).findAll();
  }

  Future<List<String>> getAllPatternGroups() async {
    final verbs = await _db.verbs.where().findAll();
    return verbs.map((v) => v.patternGroup).where((g) => g != null && g.isNotEmpty).toSet().cast<String>().toList();
  }

  Future<int> getTotalCount() async {
    return _db.verbs.where().count();
  }

  Future<void> save(Verb verb) async {
    await _db.writeTxn(() => _db.verbs.put(verb));
  }

  Future<void> saveAll(List<Verb> verbs) async {
    await _db.writeTxn(() => _db.verbs.putAll(verbs));
  }

  Future<void> delete(Verb verb) async {
    await _db.writeTxn(() => _db.verbs.delete(verb.id));
  }

  Future<void> deleteByUuid(String uuid) async {
    final verb = await getByUuid(uuid);
    if (verb != null) await delete(verb);
  }
}
