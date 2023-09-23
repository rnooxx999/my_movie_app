import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/model/movie.dart';

import '../../model/DetailData.dart';
import '../database/sql_database.dart';
import 'links_api_util.dart';

class ApiHome {
  String popular = "movie/popular";
  String latest = "movie/latest";
  String topRated = "movie/top_rated";



  static Future<List<Movie>> gePopularMovies() async {
    List<Movie> movie = [];

    var url = Uri.https("${ApiLinksUtl.BASE_URL}", "/3/movie/popular", {
      'api_key': ApiLinksUtl.API_KEY,
    });
    print(url);
    try {
      http.Response respondse = await http.get(url);
      var bodyString = respondse.body;
      print(bodyString);
      var jsonMovie = jsonDecode(bodyString);
      for (var item in jsonMovie['results']) {
        movie.add(Movie.fromJson(item));
      }
      //var responce = await sqLiteDB.readData("SELECT * FROM watched WHERE (is_watched = true AND id = $id)");
      //List thissss=  thiss.values.map((e) => e).toList();
      //print("oopppppwopooooopppppppp $thissss");
      return movie;
    } catch (e) {
      throw e;
    }
  }

  static Future<DetailData> getLatestMovies() async {
    //مثال على الرابط:

    var url = Uri.https("${ApiLinksUtl.BASE_URL}", "/3/movie/latest", {
      'api_key': ApiLinksUtl.API_KEY,
    });
    try {
      var respondse = await http.get(url);
      var bodyString = respondse.body;
      var json = jsonDecode(bodyString);

      return DetailData.fromJson(json);
    } catch (e) {
      throw e;
    }
  }


  static Future<List<Movie>> getListTopRatedMovies() async {
    List<Movie> movie = [];

    var url = Uri.https("${ApiLinksUtl.BASE_URL}", "/3/movie/top_rated", {
      'api_key': ApiLinksUtl.API_KEY,
    });
    try {
      http.Response respondse = await http.get(url);
      var bodyString = respondse.body;
      print(bodyString);
      var jsonMovie = jsonDecode(bodyString);
      var jso = jsonMovie["results"];
      for (var item in jsonMovie['results']) {
        movie.add(Movie.fromJson(item));
      }

      //var responce = await sqLiteDB.readData("SELECT * FROM watched WHERE (is_watched = true AND id = $id)");
      //List thissss=  thiss.values.map((e) => e).toList();
      //print("oopppppwopooooopppppppp $thissss");
      return movie;
    } catch (e) {
      throw e;
    }
  }
}
