import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';
import 'package:movie_app/src/common/exceptions.dart';

extension E<X extends Object?> on X {
  bool get isNullOrEmptyList {
    final isEmptyList = this is List<dynamic> && (this as List<dynamic>?)!.isEmpty;
    return this == null || isEmptyList;
  }
}

extension EitherX on Either<NetworkException, dynamic> {
  Either<NetworkException, List<Movie>> get parsedMovies {
    return fold(
      Either.left,
      (data) {
        final maybeList = data['results'];

        if (maybeList is List<dynamic> && maybeList.isNotEmpty) {
          return Either.right(moviesFromJson(maybeList));
        }

        return Either.left(const NetworkException.noDataException());
      },
    );
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension StringX on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
