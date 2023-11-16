import 'package:driver_management/login/login_screen.dart';
import 'package:driver_management/services/cache_helper.dart';
import 'package:driver_management/services/dio_helper.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  sl<DioHelper>().init();
  sl<CacheHelper>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const LoginScreen(),
    );
  }
}
