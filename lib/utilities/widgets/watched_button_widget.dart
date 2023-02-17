

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/movie.dart';
import '../../providers/provider_watch_list.dart';

class WatchedButtonSQLWidget extends StatelessWidget {
  VoidCallback addToDB ;
  bool? isAddedToWatch ;


  WatchedButtonSQLWidget({
    required this.addToDB , this.isAddedToWatch }) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
            child:
             Container(
              margin: const EdgeInsets.all(4),
              height: 20,width: 20,
              color: isAddedToWatch??false   ?  Colors.yellow :Theme.of(context).canvasColor ,
              child: Center(
                child: Text(
                  isAddedToWatch??false   ?
                    "✔" : "+" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
              ),
            ),
            onTap: (addToDB)
        );
      }


}


