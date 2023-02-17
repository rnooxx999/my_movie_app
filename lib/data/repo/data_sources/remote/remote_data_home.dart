
import '../../../../model/movie.dart';

abstract class RemoteDataHome{

  Future <List<Movie>> getTopRatedRemoteMovie();
  Future <List<Movie>> getPupolarRemoteMovie();
  // Future <Movie> getLatestMovie();

}