import 'dart:developer';

import 'package:async_data_bloc/async_data_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';
import 'package:movie_app/src/common/exceptions.dart';
import 'package:movie_app/src/common/widgets/exception_widget.dart';
import 'package:movie_app/src/features/movies/widgets/widgets.dart';

class BasePage extends StatefulWidget {
  const BasePage({
    Key? key,
    required this.title,
    required this.refresh,
    required this.bloc,
    this.appBarWidget,
  }) : super(key: key);

  final Widget? appBarWidget;
  final String title;
  final bool Function() refresh;
  final AsyncCubit<List<Movie>> bloc;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget.appBarWidget ?? Text(widget.title)),
      body: RefreshIndicator(
        onRefresh: () async {
          widget.refresh();
        },
        child: AsyncCubitBuilder<List<Movie>>(
          bloc: widget.bloc,
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              initial: (_) => const Center(
                child: Icon(
                  Icons.search,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              loading: (_) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              data: (asyncData) => MoviesList(movies: asyncData.value),
              error: (e) {
                final error = e.error;
                if (error is NetworkException) {
                  return error.map(
                    (value) => NetworkExceptionWidget(
                      refresh: widget.refresh,
                    ),
                    noDataException: (value) => NoElementsExceptionWidget(
                      text: 'No movies',
                      refresh: widget.refresh,
                    ),
                  );
                } else {
                  if (kReleaseMode) {
                    //send error to the error catching server
                  } else {
                    log('${e.stackTrace}');
                    log('${e.error}');
                  }
                  return UnexpectedExceptionWidget(
                    refresh: widget.refresh,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
