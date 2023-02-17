

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/database/sql_database.dart';
import 'package:movies_app/model/movie.dart';
import 'package:provider/provider.dart';

import '../geners/discovery_widget.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/widgets/future_waiting_error.dart';
import '../utilities/widgets/watched_button_widget.dart';

class WatchedListScreen extends StatefulWidget {
  @override
  State<WatchedListScreen> createState() => _WatchedListScreenState();
}

//bring data just from SQL LOCAL DATA

class _WatchedListScreenState extends State<WatchedListScreen> {
  //WatchedListScreen({Key? key}) : super(key: key);
  SQLiteDB sqLiteDB = SQLiteDB();

  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderSqlMovie>(context);
    provider.flagListCheckOrNot();

    return Scaffold(
        body: FutureBuilder<List<Map>>(
            future: provider.readAllDataFromWatchList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingballScaleRippleMultiple();
              }
              else if (snapshot.hasError) {
                return noInternetConnection(context);
              }
             // print(snapshot.data!.results![1]);
              return Container(
                  //height: 195,
                  child: ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String title = snapshot.data![index]['title'];
                        //int movieId= provider.watchedList[index]['movie_id'];
                        String date = snapshot.data![index]['release_date'];
                        String posterPath = snapshot.data![index]['poster_path'];
                        String overview = "gcghdxb";
                        int id = snapshot.data![index]['id'];

                        //print(snapshot.data?.genres![3].name);
                        return
                          DiscoveryWidget(
                            isAddedOrNot: true,
                              title: title,
                              // movieId: movieId,
                              date: date,
                              overview: overview,
                              posterPath: posterPath,
                            AddToWatchList : () async {
                              var update = await sqLiteDB.updateData(
                                  id: id, isWatched: false);
                              print(update);
                              setState(() {
                                //remove the flag checked from UI
                                provider.watchedList.removeWhere((element) => element == id);
                                provider.watchedList.remove(id);
                              });

                            },
                          );
                      })


              );
            }));

  }
}