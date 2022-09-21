import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proj/features/home_screen/home_screen.dart';
import 'package:proj/utils/colors.dart';
import 'package:workmanager/workmanager.dart';

import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:proj/tsabih_notification.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future showNotification() async {
  int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);

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
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    rndmIndex,
    'فَذَكِّرْ',
    StaticVars().smallDo3a2[rndmIndex],
    platformChannelSpecifics,
  );
}

void callbackDispatcher() {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const IOSInitializationSettings();

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
    );
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/splash.svg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/islamicIconSplash.svg'),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'أذكار المسلم',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
