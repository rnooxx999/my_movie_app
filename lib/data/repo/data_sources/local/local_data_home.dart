

import '../../../../model/movie.dart';

abstract class LocalDataHome{

  saveTopRatedToLocalSql(movieJson);
  Future <List<Movie>> getTopRatedMovie();


  savePopularToLocalSql(movieJson);
  Future <List<Movie>> getPopularMovie();
// Future <Movie> getTopRatedMovie();
// Future <Movie> getLatestMovie();
}