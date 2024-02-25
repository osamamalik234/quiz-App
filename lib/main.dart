import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/get_started.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStarted(),
    );
  }
}
