import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/cubit/counter_cubit.dart';
import 'package:proj/features/home_screen/cubit/details_cubit.dart';
import 'package:proj/features/splash_screen/SplashScreen.dart';

void main() {
  // runApp( DevicePreview(builder:((context) =>  MyApp())));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            titleTextStyle: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 22,
            ),
            elevation: 0.0,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

