import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/user_preferences.dart';

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return PreferencesRepository(isar);
});

class PreferencesRepository {
  final IsarService _isarService;
  UserPreferences? _cached;

  PreferencesRepository(this._isarService);

  Isar get _db => _isarService.db;

  Future<UserPreferences> get() async {
    if (_cached != null) return _cached!;
    final prefs = await _db.userPreferences.where().findFirst();
    _cached = prefs ?? UserPreferences.defaults;
    if (prefs == null) {
      await save(_cached!);
    }
    return _cached!;
  }

  Future<void> save(UserPreferences prefs) async {
    await _db.writeTxn(() => _db.userPreferences.put(prefs));
    _cached = prefs;
  }

  Future<bool> isOnboardingCompleted() async {
    final p = await get();
    return p.onboardingCompleted;
  }

  Future<void> completeOnboarding() async {
    final p = await get();
    p.onboardingCompleted = true;
    await save(p);
  }
}
