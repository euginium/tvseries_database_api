import 'package:flutter/material.dart';
import 'package:tv_series_database/screens/views/popular_cards.dart';
import 'package:tv_series_database/screens/views/today_cards.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText('New Episodes today'),
              //Airing Today card list
              TodayCards(),
              _buildText('Popular'),
              //popular tv series list
              PopularCards(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildText(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 20.0, top: 16),
    child: Text(
      '$text',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
  );
}
