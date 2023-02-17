
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../model/Genres.dart';
import '../../model/movie.dart';
import 'links_api_util.dart';


class CategoryApi{

    static Future<GenresData> getMoviesGenersList()async{


      print("getDetails");

      var url = Uri.https("${ApiLinksUtl.BASE_URL}" , "3/genre/movie/list",
          {
            'api_key': ApiLinksUtl.API_KEY,
          }
      );
      print(url);
      try {
        var respondse = await http.get(url);
        var bodyString = respondse.body;
        var json = jsonDecode(bodyString);
        return GenresData.fromJson(json);
      }
      catch(e){
        throw e ;
      }

    }




    static Future<MovieData> getDescoveryGenersList(int genresId)async{

      var url = Uri.https("${ApiLinksUtl.BASE_URL}" , "3/discover/movie",
          {
            'api_key': ApiLinksUtl.API_KEY,
            'with_genres' : "$genresId"
          }
      );
      print(url);
      try {
        var respondse = await http.get(url);
        var bodyString = respondse.body;
        var json = jsonDecode(bodyString);
        return MovieData.fromJson(json);
      }
      catch(e){
        throw e ;
      }

    }




}