// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/features/home/home_page.dart';
import 'package:movie_app/src/features/movies/movie_page_cubit.dart';
import 'package:movie_app/src/features/movies/movie_repository.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key, required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  final MovieRepository _movieRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MoviePageCubit(movieRepository: _movieRepository),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
