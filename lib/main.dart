import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maily/screens/dashboard.dart';
import 'package:maily/screens/new_page.dart';

import 'package:maily/screens/utils.dart';
import 'package:maily/screens/utils.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/utils.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeNotifications();

  runApp(const Maily_App());
}

class Maily_App extends StatefulWidget {
  const Maily_App({super.key});

  @override
  State<Maily_App> createState() => _Maily_AppState();
}

class _Maily_AppState extends State<Maily_App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

Future<void> initializeNotifications() async {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    // Handle notification tapped logic here
  });
}

Future<void> showNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: null);
}

void startTimer() {
  int previousLength = 0;
  Timer? timer;
  final ref2 = FirebaseDatabase.instance.ref('mails');
  const duration = Duration(seconds: 1);

  timer = Timer.periodic(duration, (Timer t) {
    ref2.get().then((snap) {
      Map<dynamic, dynamic> map = snap.value as dynamic;
      List<dynamic> list2 = [];
      list2.clear();
      list2 = map.values.toList();
      if (list2.length > previousLength) {
        // Show notification if new data is available
        showNotification('New Mail', 'You have received a new mail.');
        print("new mail");
      }
      previousLength = list2.length;
    });
  });
}