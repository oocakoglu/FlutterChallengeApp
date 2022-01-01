import 'package:flutter/material.dart';

import 'pages/mainpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RentReady",
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white70)),
    );
  }
}
