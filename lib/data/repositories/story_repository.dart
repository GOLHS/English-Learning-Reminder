import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/story_model.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return StoryRepository(isar);
});

class StoryRepository {
  final IsarService _isarService;
  Isar get _db => _isarService.db;

  StoryRepository(this._isarService);

  Future<List<Story>> getAll({bool includeArchived = false}) async {
    if (includeArchived) return _db.storys.where().findAll();
    return _db.storys.where().filter().isArchivedEqualTo(false).findAll();
  }

  Future<Story?> getByUuid(String uuid) async {
    return _db.storys.where().filter().uuidEqualTo(uuid).findFirst();
  }

  Future<int> getCount() async {
    return _db.storys.where().filter().isArchivedEqualTo(false).count();
  }

  Future<Story?> getRandom() async {
    final stories = await _db.storys.where().filter().isArchivedEqualTo(false).findAll();
    if (stories.isEmpty) return null;
    stories.shuffle();
    return stories.first;
  }

  Future<Story?> getRandomExcludingPreloaded() async {
    final stories = await _db.storys.where().filter().isArchivedEqualTo(false).isPreloadedEqualTo(false).findAll();
    if (stories.isEmpty) return null;
    stories.shuffle();
    return stories.first;
  }

  Future<void> save(Story story) async {
    await _db.writeTxn(() => _db.storys.put(story));
  }

  Future<void> saveAll(List<Story> stories) async {
    await _db.writeTxn(() => _db.storys.putAll(stories));
  }

  Future<void> delete(Story story) async {
    await _db.writeTxn(() => _db.storys.delete(story.id));
  }

  Future<void> deleteByUuid(String uuid) async {
    final story = await getByUuid(uuid);
    if (story != null) await delete(story);
  }

  Future<void> markArchived(String uuid, bool archived) async {
    final story = await getByUuid(uuid);
    if (story != null) {
      story.isArchived = archived;
      await save(story);
    }
  }
}
