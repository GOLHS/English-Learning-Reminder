class AppConstants {
  static const String appName = 'Vocab Trainer';
  static const String appTagline = 'Learn smarter, remember longer';
  static const String version = '1.0.0';

  static const int maxWordLength = 100;
  static const int maxExamples = 10;
  static const int maxVerbExamples = 5;
  static const int maxVerbFormLength = 50;

  static const int defaultReviewsPerWord = 2;
  static const int defaultMaxDailyReviews = 20;
  static const int defaultNotificationHour = 19;

  static const List<String> weekDays = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];

  static const List<String> categories = [
    'Travel', 'Business', 'Daily', 'Academic', 'Technology', 'Nature', 'Food', 'Health',
  ];

  static const List<String> verbPatternGroups = [
    'i-a-u (sing/sang/sung)',
    'i-a-u (begin/began/begun)',
    'o-e-en (speak/spoke/spoken)',
    'ee-e-ee (keep/kept/kept)',
    'd-t-t (build/built/built)',
    'no-change (put/put/put)',
    'ew-ewn (grew/grown)',
    'other',
  ];
}
