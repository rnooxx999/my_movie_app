


import 'package:movies_app/model/movie.dart';
import 'package:movies_app/providers/provider_watch_list.dart';

import '../../../database/sql_database.dart';
import 'local_data_home.dart';

class LocalDataHomeIMPL implements LocalDataHome{
  SQLiteDB sqLiteDB = SQLiteDB();
  @override
  Future<List<Movie>> getTopRatedMovie() {
   return ProviderSqlMovie().readDataForRepoLocal();
  }

  @override
  saveTopRatedToLocalSql( movieJson) {
    return ProviderSqlMovie().insertDataToSqlFromApi(movieJson );
  }

  @override
  Future<List<Movie>> getPopularMovie() {
    return ProviderSqlMovie().readDataForRepoLocal();
  }

  @override
  savePopularToLocalSql( movieJson) {
    return ProviderSqlMovie().insertDataToSqlFromApi(movieJson );
  }

}