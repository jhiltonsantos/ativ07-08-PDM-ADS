import 'package:flutter/material.dart';

import 'src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.white),
          )),
      home: const HomePage(),
    );
  }
}
