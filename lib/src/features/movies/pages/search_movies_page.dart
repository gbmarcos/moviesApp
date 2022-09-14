import 'package:flutter/material.dart';
import 'package:movie_app/src/common/widgets/custom_search_field.dart';
import 'package:movie_app/src/features/movies/movie_page_cubit.dart';
import 'package:movie_app/src/features/movies/pages/pages.dart';
import 'package:provider/provider.dart';

class SearchMoviesPage extends StatefulWidget {
  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {
  late final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pageState = context.read<MoviePageCubit>();
    return BasePage(
      appBarWidget: CustomSearchTextField(
        controller: controller..text= pageState.lastQuery,
        onChanged: pageState.searchMovies,
        hintText: 'Search',
      ),
      title: 'Search',
      refresh: pageState.moviesByQuery.refresh,
      bloc: pageState.moviesByQuery,
    );
  }
}
