import 'package:flutter/material.dart';
import 'package:movie_app/src/features/movies/movie_page_cubit.dart';
import 'package:movie_app/src/features/movies/pages/pages.dart';
import 'package:provider/provider.dart';

class BillboardPage extends StatelessWidget {
  const BillboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageState = context.read<MoviePageCubit>();
    return BasePage(
      title: 'Billboard',
      refresh: pageState.billboardMovies.refresh,
      bloc: pageState.billboardMovies,
    );
  }
}

