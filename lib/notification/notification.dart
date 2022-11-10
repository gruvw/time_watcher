import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

import 'package:time_watcher/notification/controller.dart';

const String channelKey = "time_passes";

Future<void> initializeNotifications() async {
  await AwesomeNotifications().initialize(
    "resource://drawable/notification",
    [
      NotificationChannel(
        channelKey: channelKey,
        channelName: "Time Passes",
        channelDescription: "Time Watcher's scheduled notifications",
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

  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications(
        channelKey: channelKey,
        permissions: NotificationPermission.values,
      );
    }
  });
}
