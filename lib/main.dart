import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_watcher/notification/notification.dart';
import 'package:time_watcher/scheduler_form.dart';

const String box = "settings";

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<int>(box);

  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Watcher",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: SchedulerForm(),
      ),
    );
  }
}
