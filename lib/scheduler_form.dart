// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_watcher/main.dart';
import 'package:time_watcher/notification/scheduler.dart';
import 'package:time_watcher/number_picker.dart';

class SchedulerForm extends StatelessWidget {
  static const minHour = 0;
  static const maxHour = 24;
  static const minDelay = 1;
  static const maxDelay = 60;

  static const startingHourName = "Starting hour";
  static const defaultStartingHour = 7;
  static const endingHourName = "Ending hour";
  static const defaultEndingHour = 23;
  static const minutesDelay = "Minutes delay";
  static const defaultDelay = 15;

  const SchedulerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: DBNumberPicker(
              name: startingHourName,
              defaultValue: defaultStartingHour,
              min: minHour,
              max: maxHour,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: DBNumberPicker(
              name: endingHourName,
              defaultValue: defaultEndingHour,
              min: minHour,
              max: maxHour,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: DBNumberPicker(
              name: minutesDelay,
              defaultValue: defaultDelay,
              min: minDelay,
              max: maxDelay,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(accentColor),
              ),
              onPressed: () async {
                int n = await scheduleNotifications(
                  startingHour: Hive.box<int>(box).get(startingHourName) ?? defaultStartingHour,
                  endingHour: Hive.box<int>(box).get(endingHourName) ?? defaultEndingHour,
                  minutesDelay: Hive.box<int>(box).get(minutesDelay) ?? defaultDelay,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    n >= 0
                        ? "Scheduled $n daily notifications."
                        : "You tried to schedule too many notifications.",
                  )),
                );
              },
              child: const Text("Launch schedule!"),
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(accentColor),
            ),
            onPressed: () async {
              await cancelNotifications();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Canceled every notifications.")),
              );
            },
            child: const Text("Cancel schedule"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 00),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(accentColor),
              ),
              onPressed: () async {
                await launchNotification("Test Notification");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Test Notification sent!")),
                );
              },
              child: const Text("Test notification"),
            ),
          ),
        ],
      ),
    );
  }
}
