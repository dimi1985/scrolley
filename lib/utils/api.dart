import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scrolley/models/movie.dart';

class Api {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const _apiKey = 'acfcd2d7f817516087ffd737459941c3';

  static Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1,2,3'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['results'];
      final List<Movie> fetchedMovies = [];

      for (final movieData in results) {
        fetchedMovies.add(Movie.fromJson(movieData));
      }

      return fetchedMovies;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<Video> fetchFirstMovieVideo(int movieId) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey&language=en-US'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['results'];

      if (results.isNotEmpty) {
        return Video.fromJson(results[0]);
      } else {
        throw Exception('No videos found for this movie');
      }
    } else {
      throw Exception('Failed to fetch movie videos');
    }
  }
}
