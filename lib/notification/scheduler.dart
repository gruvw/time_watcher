import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:time_watcher/notification/notification.dart';

const int _timeBase = 60;
const int _timeoutFactor = 10;
const int _maxAlerts = 400;

Future<void> cancelNotifications() => AwesomeNotifications().cancelAll();

Future<int> scheduleNotifications({
  required int startingHour,
  required int endingHour,
  required int minutesDelay,
}) async {
  await cancelNotifications();

  String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  int id = 0;

  for (int minutes = startingHour * _timeBase;
      minutes <= endingHour * _timeBase;
      minutes += minutesDelay) {
    if (id >= _maxAlerts) {
      await cancelNotifications();
      return -1;
    }
    // print("$id -> ${minutes ~/ _minPerHour}:${minutes % _minPerHour}");
    await _scheduleDailyNotification(
      localTimeZone,
      id++,
      minutes ~/ _timeBase,
      minutes % _timeBase,
      minutesDelay / _timeoutFactor * _timeBase,
    );
  }

  return id;
}

Future<void> _scheduleDailyNotification(
  String timeZone,
  int id,
  int hour,
  int minute,
  double timeout,
) {
  String hourText = hour > 9 ? "$hour" : "0$hour";
  String minuteText = minute > 9 ? "$minute" : "0$minute";

  return AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelKey,
      title: "Time passes",
      body: "It is $hourText:$minuteText",
      notificationLayout: NotificationLayout.Default,
      timeoutAfter: Duration(seconds: timeout.toInt()),
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

Future<void> launchNotification(String text) {
  return AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: -1,
      channelKey: channelKey,
      title: "Time passes",
      body: text,
      notificationLayout: NotificationLayout.Default,
      timeoutAfter: const Duration(seconds: _timeBase),
    ),
  );
}
