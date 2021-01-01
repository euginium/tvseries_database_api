import 'package:flutter/material.dart';
import 'main_page.dart';
import 'overview_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          children: [
            MainPage(),
            Scaffold(body: Ink(width: 500, height: 400, color: Colors.blue)),
            Scaffold(body: Ink(width: 500, height: 400, color: Colors.yellow)),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.blue,
          physics: ClampingScrollPhysics(),
          isScrollable: false,
          tabs: [
            Tab(
              child: Icon(Icons.home),
            ),
            Tab(
              child: Icon(Icons.favorite_border),
            ),
            Tab(
              child: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
