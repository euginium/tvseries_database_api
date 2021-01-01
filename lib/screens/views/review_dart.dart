import 'package:flutter/material.dart';
import 'package:tv_series_database/models/series_item_review_model.dart';
import 'package:tv_series_database/network/network_helper.dart';

class ReviewCardTile extends StatefulWidget {
  int seriesID;

  ReviewCardTile({this.seriesID});

  @override
  _ReviewCardTileState createState() => _ReviewCardTileState();
}

class _ReviewCardTileState extends State<ReviewCardTile> {
  bool isLoading = true;
  List<SeriesItemReviewModel> _reviewItems = new List<SeriesItemReviewModel>();
  NetworkHelper _networkHelper = new NetworkHelper();

  getReviewData(int seriesID) async {
    try {
      _reviewItems = await _networkHelper.getReview(seriesID);
      print(seriesID);
      setState(() {
        if (_reviewItems != null) {
          isLoading = false;
        } else {
          isLoading = true;
          print('no reviews reported');
        }
      });
      return _reviewItems;
    } catch (e) {
      print(e);
      print('second error occurred');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviewData(widget.seriesID);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LinearProgressIndicator()
        : ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _reviewItems.length,
            itemBuilder: (context, int i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDivider(),
                  ListTile(
                    title: _buildText('${_reviewItems[i].author}',
                        FontWeight.w700, 19, Colors.white),
                    subtitle: _buildText(
                        'posted on: ${_reviewItems[i].postDate}',
                        FontWeight.w300,
                        14,
                        Colors.white),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade900,
                      child: Icon(Icons.person),
                    ),
                    trailing: _buildText('${_reviewItems[i].rating}/10',
                        FontWeight.w700, 20, Colors.greenAccent),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: _buildText('${_reviewItems[i].content}',
                          FontWeight.w400, 17, Colors.white),
                    ),
                  ),
                ],
              );
            },
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

  Widget _buildText(String text, FontWeight weight, double size, Color color) {
    return Text(
      '${text}',
      style: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: color,
      ),
      softWrap: true,
    );
  }
}
