import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String channelKey = 'time_passes';

Future<void> _scheduleDailyNotification(
    String timeZone, int id, int hour, int minute) {
  return AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelKey,
      title: 'Time Passes!',
      body: 'It is $hour:$minute',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      hour: hour,
      minute: minute,
      second: 0,
      timeZone: timeZone,
      preciseAlarm: true,
      repeats: true,
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: channelKey,
        channelName: 'Time Passes',
        channelDescription: 'Time Passes Description',
        playSound: true,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 2000]),
      )
    ],
  );

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications(
        channelKey: channelKey,
        permissions: NotificationPermission.values,
      );
    }
  });

  await AwesomeNotifications().cancelAll();

  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  int id = 0;

  int startH = 7;
  int endH = 23;
  int mIncr = 15;
  for (var hour = startH; hour <= endH; hour++) {
    for (var minute = 0; minute < 60; minute += mIncr) {
      await _scheduleDailyNotification(localTimeZone, id++, hour, minute);
    }
  }

  print("done $id");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(),
    );
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    await Future.delayed(
      const Duration(seconds: 5),
      () => AwesomeNotifications().dismiss(receivedNotification.id!),
    );
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }
}
