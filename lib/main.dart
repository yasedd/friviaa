import 'package:flutter/material.dart';
import 'package:friviaa/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
          fontFamily: 'RobotoMono',
          scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.9),
          primarySwatch: Colors.green),
      home: const StartPage(),
      // routes: {
      //   'Start Page': (context) => StartPage(),
      //   'Game Page': (context) => GamePage(),
      // },
    );
  }
}
