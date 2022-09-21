
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:proj/tsabih_notification.dart';
import 'package:workmanager/workmanager.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future showNotification() async {

  int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length-1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    '$rndmIndex.0',
    'تطبيق أذكار المسلم',
    channelDescription: 'تطبيق أذكار المسلم',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );

  await flutterLocalNotificationsPlugin.show(
    rndmIndex,
    'فَذَكِّرْ',
    StaticVars().smallDo3a2[rndmIndex],
    platformChannelSpecifics,
  );

}

void callbackDispatcher() {

  // initial notifications
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );


  Workmanager().executeTask((task, inputData) {
    showNotification();
    return Future.value(true);
  });
}
