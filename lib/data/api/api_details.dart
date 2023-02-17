
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../model/DetailData.dart';
import '../../model/movie.dart';
import 'links_api_util.dart';

class ApiDetails{



  static Future<DetailData> getDetails(int id)async{

      var url = Uri.https("${ApiLinksUtl.BASE_URL}" , "/3/movie/$id",
          {
            'api_key': ApiLinksUtl.API_KEY,
          }
      );
      print(url);
      try {
        var respondse = await http.get(url);
        var bodyString = respondse.body;
        var json = jsonDecode(bodyString);
        return DetailData.fromJson(json);
      }
      catch(e){
        throw e ;
      }

    }


    static Future<MovieData> getSimilar(int id)async{

      print("getDetails");

      var url = Uri.https("${ApiLinksUtl.BASE_URL}" , "/3/movie/$id/similar",
          {
            'api_key': ApiLinksUtl.API_KEY,
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




