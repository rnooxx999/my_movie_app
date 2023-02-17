
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/repo/repo_home_impl.dart';
import 'package:movies_app/utilities/widgets/watched_button_widget.dart';

import '../../data/api/links_api_util.dart';
import '../../data/database/sql_database.dart';
import '../components.dart';

class ImageStackWidget extends StatefulWidget{
  String? posterPath;
  VoidCallback addToDB ;
  bool? isAddedToWatch;
  int? id;


  ImageStackWidget({
    this.id,
    required this.posterPath, required this.addToDB, this.isAddedToWatch });

  @override
  State<ImageStackWidget> createState() => _ImageStackWidgetState();
}

class _ImageStackWidgetState extends State<ImageStackWidget> {

  @override
  void initState() {
    widget.isAddedToWatch;
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        widget.posterPath != null  ?
        CachedNetworkImage(
    imageUrl: "$imageLink${widget.posterPath}",
        imageBuilder: (context, imageProvider) =>
            Container(
              height: 120, width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,),
                border: Border.all(color: Colors.grey)),

          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset(
              "assets/found.png", height: 120, width: 120,fit: BoxFit.fill,),
        )
            :
        Image.asset("assets/found.png", height: 120, width: 120,fit:BoxFit.fill,
        ),
        WatchedButtonSQLWidget(
          addToDB:( widget.addToDB), isAddedToWatch: widget.isAddedToWatch ,)
      ],);
  }


}