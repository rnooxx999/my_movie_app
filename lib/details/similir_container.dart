

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_widget.dart';
import '../model/movie.dart';
import '../providers/provider_watch_list.dart';

class SimilarListContiner extends StatefulWidget {
   MovieData? movielis ; bool? isWatched;
   SimilarListContiner({ this.movielis ,this.isWatched });

  @override
  State<SimilarListContiner> createState() => _SimilarListContinerState();
}

class _SimilarListContinerState extends State<SimilarListContiner> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderSqlMovie>(context);
    provider.flagListCheckOrNot() ;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movielis?.results?.length ,
        itemBuilder: (context, index) {
          var movieList = widget.movielis?.results![index];
          //print(snapshot.data!.results![index]);
          return HomeCardWidget(
            movie: movieList,
            title: movieList?.title,
            voteAverage: movieList?.voteAverage,
            posterPath: movieList?.posterPath,
            movieId: movieList,
            id: movieList?.id,
            isWatched: provider.watchedList.contains(movieList?.id)
          );
        });
  }
}
