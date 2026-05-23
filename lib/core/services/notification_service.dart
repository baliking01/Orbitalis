import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:orbitalis/core/constants/notification_constants.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    await _createChannels();
  }

  Future<void> _createChannels() async {
    const flyover = AndroidNotificationChannel(
      NotificationConstants.flyoverChannelId,
      NotificationConstants.flyoverChannelName,
      importance: Importance.high,
    );
    const launches = AndroidNotificationChannel(
      NotificationConstants.launchChannelId,
      NotificationConstants.launchChannelName,
      importance: Importance.high,
    );

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(flyover);
    await androidPlugin?.createNotificationChannel(launches);
  }

  Future<void> showFlyoverAlert({
    required String satelliteName,
    required int elevationDeg,
  }) async {
    await _plugin.show(
      satelliteName.hashCode,
      'Satellite Overhead: $satelliteName',
      'Now visible at $elevationDeg° elevation. Look up!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationConstants.flyoverChannelId,
          NotificationConstants.flyoverChannelName,
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF00D4FF),
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleLaunchReminder({
    required int id,
    required String missionName,
    required DateTime launchTime,
    required Duration leadTime,
  }) async {
    final scheduleTime = launchTime.subtract(leadTime);
    if (scheduleTime.isBefore(DateTime.now())) return;

    await _plugin.zonedSchedule(
      id,
      'Launch in ${leadTime.inMinutes} minutes',
      missionName,
      tz.TZDateTime.from(scheduleTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationConstants.launchChannelId,
          NotificationConstants.launchChannelName,
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF0080FF),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return _plugin.pendingNotificationRequests();
  }
}
