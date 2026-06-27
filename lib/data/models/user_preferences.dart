import 'package:isar/isar.dart';

part 'user_preferences.g.dart';

@collection
class UserPreferences {
  Id id = Isar.autoIncrement;

  bool onboardingCompleted = false;
  String reviewIntensity = 'balanced';
  int reviewsPerWord = 2;
  String reviewPeriod = 'month';
  int maxDailyReviews = 20;

  bool notificationEnabled = true;
  int notificationHour = 19;
  int notificationMinute = 0;
  List<String> notificationDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int quietHoursStart = 22;
  int quietHoursEnd = 8;

  bool typingMode = false;
  bool showExamplesDuringRecall = true;
  String defaultVerbReviewMode = 'classic';
  bool autoPlayPronunciation = false;

  String themeMode = 'system';

  String aiProvider = 'openai';
  String aiApiKey = '';
  String aiModel = 'gpt-4o-mini';

  static UserPreferences get defaults => UserPreferences();
}
