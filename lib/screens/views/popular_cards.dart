import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_database/models/series_item.dart';
import 'package:tv_series_database/network/network_helper.dart';
import 'package:tv_series_database/screens/overview_page.dart';

class PopularCards extends StatefulWidget {
  const PopularCards({
    Key key,
  }) : super(key: key);

  @override
  _PopularCardsState createState() => _PopularCardsState();
}

class _PopularCardsState extends State<PopularCards> {
  bool isLoading = true;
  List<SeriesItem> _popularSeriesItem = new List<SeriesItem>();
  NetworkHelper _networkHelper = new NetworkHelper();
  String poster_base_url = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/';
  String backdrop_base_url = 'https://image.tmdb.org/t/p/original/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUpdate();
  }

  getDataUpdate() async {
    _popularSeriesItem = await _networkHelper.getPopularData();
    setState(() {
      if (_popularSeriesItem != null) {
        isLoading = false;
      } else {
        isLoading = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      height: 430,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _popularSeriesItem.length,
        itemBuilder: (context, int i) {
          return Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 8.0, top: 12, bottom: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                //todo: function go to popular item page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OverviewPage(
                        backdropUrl:
                            poster_base_url + _popularSeriesItem[i].posterUrl,
                        title: _popularSeriesItem[i].name,
                        overview: _popularSeriesItem[i].overview,
                        releaseDate: _popularSeriesItem[i].airDate,
                        rating: _popularSeriesItem[i].rating,
                        imgUrl: backdrop_base_url +
                            _popularSeriesItem[i].backdropUrl,
                        seriesID: _popularSeriesItem[i].id,
                      );
                    },
                  ),
                );
              },
              child: Stack(
                children: [
                  Ink(
                    width: 200,
                    height: 420,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  PopularCardTile(
                    poster_base_url: poster_base_url,
                    popularSeriesItem: _popularSeriesItem,
                    i: i,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PopularCardTile extends StatelessWidget {
  PopularCardTile({
    this.i,
    Key key,
    @required this.poster_base_url,
    @required List<SeriesItem> popularSeriesItem,
  })  : _popularSeriesItem = popularSeriesItem,
        super(key: key);

  final String poster_base_url;
  final List<SeriesItem> _popularSeriesItem;
  int i;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Column(
        children: [
          Ink(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                    '${poster_base_url}${_popularSeriesItem[i].posterUrl}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Ink(
            width: 200,
            height: 65,
            child: ListTile(
              title: Text(
                '${_popularSeriesItem[i].name}',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              subtitle: Text('Released on: ${_popularSeriesItem[i].airDate}'),
            ),
          ),
          Text(
            '${_popularSeriesItem[i].rating}/10',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }
}
