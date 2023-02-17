import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/details/similir_container.dart';
import 'package:provider/provider.dart';
import '../data/api/api_details.dart';
import '../data/api/links_api_util.dart';
import '../data/database/sql_database.dart';
import '../model/DetailData.dart';
import '../model/movie.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/components.dart';
import '../utilities/widgets/future_waiting_error.dart';
import '../utilities/widgets/image_stack_widget.dart';

class DetailScreen extends StatelessWidget {
  static String routeName = "DetailScreen";

  SQLiteDB sqLiteDB = SQLiteDB();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Movie;

    var provider = Provider.of<ProviderSqlMovie>(context);
    provider.flagListCheckOrNot() ;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(args.title!),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DetailData>(
            future: ApiDetails.getDetails(args.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingballScaleRippleMultiple();
              } else if (snapshot.hasError) {
                return noInternetConnection(context);
              }

              List<String?> geners =
                  snapshot.data?.genres!.map((g) => g.name).toList() ?? [];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    imageUrl:"$imageLink${snapshot.data?.backdropPath}" ?? "",
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          margin: EdgeInsets.all(15),
                          height: 180,width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,),
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(),
                  ),
                  Text(
                    snapshot.data?.title ?? "",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    snapshot.data?.releaseDate ?? "",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    height: 230,
                    child: Row(
                      children: [
                        ImageStackWidget(
                          //  height: 200,
                            isAddedToWatch: provider.watchedList.contains(args.id) ,
                            posterPath :"${ApiLinksUtl.Image_link}${snapshot.data?.posterPath}" ,
                            addToDB: () async {
                              var id = snapshot.data?.id;
                              //flag From LOCAL Sql If The User Watched It Or Not
                              if (! provider.watchedList.contains(args.id)) {
                                var update = await sqLiteDB.updateData(
                                    id: id!, isWatched: true );
                                print(update);
                              } else {
                                var update = await sqLiteDB.updateData(
                                    id: id!, isWatched: false,);
                                print(update);
                                  //remove the flag checked from UI
                                  provider.watchedList
                                      .removeWhere((element) => element == id);
                                  provider.watchedList.remove( id);
                              }
                              //provider.isWhatched = true;
                            },
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    height: 40,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: geners.length,
                                        itemBuilder: (context, index) {
                                          // List<String?> gener= snapshot.data?.genres!.map((g) => g.name);
                                          return Container(
                                              height: 10,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .cardColor)),
                                              child: Center(
                                                  child: Text(
                                                geners[index]!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              )));
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      snapshot.data?.overview ?? "",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                          snapshot.data!.voteAverage.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("${snapshot.data!.voteCount} vote",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<MovieData>(
                      future: ApiDetails.getSimilar(args.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return noInternetConnection(context);
                        }
                        return Container(
                            color: Theme.of(context).canvasColor,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "More Like This",
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Container(
                                    height:   MediaQuery.of(context) .size .height / 4,
                                    child: SimilarListContiner(
                                      movielis: snapshot.data,
                                    )
                                  )
                                ]));
                      })
                ],
              );
            }),
      ),
    );
  }
}

// Row(
// children:
// snapshot.data?.results[0].genres.generate(1 , (index)
// {
// print(args.genres?.toList());
// return
// Container(
// decoration: BoxDecoration(
// color: Theme.of(context).primaryColor,
// borderRadius: BorderRadius.all(Radius.circular(20)),
// border: Border.all(color: Theme.of(context).cardColor)
// ),
// child: Text(snapshot.data?.results?[index].genres, style: Theme.of(context).textTheme.headline1,));
// }),
// )
