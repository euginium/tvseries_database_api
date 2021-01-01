class SeriesItemReviewModel {
  int id;
  dynamic rating;
  String author, content, postDate;
  SeriesItemReviewModel(
      {this.rating, this.id, this.content, this.author, this.postDate});
}
