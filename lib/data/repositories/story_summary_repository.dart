import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/story_summary_model.dart';

final storySummaryRepositoryProvider = Provider<StorySummaryRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return StorySummaryRepository(isar);
});

class StorySummaryRepository {
  final IsarService _isarService;
  Isar get _db => _isarService.db;

  StorySummaryRepository(this._isarService);

  Future<List<StorySummary>> getByStory(String storyUuid) async {
    return _db.storySummarys.where().filter().storyUuidEqualTo(storyUuid).findAll();
  }

  Future<StorySummary?> getByStoryAndDate(String storyUuid, DateTime date) async {
    final day = DateTime(date.year, date.month, date.day);
    return _db.storySummarys.where()
      .filter()
      .storyUuidEqualTo(storyUuid)
      .summaryDateEqualTo(day)
      .findFirst();
  }

  Future<List<StorySummary>> getByDate(DateTime date) async {
    final day = DateTime(date.year, date.month, date.day);
    return _db.storySummarys.where().filter().summaryDateEqualTo(day).findAll();
  }

  Future<int> getCount() async {
    return _db.storySummarys.where().count();
  }

  Future<bool> hasWrittenToday() async {
    final today = DateTime.now();
    final day = DateTime(today.year, today.month, today.day);
    final count = await _db.storySummarys.where()
      .filter()
      .summaryDateEqualTo(day)
      .count();
    return count > 0;
  }

  Future<void> save(StorySummary summary) async {
    await _db.writeTxn(() => _db.storySummarys.put(summary));
  }

  Future<void> delete(StorySummary summary) async {
    await _db.writeTxn(() => _db.storySummarys.delete(summary.id));
  }
}
