import 'package:movies_app/model/Genres.dart';
import 'package:sqflite/sqflite.dart';
import 'movie.dart';

class MovieData {
  MovieData({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,});

  MovieData.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Movie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results!.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

}


class Movie {

  int? id;
  String? overview;
  String? title;
  String? posterPath;
  String? backdropPath;
  String? releaseDate;
  int? isWatched ;
 // List<int>? genres;
  List? genres;

  dynamic? voteAverage;
  dynamic? voteCount;

  Movie({
    required this.id ,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.genres,
    required this.voteAverage,
    required this.voteCount,
    this.isWatched = 0
  });

  Movie.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    title=  json['title'] ;
    backdropPath=json['backdrop_path'];
  posterPath= json['poster_path'] ;
  releaseDate= json['release_date'] ;
  overview= json['overview'] ;
  genres= json['genre_ids'] ;
  voteCount= json['vote_count'] ;
  voteAverage= json['vote_average' ];
    isWatched=json['is_watched'] ;

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'overview': overview,
      'genre_ids': genres,
      'vote_count': voteCount,
      'vote_average': voteAverage,
      'backdrop_path' : backdropPath,
      'is_watched' : isWatched = 0
    };
  }

}