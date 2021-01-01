import 'package:flutter/material.dart';
import 'package:tv_series_database/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff181818),
        accentColor: Colors.blue,
        splashColor: Colors.blueGrey.withOpacity(0.5),
        highlightColor: Colors.black.withOpacity(0.7),
      ),
      home: HomePage(),
    );
  }
}
