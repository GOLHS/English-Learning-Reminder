import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/review_log_model.dart';

final reviewLogRepositoryProvider = Provider<ReviewLogRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return ReviewLogRepository(isar);
});

class ReviewLogRepository {
  final IsarService _isarService;

  ReviewLogRepository(this._isarService);

  Isar get _db => _isarService.db;

  Future<void> save(ReviewLog log) async {
    await _db.writeTxn(() => _db.reviewLogs.put(log));
  }

  Future<List<ReviewLog>> getByItemId(String itemId) async {
    return _db.reviewLogs.where().filter().itemIdEqualTo(itemId).findAll();
  }

  Future<List<ReviewLog>> getRecent({int limit = 100}) async {
    return _db.reviewLogs.where().sortByReviewedAtDesc().limit(limit).findAll();
  }

  Future<List<ReviewLog>> getByDateRange(DateTime start, DateTime end) async {
    return _db.reviewLogs.where()
      .filter()
      .reviewedAtGreaterThan(start)
      .reviewedAtLessThan(end)
      .findAll();
  }

  Future<int> getTotalCount() async {
    return _db.reviewLogs.where().count();
  }

  Future<int> getTodayCount() async {
    final start = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final end = start.add(const Duration(days: 1));
    return _db.reviewLogs.where()
      .filter()
      .reviewedAtGreaterThan(start)
      .reviewedAtLessThan(end)
      .count();
  }

  Future<int> getCorrectTodayCount() async {
    final start = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final end = start.add(const Duration(days: 1));
    return _db.reviewLogs.where()
      .filter()
      .reviewedAtGreaterThan(start)
      .reviewedAtLessThan(end)
      .wasCorrectEqualTo(true)
      .count();
  }

  Future<Map<String, int>> getWeeklyCounts() async {
    final now = DateTime.now();
    final result = <String, int>{};
    for (int i = 6; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day - i);
      final next = date.add(const Duration(days: 1));
      final count = await _db.reviewLogs.where()
        .filter()
        .reviewedAtGreaterThan(date)
        .reviewedAtLessThan(next)
        .count();
      final weekday = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
      result[weekday] = count;
    }
    return result;
  }

  Future<void> deleteAll() async {
    await _db.writeTxn(() => _db.reviewLogs.clear());
  }
}
