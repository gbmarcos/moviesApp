import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/r.dart';
import 'package:movie_app/src/app/app.dart';
import 'package:movie_app/src/common/domain/movie/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    const separator = SizedBox(height: 10);

    const style1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.45,
              child: CustomNetworkImage(movie: movie),
            ),
            separator,
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Resume:', style: style1),
                  separator,
                  Text(movie.overview ?? '-'),
                  separator,
                  Row(
                    children: [
                      const Text('Popularity:', style: style1),
                      const SizedBox(width: 10),
                      Text(movie.popularity?.toString() ?? '_'),
                    ],
                  ),
                  separator,
                  Row(
                    children: [
                      const Text('Votes:', style: style1),
                      const SizedBox(width: 10),
                      Text(movie.voteCount?.toString() ?? '_'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      R.endpoints.imagesBaseUrl + (movie.posterPath ?? movie.backdropPath ?? ''),
      errorBuilder: (context, error, stackTrace) {
        return const ColoredBox(
          color: Colors.white,
          child: Center(child: Icon(Icons.image_not_supported_outlined, size: 40)),
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
      loadingBuilder: (context, child, downloadProgress) {
        return Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            const ColoredBox(
              color: Colors.white,
              child: Center(
                child: Icon(Icons.image_outlined, size: 40),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: downloadProgress == null
                  ? SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: child,
                          ),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(),
                            ),
                          ),
                          child,
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        );
      },
      fit: BoxFit.cover,
    );
  }
}
