class SeriesItem {
  String name, overview, posterUrl, backdropUrl, airDate;
  dynamic rating;
  int id;

  SeriesItem(
      {this.rating,
      this.name,
      this.airDate,
      this.backdropUrl,
      this.overview,
      this.posterUrl,
      this.id});
}
