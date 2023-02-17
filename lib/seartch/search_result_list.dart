import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database/sql_database.dart';
import '../geners/discovery_widget.dart';
import '../model/movie.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/components.dart';

class SearchResultsLists extends StatefulWidget{
  List<Movie>? movie;
   SearchResultsLists({required this.movie});

  @override
  State<SearchResultsLists> createState() => _SearchResultsListsState();
}

class _SearchResultsListsState extends State<SearchResultsLists> {
  SQLiteDB sqLiteDB = SQLiteDB();


  @override
  Widget build(BuildContext context) {
    var provSql = Provider.of<ProviderSqlMovie>(context);
    provSql.flagListCheckOrNot() ;


    return ListView.builder(
        itemCount: widget.movie?.length,
        itemBuilder: (BuildContext context, int index) {
          bool isWatched = provSql.watchedList
              .contains(widget.movie?[index].id);

          return InkWell(
              onTap: (){
            Navigator.of(context).pushNamed(routeNameDetailScreen,arguments: widget.movie?[index]
            );
          },
          child:  DiscoveryWidget(
              AddToWatchList: () async {
                setState(() {
                });
                if (isWatched == false) {
                  var update =
                  await sqLiteDB.updateData(id: widget.movie?[index].id ?? 0 ,
                      isWatched: true
                      ,movie: widget.movie?[index]);
                  print(update);
                } else {
                  var update = await sqLiteDB.updateData(
                      id: widget.movie?[index].id ?? 0, isWatched: false);
                  print(update);
                  //remove the flag checked from UI
                  provSql.watchedList .removeWhere((element) => element == widget.movie?[index].id);
                  provSql.watchedList.remove(widget.movie?[index].id);
                }
                //provider.isWhatched = true;
              },
              posterPath: widget.movie?[index].posterPath ?? "",
              title: widget.movie?[index].title ?? "",
              date: widget.movie?[index].releaseDate ?? "",
              overview: widget.movie?[index].overview ?? ""));
        }
    );
  }
}
