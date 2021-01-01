import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_database/models/series_item.dart';
import 'package:tv_series_database/network/network_helper.dart';

import '../overview_page.dart';

class TodayCards extends StatefulWidget {
  @override
  _TodayCardsState createState() => _TodayCardsState();
}

class _TodayCardsState extends State<TodayCards> {
  bool isLoading = true;
  List<SeriesItem> _seriesItem = new List<SeriesItem>();
  NetworkHelper _networkHelper = new NetworkHelper();
  String backdrop_base_url = 'https://image.tmdb.org/t/p/original/';
  String poster_base_url = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUpdate();
  }

  getDataUpdate() async {
    _seriesItem = await _networkHelper.getAirTodayData();
    setState(() {
      if (_seriesItem != null) {
        isLoading = false;
      } else {
        isLoading = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ink(
        color: Colors.transparent,
        width: double.infinity,
        height: 300,
        child: PageView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          itemCount: _seriesItem.length,
          itemBuilder: (context, int i) {
            return isLoading
                ? LinearProgressIndicator()
                : TodayCardTile(
                    backdrop_base_url: backdrop_base_url,
                    seriesItem: _seriesItem,
                    poster_base_url: poster_base_url,
                    i: i,
                  );
          },
        ),
      ),
    );
  }
}

class TodayCardTile extends StatelessWidget {
  const TodayCardTile({
    this.poster_base_url,
    this.i,
    Key key,
    @required this.backdrop_base_url,
    @required List<SeriesItem> seriesItem,
  })  : _seriesItem = seriesItem,
        super(key: key);

  final String backdrop_base_url;
  final List<SeriesItem> _seriesItem;
  final String poster_base_url;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          //todo: go to ItemPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OverviewPage(
                  backdropUrl: poster_base_url + _seriesItem[i].posterUrl,
                  title: _seriesItem[i].name,
                  overview: _seriesItem[i].overview,
                  releaseDate: _seriesItem[i].airDate,
                  rating: _seriesItem[i].rating,
                  imgUrl: backdrop_base_url + _seriesItem[i].backdropUrl,
                  seriesID: _seriesItem[i].id,
                );
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            BackropImage(
              backdrop_base_url: backdrop_base_url,
              seriesItem: _seriesItem,
              i: i,
            ),
            CardDetails(
              seriesItem: _seriesItem,
              i: i,
            ),
          ],
        ),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  const CardDetails({
    this.i,
    Key key,
    @required List<SeriesItem> seriesItem,
  })  : _seriesItem = seriesItem,
        super(key: key);

  final List<SeriesItem> _seriesItem;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Ink(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: Colors.black.withOpacity(0.65),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 16, right: 10),
            child: ListTile(
              title: Text(
                '${_seriesItem[i].name}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              subtitle: Text('Released on: ${_seriesItem[i].airDate}'),
              trailing: Text(
                '${_seriesItem[i].rating}/10',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackropImage extends StatelessWidget {
  const BackropImage({
    this.i,
    Key key,
    @required this.backdrop_base_url,
    @required List<SeriesItem> seriesItem,
  })  : _seriesItem = seriesItem,
        super(key: key);

  final String backdrop_base_url;
  final List<SeriesItem> _seriesItem;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image:
              NetworkImage('${backdrop_base_url}${_seriesItem[i].backdropUrl}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
