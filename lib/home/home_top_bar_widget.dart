import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/database/sql_database.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/components.dart';
import '../utilities/widgets/future_waiting_error.dart';
import '../utilities/widgets/image_stack_widget.dart';

class HomeTopBarMovie extends StatefulWidget {

  String? title ,posterPath, backgroundImage;
  bool? isWatched;
  int? id;

  HomeTopBarMovie(
      {required this.title,
      this.id,
      this.isWatched,
      required this.posterPath,
      required this.backgroundImage});

  @override
  State<HomeTopBarMovie> createState() => _HomeTopBarMovieState();
}

SQLiteDB sqLiteDB = SQLiteDB();

class _HomeTopBarMovieState extends State<HomeTopBarMovie> {
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderSqlMovie>(context);

    return Container(
      color: Colors.black87,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            children: [
              //background catch backgroundImage or black Container
              CachedNetworkImage(
                imageUrl:"$imageLink${widget.backgroundImage}" ?? "",
                imageBuilder: (context, imageProvider) =>
                    Container(
                      margin: EdgeInsets.all(15),
                      height: 160,width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,),
                      ),
                    ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Container(),
              ),

              Container(height: 16)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ImageStackWidget(
                    id: widget.id,
                    isAddedToWatch: widget.isWatched,
                    posterPath: widget.posterPath,
                    addToDB: () async {
                      //flag From LOCAL Sql If The User Watched It Or Not
                      if (widget.isWatched == false) {
                        var update = await sqLiteDB.updateData(
                            id: widget.id!, isWatched: true);
                        print("not watched so added to Whatch List = $update");
                        setState(() {});
                      } else {
                        var update = await sqLiteDB.updateData(
                            id: widget.id!, isWatched: false);
                        print("watched so remove it from Whatch List = $update");
                        setState(() {
                          //remove the flag checked from UI
                          provider.watchedList
                              .removeWhere((element) => element == widget.id);
                          provider.watchedList.remove(widget.id);
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(widget.title ?? "",
                        style: Theme.of(context).textTheme.headline2),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
