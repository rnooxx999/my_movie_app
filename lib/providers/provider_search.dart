import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api/links_api_util.dart';
import '../model/movie.dart';
import 'package:http/http.dart' as http;

import '../utilities/components.dart';

class SearchProvider extends ChangeNotifier {
  // SearchBloc(super.initialState);
  StreamController<List<Movie>?> searchTitle = StreamController.broadcast();
  List<Movie> searchTotalTitle = [];
  StreamSink<List<Movie>?> get sinkSearchTitle => searchTitle.sink;
  Stream<List<Movie>?> get streamSearchTitle => searchTitle.stream;

  // final searchTitleString = StreamController<String>.broadcast();

  // Stream searchT = Stre

  //static Stream<AsyncSnapshot<List<Movie>?>> = [];

  Future<List<Movie>> getAllCharacters(String q) async {
    var url = Uri.https("$linkApi", "/3/search/movie",
        {'api_key': linkApiKEY, 'query': q});
    print(url);
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      //for(int i = 0 ; i >  )
      //json = json.decode(json.body);
      // var  data = json['results'][0];
      // for ( var item in json['results']){
      //print(item);
      // totalTitle.add(
      //     Movie.fromJson(item)
      // );
      final Iterable data = json['results'];
      //}
      var searchTotal =
          data.map((character) => Movie.fromJson(character)).toList();
      print(data);
      sinkSearchTitle.add(searchTotal);
      return searchTotal;
    } catch (e) {
      throw e;
    }
  }

  void getSearchQueryWithResult(String searchQuery) {
    getAllCharacters(searchQuery);

    final List<Movie> searchResult = [];
    searchTitle.sink.add(null);
    if (searchQuery.isEmpty) {
      return;
    }
    for (final streamMovie in searchTotalTitle) {
      if (streamMovie.title!
          .toLowerCase()
          .contains(searchQuery.toLowerCase())) {
        searchResult.add(streamMovie);
      }
    }
    sinkSearchTitle.add(searchResult);
  }

  @override
  void dispose() {
    searchTitle.close();
  }
}

