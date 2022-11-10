import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_watcher/notification/notification.dart';
import 'package:time_watcher/scheduler_form.dart';

const String box = "settings";
const Color accentColor = Color(0xFF0BA6F3);

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<int>(box);

  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Time Watcher",
      home: Scaffold(
        body: SchedulerForm(),
        backgroundColor: Color(0xFF343A40),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
