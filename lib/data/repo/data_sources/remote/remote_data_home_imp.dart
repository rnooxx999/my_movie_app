


import 'package:movies_app/data/repo/data_sources/remote/remote_data_home.dart';
import 'package:movies_app/model/movie.dart';

import '../../../api/api_home.dart';

class RemoteDataHomeIMPL implements RemoteDataHome {
  @override
  Future<List<Movie>> getTopRatedRemoteMovie() {
    return ApiHome.getListTopRatedMovies();
  }

  @override
  Future<List<Movie>> getPupolarRemoteMovie() {
    return ApiHome.gePopularMovies();
  }
}