
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database/sql_database.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/widgets/future_waiting_error.dart';
import '../utilities/widgets/image_stack_widget.dart';
import '../utilities/widgets/watched_button_widget.dart';

class DiscoveryWidget extends StatelessWidget{
  String posterPath;
  String title;
  String overview;
  String date;
  int? movieId;
  bool? isAddedOrNot;
  VoidCallback AddToWatchList;

  DiscoveryWidget({
    this.isAddedOrNot, required this.AddToWatchList,
    required this.posterPath ,required this.title, this.movieId,
    required this.date ,required this.overview,

  }) ;

  VoidCallback? idIsLoading;

  StreamController<List<Map>> addToWatch = StreamController<List<Map>>.broadcast();

  SQLiteDB sqLiteDB = SQLiteDB();

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(children: [
                ImageStackWidget(

                  isAddedToWatch: isAddedOrNot,
                  posterPath :posterPath ,addToDB: (AddToWatchList)
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(title ,style: Theme.of(context).textTheme.headline1, textHeightBehavior: TextHeightBehavior(),),
                    Text(date ,style: Theme.of(context).textTheme.headline2, ),
                    Text(overview ,style: Theme.of(context).textTheme.headline2, ),

                  ],),
                )
              ],),
            ),
          ),
          Divider(thickness: 3,color: Colors.grey,)
        ],
    );
  }
}
