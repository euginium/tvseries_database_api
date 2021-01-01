import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_database/models/series_item.dart';
import 'package:tv_series_database/screens/views/review_dart.dart';

class OverviewPage extends StatelessWidget {
  String backdropUrl, title, overview, releaseDate, imgUrl;
  int seriesID, seriesRating;
  String author, reviewContent, reviewDate;
  dynamic rating;

  OverviewPage(
      {this.backdropUrl,
      this.title,
      this.overview,
      this.releaseDate,
      this.rating,
      this.imgUrl,
      this.seriesID,
      this.author,
      this.reviewContent,
      this.reviewDate,
      this.seriesRating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 1000,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${backdropUrl}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1000,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
              ),
            ),
            //details
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    // Series Details
                    SeriesDetailsTile(
                        title: title,
                        overview: overview,
                        releaseDate: releaseDate,
                        rating: rating),
                    SizedBox(
                      height: 20,
                    ),
                    //Reviews
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: _buildText(
                          'Reviews', FontWeight.w800, 28, Colors.white),
                    ),
                    ReviewCardTile(seriesID: seriesID),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SeriesDetailsTile extends StatelessWidget {
  const SeriesDetailsTile({
    Key key,
    @required this.title,
    @required this.overview,
    @required this.releaseDate,
    @required this.rating,
  }) : super(key: key);

  final String title;
  final String overview;
  final String releaseDate;
  final dynamic rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildText(title, FontWeight.w700, 37, Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildText(overview, FontWeight.w300, 18, Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildText("Released on : $releaseDate", FontWeight.w500, 20,
                    Colors.white),
                _buildText(
                    '$rating / 10', FontWeight.w700, 20, Colors.orangeAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildText(String text, FontWeight weight, double size, Color color) {
  return Text(
    '${text}',
    style: TextStyle(
      fontWeight: weight,
      fontSize: size,
      color: color,
    ),
  );
}

Widget _buildDivider() {
  return Divider(
    indent: 8.0,
    endIndent: 8.0,
    thickness: 0.8,
    color: Colors.white,
  );
}
