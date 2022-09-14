import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';
import 'package:movie_app/src/features/movies/widgets/widgets.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {


    return AnimationLimiter(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          var movie = movies[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: MovieCard(movie: movie),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      ),
    );
  }
}