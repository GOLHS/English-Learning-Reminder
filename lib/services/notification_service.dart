import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../data/models/user_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  NotificationService() : _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'review_reminder';

  Future<void> init() async {
    if (_initialized) return;
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _plugin.initialize(settings);
    _initialized = true;
  }

  Future<void> scheduleHourlyReview(UserPreferences prefs) async {
    await cancelAll();
    if (!prefs.notificationEnabled) return;

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      'Review Reminder',
      channelDescription: 'Hourly review reminders',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const details = NotificationDetails(android: androidDetails);

    await _plugin.periodicallyShow(
      0,
      'Review Reminder',
      'Time for a quick review!',
      RepeatInterval.hourly,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Future<bool> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.requestNotificationsPermission();
    }
    return true;
  }
}
