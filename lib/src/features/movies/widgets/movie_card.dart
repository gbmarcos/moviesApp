import 'package:flutter/material.dart';
import 'package:movie_app/r.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';
import 'package:movie_app/src/features/movies/pages/movie_details_page.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return InkWell(
      borderRadius: borderRadius,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  MovieDetailsPage(
              movie: movie,
            ),
          ),
        );
      },
      child: Card(
        elevation: 10,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: ColoredBox(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    R.endpoints.imagesBaseUrl + (movie.posterPath??movie.backdropPath?? ''),
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child:
                        const Center(child: Icon(Icons.image_not_supported_outlined, size: 40)),
                      );
                    },
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
                    loadingBuilder: (context, child, downloadProgress) {
                      return Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(minHeight: 200),
                            color: Colors.white,
                            child: const Center(
                              child: Icon(Icons.image_outlined, size: 40),
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: downloadProgress == null ? child : const SizedBox.shrink(),
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(movie.title ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}