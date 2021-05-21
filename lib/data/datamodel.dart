class Objects {
  String id;
  String director;
  String stars;
  String title;
  String language;
  String genre;
  int views;
  int votePeopleCount;
  int viewCount;
  String posterUrl;

  Objects(
    this.id,
    this.director,
    this.stars,
    this.title,
    this.language,
    this.genre,
    this.views,
    this.votePeopleCount,
    this.viewCount,
    this.posterUrl,
  );

  factory Objects.fromJson(Map<String, dynamic> json) {
    return Objects(
      json['_id'].toString(),
      json['director'][0].toString(),
      json['stars'].toString(),
      json['title'],
      json['language'],
      json['genre'],
      json['pageViews'],
      json['totalVoted'],
      json['viewCount'],
      json['poster'].toString(),
    );
  }

  void printer() {
    print("" + id + " " + director + " " + stars);
  }
}
