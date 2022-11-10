import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:vibration/vibration.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // await Vibration.vibrate(pattern: [0, 1500]);
    await Future.delayed(
      const Duration(minutes: 2),
      () => AwesomeNotifications().dismiss(receivedNotification.id!),
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}
}
