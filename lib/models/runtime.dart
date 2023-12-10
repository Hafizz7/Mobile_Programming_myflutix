class RunTime {
  final int id;
  final int? runtime;
  final double? rating;
  final List<String>? genre;
  final String? bahasa;
  final String? poster_path;
  final String? judul_film;

  RunTime({
    required this.id,
    this.runtime,
    this.rating,
    this.genre,
    this.bahasa,
    this.poster_path,
    this.judul_film,
  });

  factory RunTime.fromJson(Map<String, dynamic> json) {
    return RunTime(
      id: json['id'] as int,
      runtime: json['runtime'] as int?,
      bahasa: json['original_language'] as String?,
      poster_path: json['poster_path'] as String?,
      judul_film: json['title'] as String?,
      rating: json['vote_average'] as double?,
      genre: (json['genres'] as List<dynamic>?)
          ?.map((genre) => genre['name'] as String)
          .toList(), // Map the 'name' field from each genre object
          
    );
  }
}
