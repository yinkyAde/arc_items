import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Curved Arc Menu',
      theme: ThemeData(useMaterial3: true, fontFamily: 'SF Pro'),
      home: const HomePage(),
    );
  }
}
