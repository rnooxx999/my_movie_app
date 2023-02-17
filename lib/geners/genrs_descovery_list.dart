import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/movie.dart';
import 'package:provider/provider.dart';

import '../data/api/api_category.dart';
import '../data/database/sql_database.dart';
import '../model/Genres.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/components.dart';
import '../utilities/widgets/future_waiting_error.dart';
import 'discovery_widget.dart';

class GenresDescoveryList extends StatefulWidget {

  @override
  State<GenresDescoveryList> createState() => _GenresDescoveryListState();
}

class _GenresDescoveryListState extends State<GenresDescoveryList> {
  SQLiteDB sqLiteDB = SQLiteDB();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderSqlMovie>(context);
    provider.flagListCheckOrNot();

    var args = ModalRoute.of(context)?.settings.arguments as Genres;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name ?? ""),
      ),
      body: FutureBuilder<MovieData>(
          future: CategoryApi.getDescoveryGenersList(args.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingballScaleRippleMultiple();
            } else if (snapshot.hasError) {
              return noInternetConnection(context);
            }

            return ListView.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data!.results![index].id;
                  bool isWatched = provider.watchedList
                      .contains(snapshot.data!.results![index].id);
                  return

                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(routeNameDetailScreen
                            ,arguments: snapshot.data!.results![index]);
                      },
                      child: DiscoveryWidget(
                      isAddedOrNot: isWatched,
                      AddToWatchList: () async {
                        setState(() {

                        });
                        if (isWatched == false) {
                          var update =
                              await sqLiteDB.updateData(id: id!, isWatched: true
                              ,movie: snapshot.data!.results![index]);
                          print(update);
                        } else {
                          var update = await sqLiteDB.updateData(
                              id: id!, isWatched: false);
                          print(update);
                          //remove the flag checked from UI
                          provider.watchedList
                              .removeWhere((element) => element == id);
                          provider.watchedList.remove(id);
                        }
                        //provider.isWhatched = true;
                      },

                      // movieId:snapshot.data!.results![index].id!,
                      title: snapshot.data!.results![index].title!,
                      date: snapshot.data!.results![index].releaseDate!,
                      overview: "dfswfswfc",
                      posterPath: snapshot.data!.results![index].posterPath!,
                  ),
                    );
                });
          }),
    );
  }
}
