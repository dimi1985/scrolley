// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:scrolley/models/movie.dart';
import 'package:scrolley/screens/movie_poster.dart';
import 'package:scrolley/utils/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final List<Movie> fetchedMovies = await Api.fetchPopularMovies();

    setState(() {
      _movies = fetchedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      constraints: const BoxConstraints.expand(),
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];

          return MoviePoster(movie: movie);
        },
      ),
    );
  }
}
