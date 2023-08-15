import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_presenter_app/Routes/routes.dart';
import 'package:news_presenter_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: getPages,
      initialRoute: Routes.splashScreen,
    );
  }
}
