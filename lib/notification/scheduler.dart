import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:time_watcher/notification/notification.dart';

const int _minPerHour = 60;

Future<void> cancelNotifications() => AwesomeNotifications().cancelAll();

Future<int> scheduleNotifications({
  required int startingHour,
  required int endingHour,
  required int timesPerHour,
}) async {
  await cancelNotifications();

  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  int id = 0;

  int mIncr = _minPerHour ~/ timesPerHour;
  for (int h = startingHour; h <= endingHour; h++) {
    for (var m = 0; m < _minPerHour; m += mIncr) {
      await _scheduleDailyNotification(localTimeZone, id++, h, m);
    }
  }

  return id;
}

Future<void> _scheduleDailyNotification(
  String timeZone,
  int id,
  int hour,
  int minute,
) {
  String hourText = hour > 9 ? "$hour" : "0$hour";
  String minuteText = minute > 9 ? "$minute" : "0$minute";

  return AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelKey,
      title: "Time Passes",
      body: "It is $hourText:$minuteText",
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
