import 'package:flutter/material.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/presentation_main_app/screen/main_screen.dart';

void main() async {
  ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Colors.grey.shade900),
      home: const MainScreen(),
    );
  }
}
