// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:movie_app/bootstrap.dart';
import 'package:movie_app/src/app/app.dart';
import 'package:movie_app/src/common/data/network_service.dart';
import 'package:movie_app/src/features/movies/movie_repository.dart';

void main() {
  bootstrap(
    () => App(
      movieRepository: MovieRepository(client: NetworkService()),
    ),
  );
}
