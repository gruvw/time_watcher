import 'package:flutter/material.dart';

import 'package:time_watcher/notification/notification.dart';
import 'package:time_watcher/notification/scheduler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();
  await scheduleNotifications(startingHour: 7, endingHour: 23, timesPerHour: 4);

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
