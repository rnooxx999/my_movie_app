import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database/sql_database.dart';
import '../model/movie.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/widgets/future_waiting_error.dart';
import '../utilities/widgets/image_stack_widget.dart';

class HomeCardWidget extends StatefulWidget {
   Movie? movie ;
  String? title, date, overview ,posterPath, status;
  dynamic? voteAverage;
  bool? isRelased, isWatched;
  int? id;

  HomeCardWidget(
      {required this.title, this.movie,
      this.isRelased = true,
      required this.posterPath,
      required this.voteAverage,
      movieId,
      status,
      required this.id,
      this.date,
      this.overview,
      this.isWatched});

  @override
  State<HomeCardWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends State<HomeCardWidget> {

  SQLiteDB sqLiteDB = SQLiteDB();

  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderSqlMovie>(context);

    return Container(
      margin: const EdgeInsets.all(6),
      color: Theme.of(context).cardColor,
      height: 210,
      width: 120,
      child: SingleChildScrollView(
        child: Column(children: [
          ImageStackWidget(
            id: widget.id,
            isAddedToWatch: widget.isWatched,
            posterPath: widget.posterPath,
            addToDB: () async {
              //flag From LOCAL Sql If The User Watched It Or Not
              if (widget.isWatched == false) {
                var update = await sqLiteDB.updateData(
                    id: widget.id!, isWatched: true , movie: widget.movie);
                print(update);
                setState(() {});
              } else {
                print("not isWatched");
                var update = await sqLiteDB.updateData(
                    id: widget.id!, isWatched: false,movie: widget.movie);
                print(update);
                setState(() {
                  //remove the flag checked from UI
                  provider.watchedList
                      .removeWhere((element) => element == widget.id);
                  provider.watchedList.remove(widget.id);
                });
              }
              //provider.isWhatched = true;
            },
          ),
          (widget.isRelased == true
              ? Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(widget.voteAverage.toString(),
                          style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                )
              : Text(widget.status ?? "released",
                  style: TextStyle(color: Colors.grey.shade300))),
          Text(
            widget.title ?? "",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
