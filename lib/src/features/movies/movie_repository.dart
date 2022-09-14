import 'package:fpdart/fpdart.dart';
import 'package:movie_app/src/common/data/network_service.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';
import 'package:movie_app/src/common/exceptions.dart';
import 'package:movie_app/src/common/extension.dart';

class MovieRepository {
  final NetworkService _client;

  MovieRepository({required NetworkService client}) : _client = client;

  /// An collection of movies.
  /// 	- [sortBy] (string)
  /// 		- Choose from one of the many available sort options.
  ///   - [includeAdult] (bool)
  ///     - A filter and include or exclude adult movies.
  ///   - [includeVideo] (bool)
  ///     - A filter to include or exclude videos.
  ///   - [page] (int)
  ///     - Specify the page of results to query.
  ///   - [withGenres] (int)
  ///     - Comma separated value of genre ids that you want to include in the results.

  Future<Either<NetworkException, List<Movie>>> listMovies({
    String sortBy = 'popularity.asc',
    String? withGenres,
    bool? includeAdult,
    bool? includeVideo,
    int page = 1,
  }) async {
    final data = {
      'sort_by': sortBy,
      'page': page,
      if (includeAdult != null) 'include_adult': includeAdult,
      if (includeVideo != null) 'include_video': includeVideo,
      if (withGenres != null) 'with_genres': withGenres,
    };

    final response = await _client.get('/discover/movie', query: data);

    return response.map<List<Movie>>((dynamic a) => moviesFromJson(a['results'] as List<dynamic>));
  }

  /// An collection of billboard movies.
  ///   - [page] (int)
  ///     - Specify the page of results to query.

  Future<Either<NetworkException, List<Movie>>> listBillboardMovies({
    int page = 1,
  }) async {
    final data = {
      'page': page,
    };

    final response = await _client.get('/trending/movie/week', query: data);

    return response.parsedMovies;
  }

  /// An collection of movies by a query.
  /// 	- [query] (string)
  /// 		- Pass a text query to search. This value should be URI encoded.
  ///   - [page] (int)
  ///     - Specify the page of results to query.

  Future<Either<NetworkException, List<Movie>>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    final data = {
      'query': query,
      'page': page,
    };

    final response = await _client.get('/search/movie', query: data);

    return response.parsedMovies;
  }
}
