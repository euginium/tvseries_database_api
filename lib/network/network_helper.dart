import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tv_series_database/models/series_item.dart';
import 'package:tv_series_database/models/series_item_review_model.dart';

class NetworkHelper {
  final String base_url = 'https://api.themoviedb.org/3/tv/';
  final String poster_base_url =
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2/';
  final String backdrop_base_url = 'https://image.tmdb.org/t/p/original/';
  final String api_key = 'api_key=95574f875579c314901433e5c666778c';

  List<SeriesItem> todaySeriesItem = [];
  List<SeriesItem> popularSeriesItem = [];
  List<SeriesItemReviewModel> reviewItems = [];

  // get airing today's data
  getAirTodayData() async {
    http.Response response = await http
        .get('${base_url}airing_today?${api_key}&language=en-US&page=1');
    var result = response.body;
    var decoded = jsonDecode(result);
    for (var elements in decoded['results']) {
      SeriesItem sI = new SeriesItem(
        name: elements['name'],
        posterUrl: elements['poster_path'],
        backdropUrl: elements['backdrop_path'],
        airDate: elements['first_air_date'].toString(),
        overview: elements['overview'],
        rating: elements['vote_average'].toString(),
        id: elements['id'],
      );
      todaySeriesItem.add(sI);
    }
    return todaySeriesItem;
  }

  // get popular series data
  getPopularData() async {
    http.Response response =
        await http.get('${base_url}popular?${api_key}&language=en-US&page=1');
    var result = response.body;
    var decoded = jsonDecode(result);
    for (var elements in decoded['results']) {
      SeriesItem sI = new SeriesItem(
        name: elements['name'],
        posterUrl: elements['poster_path'],
        backdropUrl: elements['backdrop_path'],
        airDate: elements['first_air_date'].toString(),
        overview: elements['overview'],
        rating: elements['vote_average'].toString(),
        id: elements['id'],
      );
      popularSeriesItem.add(sI);
    }
    return popularSeriesItem;
  }

  // get review data from series ID
  Future<List<SeriesItemReviewModel>> getReview(int seriesID) async {
    String _seriesId = seriesID.toString();
    try {
      http.Response response = await http.get(
          '${base_url}${_seriesId.toString()}/reviews?${api_key}&language=en-US&page=1');
      var result = response.body;
      var decoded = jsonDecode(result);
      for (var elements in decoded['results']) {
        if (elements['author_details']['rating'] != null) {
          SeriesItemReviewModel seriesItemReviewModel =
              new SeriesItemReviewModel(
            author: elements['author'],
            rating: elements['author_details']['rating'],
            content: elements['content'],
            postDate: elements['updated_at'],
          );
          reviewItems.add(seriesItemReviewModel);
          print(reviewItems.length);
          return reviewItems;
        }
      }
    } catch (e) {
      print(e);
      print('an error occurred');
    }
  }
}
