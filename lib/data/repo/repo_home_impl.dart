import 'package:connectivity/connectivity.dart';
import 'package:movies_app/data/repo/repo_home.dart';
import 'package:movies_app/model/movie.dart';

import 'data_sources/local/local_data_home.dart';
import 'data_sources/remote/remote_data_home.dart';

class RepoHomeImpl implements RepoHome {
  LocalDataHome localDataHome;
  RemoteDataHome remoteDataHome;

  RepoHomeImpl(this.localDataHome, this.remoteDataHome);

  @override
  Future<List<Movie>> getTopRatedMovie() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      List<Movie> responce = await remoteDataHome.getTopRatedRemoteMovie();

      //catch data & add it to local sql just when app start
      if (responce != null && responce != null && responce.isNotEmpty) {
        for (var r in responce) {
          localDataHome.saveTopRatedToLocalSql(r);
        }
      }
      return responce;
    } else {
      return localDataHome.getTopRatedMovie();
    }
  }

  @override
  Future<List<Movie>> getPopularMovie() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var responce = await remoteDataHome.getPupolarRemoteMovie();

      // var MovieDataTomovie = responce.map((e) => e);
      // var movieJson = json.encode(MovieDataTomovie.map((e) => e));

      if (responce != null && responce != null && responce.isNotEmpty) {
        for (var r in responce) {
          localDataHome.saveTopRatedToLocalSql(r);
        }
      }
      return responce;
    } else {
      return localDataHome.getPopularMovie();
    }
  }
}
