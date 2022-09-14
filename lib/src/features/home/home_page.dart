import 'package:flutter/material.dart';
import 'package:movie_app/src/features/movies/pages/billboard_page.dart';
import 'package:movie_app/src/features/movies/pages/boys_movies_page.dart';
import 'package:movie_app/src/features/movies/pages/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.movie_filter_outlined,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 10,),
            Text('Movies App',style: TextStyle(fontSize: 40)),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BillboardPage(),
                    ),
                  );
                },
                child: const Text('Billboard movies')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BoysMoviesPage(),
                    ),
                  );
                },
                child: const Text('Boys movies')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PopularMovies(),
                    ),
                  );
                },
                child: const Text('Popular movies')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchMoviesPage(),
                    ),
                  );
                },
                child: const Text('Search movies')),
          ],
        ),
      ),
    );
  }
}
