


import '../../../../model/movie.dart';

abstract class RepoHome{

  Future<List<Movie>>  getTopRatedMovie();
  Future<List<Movie>>  getPopularMovie();

  // Future <Movie> getLatestMovie();

}