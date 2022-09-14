import 'dart:async';

import 'package:async_data_bloc/async_data_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';
import 'package:movie_app/src/common/exceptions.dart';
import 'package:movie_app/src/common/extension.dart';
import 'package:movie_app/src/common/utils.dart';
import 'package:movie_app/src/features/movies/movie_repository.dart';

class MoviePageCubit {
  MoviePageCubit({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository {
    boysMovies = AsyncCubit(
      () => _movieRepository.listMovies(includeAdult: false, withGenres: '28').then(getOrThrow),
    );

    popularMovies = AsyncCubit(
      () => _movieRepository.listMovies(includeVideo: false).then(getOrThrow),
    );

    billboardMovies = AsyncCubit(
      () => _movieRepository.listBillboardMovies().then(getOrThrow),
    );

    moviesByQuery = AsyncCubit(
      () => lastQuery.isNullOrEmpty
          ? Future.value([])
          : _movieRepository
              .searchMovies(
                query: lastQuery,
              )
              .then(getOrThrow),
      initialValue: const AsyncValue.initial(),
    );
  }

  final MovieRepository _movieRepository;
  late final AsyncCubit<List<Movie>> boysMovies;
  late final AsyncCubit<List<Movie>> popularMovies;
  late final AsyncCubit<List<Movie>> billboardMovies;
  late final AsyncCubit<List<Movie>> moviesByQuery;

  String lastQuery = '';

  Future<void> searchMovies(String? query) async {
    if (query.isNullOrEmpty) {
      lastQuery = '';
      moviesByQuery.emit(const AsyncValue.initial());
    } else {
      //emit a loading state if there isn't one yet
      moviesByQuery.state.maybeWhen(
        orElse: () {
          moviesByQuery.emit(const AsyncValue.loading());
        },
        loading: (_) {},
      );

      lastQuery = query!;

      //this method will be called every time the value of the search text field changes
      //therefore is necessary to avoid incomplete and unnecessary requests.
      await Future<void>.delayed(const Duration(milliseconds: 300));

      if (lastQuery != query) {
        //there are a new query and the current query will be cancelled
        return;
      }

      await _movieRepository
          .searchMovies(
            query: lastQuery,
          )
          .then(getOrThrow)
          .then(
        (foundMovies) {
          if (lastQuery != query) {
            //there are a new query and the current query will be cancelled
            return;
          }

          moviesByQuery.emit(AsyncValue.data(foundMovies));
        },
        onError: (Object err, StackTrace stack) {
          if (lastQuery != query) {
            //there are a new query and the current query will be cancelled
            return;
          }

          moviesByQuery.emit(AsyncValue.error(err, stack));
        },
      );
    }
  }
}
