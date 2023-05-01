class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<Video> videos;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.videos,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<Video> videos = [];
    if (json['videos'] != null) {
      for (var video in json['videos']['results']) {
        videos.add(Video.fromJson(video));
      }
    }

    return Movie(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      videos: videos,
    );
  }

  Movie copyWith({
    List<Video>? videos,
  }) {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      videos: videos ?? this.videos,
    );
  }
}

class Video {
  final String id;
  final String key;
  final String name;
  final String type;

  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.type,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      type: json['type'],
    );
  }
}
