class Casttt {
  final int id;
  final String? name;
  final String? original_name;
  final String? profile_path;
  final int? runtime;
  final String? poster_path;
  final int? order;

  Casttt({
    required this.id,
    this.name,
    this.original_name,
    this.profile_path,
    this.runtime,
    this.poster_path,
    this.order,
  });

  factory Casttt.fromJson(Map<String, dynamic> json) {
    return Casttt(
      id: json['id'] as int,
      name: json['name'] as String?,
      original_name: json['original_name'] as String?,
      profile_path: json['profile_path'] as String?,
      runtime: json['runtime'] as int?,
      poster_path: json['poster_path'] as String?,
      order: json['order'] as int?,
    );
  }
}
