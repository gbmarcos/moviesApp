import 'package:flutter/material.dart';
import 'package:movie_app/src/features/movies/movie_page_cubit.dart';
import 'package:movie_app/src/features/movies/pages/pages.dart';
import 'package:provider/provider.dart';

class BoysMoviesPage extends StatelessWidget {
  const BoysMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageState = context.read<MoviePageCubit>();
    return BasePage(
      title: 'Boys Movies',
      refresh: pageState.boysMovies.refresh,
      bloc: pageState.boysMovies,
    );
  }
}
