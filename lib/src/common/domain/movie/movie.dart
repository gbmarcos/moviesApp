import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

List<Movie> moviesFromJson(List<dynamic> str) =>
    List<Movie>.from(str.map<Movie>((dynamic x) => Movie.fromJson(x as Map<String, dynamic>)));


@JsonSerializable()
class Movie {
  Movie({
     this.backdropPath,
     this.id,
     this.overview,
     this.popularity,
     this.posterPath,
     this.title,
     this.voteCount,
  });

  int? id;
  String? title;
  String? overview;
  String? posterPath;
  String? backdropPath;
  double? popularity;
  int? voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
