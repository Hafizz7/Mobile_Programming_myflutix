// movie_populer_list.dart

class Movie {
  final int id;
  final String original_language;
  final String original_title;
  final String? poster_path;
  final String overview;
  final bool video;
  final double vote_average;
  final int vote_count;
  final bool details;
  final DateTime? release_date;
  final int? runtime;

  Movie({
    required this.id,
    required this.original_language,
    required this.original_title,
    this.poster_path,
    required this.overview,
    required this.video,
    required this.vote_average,
    required this.vote_count,
    required this.runtime,
    required this.details,
    this.release_date,
    
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      poster_path: json['poster_path'],
      overview: json['overview'],
      video: json['video'] ?? false,
      vote_average: json['vote_average'].toDouble(),
      vote_count: json['vote_count'],
      runtime : json['runtime'],
      details: json['details'] ?? false,
      release_date: json['release_date'] != null
          ? DateTime.parse(json['release_date'])
          : null,
    );
  }
}
